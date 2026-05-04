import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Glassmorphism card with hover glow and scale effects
class GlowCard extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final double borderRadius;

  const GlowCard({
    super.key,
    required this.child,
    this.glowColor = AppColors.primary,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 20,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _glowAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      cursor:
          widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnim.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: widget.glowColor
                        .withValues(alpha: 0.15 * _glowAnim.value),
                    blurRadius: 30 * _glowAnim.value,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.7),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius),
                      border: Border.all(
                        color: _isHovered
                            ? widget.glowColor.withValues(alpha: 0.3)
                            : AppColors.textMuted.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onTap,
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        splashColor:
                            widget.glowColor.withValues(alpha: 0.1),
                        child: Padding(
                          padding: widget.padding,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
