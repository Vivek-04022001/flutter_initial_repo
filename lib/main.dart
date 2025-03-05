import 'package:f5_billion/api/api_service.dart';
import 'package:f5_billion/features/authentication/state/auth_provider.dart';
import 'package:f5_billion/features/no_internet/state/connectivity_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'routes/app_router.dart'; // Import your custom AppRouter

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService.init();
  runApp(const MyApp());
}

void myFunction() {
  // Your normal void function code here
  print('This is a normal void function');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityNotifier()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sizer Demo')),
      body: Center(
        child: Text('Hello, Sizer!', style: TextStyle(fontSize: 12.sp)),
      ),
    );
  }
}
