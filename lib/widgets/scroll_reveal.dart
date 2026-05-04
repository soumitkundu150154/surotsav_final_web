import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps a child widget to animate it in when it scrolls into view.
/// Supports fade + translate from configurable direction.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset offset;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 40),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _hasAnimated = false;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _slideAnim = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasAnimated) return;
    if (info.visibleFraction > 0.15) {
      _hasAnimated = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnim.value,
            child: Transform.translate(
              offset: _slideAnim.value,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
