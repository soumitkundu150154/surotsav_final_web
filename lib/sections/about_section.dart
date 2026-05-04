import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/animated_counter.dart';
import '../widgets/glow_card.dart';

/// About section — What is Manthan, stats, key highlights
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: Column(
        children: [
          // Title
          const ScrollReveal(
            child: SectionTitle(
              title: 'About Manthan',
              subtitle:
                  'Manthan is the flagship tech fest under Surotsav — a celebration of innovation, creativity, and competition. Open to students from all colleges.',
            ),
          ),
          const SizedBox(height: 60),

          // Description cards
          ScrollReveal(
            delay: const Duration(milliseconds: 200),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Text(
                'Spanning 3 action-packed days, Manthan brings together the brightest minds for 17+ events across tech, sports, gaming, creative, and knowledge domains. Whether you\'re a robotics enthusiast, a gaming champion, or a creative storyteller — there\'s something for everyone.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Stats row
          ScrollReveal(
            delay: const Duration(milliseconds: 400),
            child: Wrap(
              spacing: isMobile ? 20 : 60,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: const [
                AnimatedCounter(value: 17, suffix: '+', label: 'Events'),
                AnimatedCounter(value: 3, suffix: '', label: 'Days'),
                AnimatedCounter(value: 500, suffix: '+', label: 'Participants'),
                AnimatedCounter(value: 20, suffix: '+', label: 'Colleges'),
              ],
            ),
          ),
          const SizedBox(height: 80),

          // Key highlight cards
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isMobile
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 48) / 3;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _HighlightCard(
                    icon: Icons.public,
                    title: 'Open for All',
                    description:
                        'Students from any college can participate. No restrictions.',
                    glowColor: AppColors.accent,
                    width: cardWidth,
                    delay: 0,
                  ),
                  _HighlightCard(
                    icon: Icons.emoji_events,
                    title: 'Win Big',
                    description:
                        'Exciting prizes, trophies, and certificates across all events.',
                    glowColor: AppColors.accentWarm,
                    width: cardWidth,
                    delay: 150,
                  ),
                  _HighlightCard(
                    icon: Icons.diversity_3,
                    title: 'Network & Learn',
                    description:
                        'Meet like-minded peers, showcase your skills, and build connections.',
                    glowColor: AppColors.accentPink,
                    width: cardWidth,
                    delay: 300,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color glowColor;
  final double width;
  final int delay;

  const _HighlightCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.glowColor,
    required this.width,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      delay: Duration(milliseconds: 600 + delay),
      offset: const Offset(0, 30),
      child: SizedBox(
        width: width.clamp(0, 350),
        child: GlowCard(
          glowColor: glowColor,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: glowColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: glowColor, size: 32),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
