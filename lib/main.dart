import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'theme/netflix_theme.dart';
import 'theme/route_transitions.dart';

void main() {
  runApp(const NetflixCloneApp());
}

class NetflixCloneApp extends StatelessWidget {
  const NetflixCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: NetflixColors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: NetflixColors.red,
          brightness: Brightness.dark,
          primary: NetflixColors.red,
        ),
        fontFamily: 'Roboto',
      ),
      // Every screen is registered as a named route, as required by
      // the lab: "Define all screens as named routes in your
      // MaterialApp (e.g., using the routes property or
      // onGenerateRoute)." Each route is wrapped in netflixFadeRoute so
      // every screen-to-screen transition gets the same simple
      // fade + slide-up animation.
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return netflixFadeRoute(const SplashScreen(), settings);
          case '/login':
            return netflixFadeRoute(const LoginScreen(), settings);
          case '/signup':
            return netflixFadeRoute(const SignUpScreen(), settings);
          case '/home':
            return netflixFadeRoute(const HomeScreen(), settings);
          default:
            return netflixFadeRoute(const LoginScreen(), settings);
        }
      },
    );
  }
}
