import 'package:flutter/material.dart';
import '../theme/netflix_theme.dart';

/// Full-bleed background that mimics the reference screenshot:
/// the movie/show poster collage (assets/images/netflix_bg.jpg)
/// darkened with a gradient scrim so the white/red UI stays readable
/// on top, exactly like Netflix's real Login and Sign-Up pages.
class NetflixBackground extends StatelessWidget {
  final Widget child;
  const NetflixBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/netflix_bg.jpg',
          fit: BoxFit.cover,
        ),
        // Dark scrim so text/inputs stay legible over busy poster art,
        // matching the shadow Netflix lays over its own collage.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                NetflixColors.black.withOpacity(0.55),
                NetflixColors.black.withOpacity(0.75),
                NetflixColors.black.withOpacity(0.92),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

/// The red "NETFLIX" wordmark used at the top of every screen.
class NetflixLogo extends StatelessWidget {
  final double fontSize;
  const NetflixLogo({super.key, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return Text(
      'NETFLIX',
      style: NetflixTextStyles.logo.copyWith(fontSize: fontSize),
    );
  }
}

/// Simple reusable fade + rise-in animation, used to animate the
/// Login/Sign-Up form cards and the Home screen content into view.
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _opacity = curved;
    _offset = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(curved);

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
