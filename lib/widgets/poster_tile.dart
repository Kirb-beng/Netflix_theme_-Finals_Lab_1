import 'package:flutter/material.dart';
import '../theme/netflix_theme.dart';

/// A set of colorful gradient pairs used to paint each poster tile,
/// so the Home screen row looks lively without using any real,
/// copyrighted movie/show poster art.
const List<List<Color>> posterGradients = [
  [Color(0xFF8E0E00), Color(0xFF1F1C18)],
  [Color(0xFF1F4037), Color(0xFF99F2C8)],
  [Color(0xFF360033), Color(0xFF0B8793)],
  [Color(0xFF3A1C71), Color(0xFFD76D77)],
  [Color(0xFF232526), Color(0xFF414345)],
  [Color(0xFF0F2027), Color(0xFF2C5364)],
  [Color(0xFF7F00FF), Color(0xFF3B0764)],
  [Color(0xFFB79891), Color(0xFF94716B)],
  [Color(0xFF485563), Color(0xFF29323C)],
  [Color(0xFFC94B4B), Color(0xFF4B134F)],
];

/// Original, made-up titles (no relation to any real Netflix title) so
/// each row has readable text without borrowing real IP.
const Map<String, List<String>> posterTitlesByRow = {
  'Trending Now': [
    'Crimson Trail',
    'Neon Nights',
    'Silver Horizon',
    'Echoes of Dawn',
    'The Last Signal',
    'Glass Kingdom',
    'Paper Tigers',
    'Midnight Runway',
  ],
  'Because You Watched': [
    'Static Bloom',
    'Wolf Hour',
    'Amber Road',
    'Faultline',
    'The Quiet Storm',
    'Hollow Point',
    'Velvet Static',
    'Borrowed Light',
  ],
  'New Releases': [
    'Iron Season',
    'Afterglow',
    'The Long Drift',
    'Ashen Coast',
    'Pale Fire',
    'Nightshade Ave',
    'Ghost Frequency',
    'Coral City',
  ],
};

/// A single "poster" — a gradient card with a play icon and a made-up
/// title, that gently lifts and glows when hovered (desktop/web) or
/// pressed (mobile), similar to how Netflix's real tiles react.
class PosterTile extends StatefulWidget {
  final String title;
  final List<Color> gradient;
  final double width;
  final double height;

  const PosterTile({
    super.key,
    required this.title,
    required this.gradient,
    required this.width,
    required this.height,
  });

  @override
  State<PosterTile> createState() => _PosterTileState();
}

class _PosterTileState extends State<PosterTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.06 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradient,
            ),
            border: Border.all(
              color: _hovering ? NetflixColors.white : Colors.transparent,
              width: 1.2,
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Icon(Icons.play_circle_outline,
                    color: Colors.white70, size: 28),
              ),
              Positioned(
                left: 6,
                right: 6,
                bottom: 6,
                child: Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(color: Colors.black87, blurRadius: 4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
