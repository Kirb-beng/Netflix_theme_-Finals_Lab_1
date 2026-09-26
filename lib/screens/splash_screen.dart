import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../theme/route_transitions.dart';
import '../theme/netflix_theme.dart';
import '../theme/responsive.dart';

/// Plays the classic red "ta-dum" Netflix intro animation
/// (assets/images/netflix_intro.gif) once, then fades into the
/// Login screen. This is the app's simple splash/loading animation.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    // Give the gif enough time to play through, then move on to Login.
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        netflixFadeRoute(const LoginScreen(), const RouteSettings(name: '/login')),
      );
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gifWidth = Responsive.isMobile(context) ? 280.0 : 420.0;
    return Scaffold(
      backgroundColor: NetflixColors.black,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Image.asset(
            'assets/images/netflix_intro.gif',
            width: gifWidth,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
