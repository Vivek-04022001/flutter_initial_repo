import 'package:f5_billion/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final bool disabled;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final int? maxLength;
  final TextInputType inputType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.icon,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.prefixWidget,
    this.suffixWidget,
    this.readOnly = false,
    this.onTap,
    this.disabled = false,
    this.maxLength,
    this.inputType = TextInputType.text,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    Widget? prefixIcon;
    if (widget.prefixWidget != null) {
      prefixIcon = widget.prefixWidget;
    } else if (widget.icon != null) {
      prefixIcon = Icon(widget.icon, color: Colors.grey);
    }

    Widget? suffixIcon;
    if (widget.isPassword) {
      suffixIcon = IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    } else if (widget.suffixWidget != null) {
      suffixIcon = widget.suffixWidget;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 0.8.h),

        // TextFormField
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _isObscured : false,
          cursorColor: AppColors.grey,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          enabled: !widget.disabled,
          maxLength: widget.maxLength,
          keyboardType: widget.inputType,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            color: AppColors.blackText,
          ),
          decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: AppColors.grey,
            ),
            filled: true,
            fillColor: AppColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
          ),
          onChanged: (value) {
            if (widget.validator != null) {
              setState(() {
                _errorText = widget.validator!(value);
              });
            }
          },
        ),

        // Error message
        Container(
          height: 20, // Adjust the height as needed
          padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
          child:
              _errorText != null && _errorText!.isNotEmpty
                  ? Text(
                    _errorText!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: Colors.red,
                    ),
                  )
                  : null,
        ),
      ],
    );
  }
}
