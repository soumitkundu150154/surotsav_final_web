import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animated section title with gradient underline
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Overline label
        Text(
          '✦  MANTHAN 2026  ✦',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.accent,
                letterSpacing: 3,
              ),
        ),
        const SizedBox(height: 16),
        // Main title
        Text(
          title,
          style: isMobile
              ? Theme.of(context).textTheme.headlineMedium
              : Theme.of(context).textTheme.headlineLarge,
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.start,
        ),
        const SizedBox(height: 16),
        // Gradient underline
        Container(
          width: 80,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: alignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.start,
            ),
          ),
        ],
      ],
    );
  }
}
