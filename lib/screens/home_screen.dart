import 'package:flutter/material.dart';
import '../theme/netflix_theme.dart';
import '../theme/responsive.dart';
import '../widgets/netflix_background.dart';
import '../widgets/poster_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The name passed as route arguments from Login or Sign-Up.
    final args = ModalRoute.of(context)?.settings.arguments;
    final String displayName =
        (args is String && args.trim().isNotEmpty) ? args.trim() : 'there';

    return Scaffold(
      backgroundColor: NetflixColors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Netflix-style top app bar with logo + profile avatar.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NetflixLogo(fontSize: Responsive.logoFontSize(context) - 6),
                  Row(
                    children: [
                      const Icon(Icons.search, color: NetflixColors.white),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: NetflixColors.red,
                        child: Text(
                          displayName.isNotEmpty
                              ? displayName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: NetflixColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero banner using the real Netflix collage image,
                    // fading straight into the black page background —
                    // just like the browse screen's featured-title hero.
                    FadeSlideIn(
                      child: SizedBox(
                        height: Responsive.heroHeight(context),
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/netflix_bg.jpg',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    NetflixColors.black.withOpacity(0.85),
                                    NetflixColors.black,
                                  ],
                                  stops: const [0.2, 0.85, 1.0],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              right: 20,
                              bottom: 20,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 560),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome, $displayName!',
                                      style: NetflixTextStyles.heading,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'You are now signed in.',
                                      style: NetflixTextStyles.greyBody,
                                    ),
                                    const SizedBox(height: 14),
                                    _LogoutButton(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 150),
                      child: _buildRow(context, 'Trending Now'),
                    ),
                    const SizedBox(height: 28),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 300),
                      child: _buildRow(context, 'Because You Watched'),
                    ),
                    const SizedBox(height: 28),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 450),
                      child: _buildRow(context, 'New Releases'),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A horizontally-scrolling row of stylized "poster" tiles (original
  /// gradients + made-up titles — no real movie/show artwork) to give
  /// the Home screen that familiar Netflix browsing feel.
  /// Tile size scales up on wider (desktop-size) Chrome windows.
  Widget _buildRow(BuildContext context, String rowTitle) {
    final tileWidth = Responsive.posterTileWidth(context);
    final tileHeight = Responsive.posterTileHeight(context);
    final titles = posterTitlesByRow[rowTitle] ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            rowTitle,
            style: const TextStyle(
              color: NetflixColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: tileHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: titles.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return PosterTile(
                title: titles[index],
                gradient: posterGradients[index % posterGradients.length],
                width: tileWidth,
                height: tileHeight,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: NetflixColors.red,
        foregroundColor: NetflixColors.white,
        minimumSize: const Size(160, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
      onPressed: () {
        // Navigator method: pushNamedAndRemoveUntil
        // Clears the whole stack (Home, Sign-Up, etc.) and drops the
        // user back at a fresh Login screen.
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      },
      icon: const Icon(Icons.logout, size: 18),
      label: const Text('Logout'),
    );
  }
}
