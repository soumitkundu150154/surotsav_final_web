import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Reusable gradient CTA button with hover glow and scale animation
class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final LinearGradient gradient;
  final bool isOutline;
  final double? width;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.gradient = AppColors.primaryGradient,
    this.isOutline = false,
    this.width,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
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
      cursor: SystemMouseCursors.click,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.width,
          decoration: BoxDecoration(
            gradient: widget.isOutline ? null : widget.gradient,
            borderRadius: BorderRadius.circular(14),
            border: widget.isOutline
                ? Border.all(
                    color: AppColors.primary.withValues(alpha: 0.6),
                    width: 1.5,
                  )
                : null,
            boxShadow: _isHovered && !widget.isOutline
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 24,
                      spreadRadius: -4,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(14),
              splashColor: Colors.white.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                    ],
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: widget.isOutline
                                ? AppColors.primary
                                : Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
