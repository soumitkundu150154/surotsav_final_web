import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Animated number counter that triggers when scrolled into view.
class AnimatedCounter extends StatefulWidget {
  final int value;
  final String suffix;
  final String label;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.suffix = '',
    required this.label,
    this.valueStyle,
    this.labelStyle,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _countAnim;
  bool _hasAnimated = false;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _countAnim = Tween<double>(begin: 0, end: widget.value.toDouble()).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibility(VisibilityInfo info) {
    if (_hasAnimated) return;
    if (info.visibleFraction > 0.3) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: _onVisibility,
      child: AnimatedBuilder(
        animation: _countAnim,
        builder: (context, _) {
          return Column(
            children: [
              Text(
                '${_countAnim.value.toInt()}${widget.suffix}',
                style: widget.valueStyle ??
                    Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: widget.labelStyle ?? Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
