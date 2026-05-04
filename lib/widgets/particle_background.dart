import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Interactive particle background using CustomPainter.
/// Particles float, connect with lines, and respond to mouse/touch.
class ParticleBackground extends StatefulWidget {
  final int particleCount;

  const ParticleBackground({super.key, this.particleCount = 70});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  Offset? _mousePosition;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _particles = [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  void _initParticles(Size size) {
    if (_particles.isNotEmpty) return;
    final count = size.width < 600
        ? (widget.particleCount * 0.5).toInt()
        : widget.particleCount;
    _particles = List.generate(count, (_) => _Particle.random(size, _random));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initParticles(size);

        return MouseRegion(
          onHover: (event) {
            _mousePosition = event.localPosition;
          },
          onExit: (_) {
            _mousePosition = null;
          },
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  size: size,
                  painter: _ParticlePainter(
                    particles: _particles,
                    mousePosition: _mousePosition,
                    bounds: size,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Particle {
  double x, y;
  double vx, vy;
  double radius;
  double opacity;
  double baseOpacity;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
    required this.baseOpacity,
  });

  factory _Particle.random(Size size, Random random) {
    final baseOp = 0.2 + random.nextDouble() * 0.5;
    return _Particle(
      x: random.nextDouble() * size.width,
      y: random.nextDouble() * size.height,
      vx: (random.nextDouble() - 0.5) * 0.6,
      vy: (random.nextDouble() - 0.5) * 0.6,
      radius: 1.0 + random.nextDouble() * 2.5,
      opacity: baseOp,
      baseOpacity: baseOp,
    );
  }

  void update(Size bounds, Offset? mouse) {
    x += vx;
    y += vy;

    // Wrap around edges
    if (x < 0) x = bounds.width;
    if (x > bounds.width) x = 0;
    if (y < 0) y = bounds.height;
    if (y > bounds.height) y = 0;

    // Mouse interaction — gentle repulsion
    if (mouse != null) {
      final dx = x - mouse.dx;
      final dy = y - mouse.dy;
      final dist = sqrt(dx * dx + dy * dy);
      if (dist < 150) {
        final force = (150 - dist) / 150 * 0.02;
        vx += dx / dist * force;
        vy += dy / dist * force;
        opacity = min(1.0, baseOpacity + (150 - dist) / 150 * 0.4);
      } else {
        opacity += (baseOpacity - opacity) * 0.05;
      }
    } else {
      opacity += (baseOpacity - opacity) * 0.05;
    }

    // Dampen velocity
    vx *= 0.99;
    vy *= 0.99;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Offset? mousePosition;
  final Size bounds;

  _ParticlePainter({
    required this.particles,
    required this.mousePosition,
    required this.bounds,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Update particles
    for (final p in particles) {
      p.update(bounds, mousePosition);
    }

    final linePaint = Paint()..strokeWidth = 0.5;
    final maxDist = 120.0;

    // Draw connection lines
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final dist = sqrt(dx * dx + dy * dy);

        if (dist < maxDist) {
          final alpha = ((1 - dist / maxDist) * 0.15);
          linePaint.color = AppColors.primary.withValues(alpha: alpha);
          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }

    // Draw particles
    for (final p in particles) {
      final paint = Paint()
        ..color = AppColors.primaryGlow.withValues(alpha: p.opacity);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);

      // Glow effect for larger particles
      if (p.radius > 2.0) {
        final glowPaint = Paint()
          ..color = AppColors.accent.withValues(alpha: p.opacity * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
        canvas.drawCircle(Offset(p.x, p.y), p.radius * 2, glowPaint);
      }
    }

    // Draw glow around mouse
    if (mousePosition != null) {
      final mousePaint = Paint()
        ..color = AppColors.primary.withValues(alpha: 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
      canvas.drawCircle(mousePosition!, 80, mousePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
