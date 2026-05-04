import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/gradient_button.dart';
import '../widgets/glow_card.dart';
import '../data/mock_data.dart';

/// Featured event section — dramatic spotlight for Manthan
class FeaturedEventSection extends StatefulWidget {
  final VoidCallback onRegisterTap;

  const FeaturedEventSection({super.key, required this.onRegisterTap});

  @override
  State<FeaturedEventSection> createState() => _FeaturedEventSectionState();
}

class _FeaturedEventSectionState extends State<FeaturedEventSection> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final diff = MockData.festDate.difference(now);
    if (mounted) {
      setState(() {
        _remaining = diff.isNegative ? Duration.zero : diff;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1a0a2e),
            AppColors.background,
            const Color(0xFF0a1628),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Radial spotlight
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.12),
                      AppColors.accentPink.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 80,
                vertical: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Overline
                  ScrollReveal(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: AppColors.featuredGradient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        '⚡ FLAGSHIP EVENT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 32),

                // Title
                ScrollReveal(
                  delay: const Duration(milliseconds: 200),
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.featuredGradient.createShader(bounds),
                    child: Text(
                      'MANTHAN',
                      style: isMobile
                          ? Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Colors.white,
                                letterSpacing: 8,
                              )
                          : Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Colors.white,
                                letterSpacing: 12,
                                fontSize: 80,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                ScrollReveal(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    'The ultimate tech fest experience',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),

                // Countdown
                ScrollReveal(
                  delay: const Duration(milliseconds: 400),
                  child: _CountdownDisplay(remaining: _remaining),
                ),
                const SizedBox(height: 60),

                // Highlight cards
                ScrollReveal(
                  delay: const Duration(milliseconds: 500),
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _StatCard(
                        icon: Icons.emoji_events,
                        value: '17+',
                        label: 'Events',
                        color: AppColors.accentWarm,
                      ),
                      _StatCard(
                        icon: Icons.calendar_today,
                        value: '3',
                        label: 'Days',
                        color: AppColors.accent,
                      ),
                      _StatCard(
                        icon: Icons.category,
                        value: '5',
                        label: 'Categories',
                        color: AppColors.accentPink,
                      ),
                      _StatCard(
                        icon: Icons.groups,
                        value: '500+',
                        label: 'Expected',
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // CTA
                ScrollReveal(
                  delay: const Duration(milliseconds: 600),
                  child: GradientButton(
                    text: 'Register for Manthan',
                    icon: Icons.arrow_forward_rounded,
                    gradient: AppColors.featuredGradient,
                    onPressed: widget.onRegisterTap,
                  ),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}

class _CountdownDisplay extends StatelessWidget {
  final Duration remaining;

  const _CountdownDisplay({required this.remaining});

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Wrap(
      spacing: isMobile ? 12 : 24,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _CountdownUnit(value: days, label: 'DAYS'),
        _CountdownUnit(value: hours, label: 'HOURS'),
        _CountdownUnit(value: minutes, label: 'MINS'),
        _CountdownUnit(value: seconds, label: 'SECS'),
      ],
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  final int value;
  final String label;

  const _CountdownUnit({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowColor: color,
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
