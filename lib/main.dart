import 'package:aqar_hub_gp/core/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Dependencies
  await initializeDependencies();

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const AqarHubApp());
}

class AqarHubApp extends StatelessWidget {
  const AqarHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'AqarHub - Real Estate Platform',

          // Theme Configuration
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: const Color(0xFF1B4B8C),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Cairo',

            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1B4B8C),
              brightness: Brightness.light,
            ),

            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
          ),

          // Routing Configuration
          routerConfig: router,
        );
      },
    );
  }
}
