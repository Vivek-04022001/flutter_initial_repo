import 'package:f5_billion/constants/app_colors.dart';
import 'package:f5_billion/features/authentication/state/auth_provider.dart';
import 'package:f5_billion/utils/utils.dart';
import 'package:f5_billion/widgets/custom_textFormField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onRegisterClick});
  final VoidCallback onRegisterClick;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isRemember = false;

  // void _handleFirebaseSignin() async {
  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   if (!(authProvider.loginFormKey.currentState?.validate() ?? false)) {
  //     Utilits.showToast('Please fix the errors in red before submitting.');
  //     return;
  //   }
  //   await authProvider.signin();
  //   if (authProvider.errorMessage!.isNotEmpty) {
  //     Utilits.showToast(authProvider.errorMessage!);
  //     _clearControllers();
  //   }

  //   if (mounted && authProvider.user != null) {
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       Routes.HOME,
  //       (route) => false,
  //       arguments: {'animate': true},
  //     );
  //     Future.microtask(() => _clearControllers());
  //   }
  // }

  void _clearControllers() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loginEmailController.clear();
    authProvider.loginPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Logo
              // Image.asset(AppImages.logoWithoutBg, width: 70)
              //     .animate()
              //     .fadeIn(duration: 500.ms)
              //     .slideY(begin: -0.5, end: 0.0, duration: 800.ms),
              SizedBox(height: 2.h),

              // Login Card
              Container(
                width: 90.w,
                height: 70.h,
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha(30),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Form(
                      key: authProvider.loginFormKey,
                      child: Column(
                        children: [
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return CustomTextField(
                                label: 'Email',
                                hintText: 'Enter your email',
                                controller: authProvider.loginEmailController,
                                disabled: authProvider.isLoading,
                              );
                            },
                          ),
                          SizedBox(height: 1.h),

                          // Password Field
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return CustomTextField(
                                label: "Password",
                                hintText: "Enter your password",
                                isPassword: true,
                                disabled: authProvider.isLoading,
                                controller:
                                    authProvider.loginPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password cannot be empty";
                                  } else if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 1.h),
                        ],
                      ),
                    ),

                    // Email Field

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isRemember,
                              checkColor: AppColors.accentColor,
                              fillColor: WidgetStateProperty.all(
                                AppColors.white,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  authProvider.setRememberMe(value);
                                  setState(() {
                                    _isRemember = value;
                                  });
                                }
                              },
                            ),
                            Text(
                              "Remember me",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              color: AppColors.purple,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    // Sign Up Button
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return GestureDetector(
                          onTap: authProvider.isLoading == true ? null : null,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                authProvider.isLoading
                                    ? Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                          strokeWidth: 1,
                                        ),
                                      ),
                                    )
                                    : Text(
                                      "Sigin",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 2.h),

                    // Sign In Link
                    GestureDetector(
                      onTap: widget.onRegisterClick,
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            color: AppColors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
