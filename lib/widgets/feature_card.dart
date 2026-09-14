import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final Color shadowColor;
  final BorderRadius radius;
  final double tilt;
  final Color textColor;
  final Color descColor;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.shadowColor,
    required this.radius,
    required this.onTap,
    this.tilt = 0,
    this.textColor = AppColors.ink,
    this.descColor = AppColors.ink,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, bottom: 6),
      child: Transform.rotate(
        angle: widget.tilt,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _scale = 0.95),
          onTapUp: (_) => setState(() => _scale = 1.0),
          onTapCancel: () => setState(() => _scale = 1.0),
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 100),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Transform.translate(
                    offset: const Offset(5, 5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: widget.shadowColor,
                        borderRadius: widget.radius,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: widget.radius,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.45),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(widget.icon, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title,
                                style: TextStyle(
                                  fontFamily: kAppFont,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: widget.textColor,
                                )),
                            const SizedBox(height: 3),
                            Text(widget.description,
                                style: TextStyle(
                                  fontFamily: kAppFont,
                                  fontSize: 13,
                                  color: widget.descColor,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}