import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/gradient_button.dart';
import '../widgets/glow_card.dart';

/// Registration section with clear Internal vs External student paths
class RegistrationSection extends StatefulWidget {
  const RegistrationSection({super.key});

  @override
  State<RegistrationSection> createState() => _RegistrationSectionState();
}

class _RegistrationSectionState extends State<RegistrationSection> {
  static const String _externalFormUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSf9pqbG4vWppeFYsb6pky4W9CKSk62Kbiv9qHIXsI7R4Sy_hQ/viewform';

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.background,
            Color(0xFF0d1a2d),
            AppColors.background,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 100,
        ),
        child: Column(
          children: [
            const ScrollReveal(
              child: SectionTitle(
                title: 'Register Now',
                subtitle:
                    'Manthan 2026 is open to everyone — internal and external students. Choose your path below.',
              ),
            ),
            const SizedBox(height: 24),

            // Important notice banner
            ScrollReveal(
              delay: const Duration(milliseconds: 150),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentWarm.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.accentWarm.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.accentWarm, size: 22),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'External college students must register through the Google Form. Internal students can register by scanning the QR code.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.accentWarm,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Two registration cards side by side
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 950),
              child: isMobile
                  ? Column(
                      children: [
                        _buildExternalCard(context),
                        const SizedBox(height: 28),
                        _buildInternalCard(context),
                      ],
                    )
                  : IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ScrollReveal(
                              delay: const Duration(milliseconds: 250),
                              offset: const Offset(-30, 0),
                              child: _buildExternalCard(context),
                            ),
                          ),
                          SizedBox(width: isTablet ? 20 : 32),
                          Expanded(
                            child: ScrollReveal(
                              delay: const Duration(milliseconds: 400),
                              offset: const Offset(30, 0),
                              child: _buildInternalCard(context),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ── External Students Card ────────────────────────────────────
  Widget _buildExternalCard(BuildContext context) {
    return GlowCard(
      glowColor: AppColors.accentPink,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              AppColors.accentPink.withValues(alpha: 0.06),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppColors.featuredGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.public, size: 14, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'EXTERNAL STUDENTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentPink.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.school_outlined,
                  color: AppColors.accentPink,
                  size: 36,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'From Another College?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),

              Text(
                'If you\'re from an external college or institution, register through our Google Form. Fill in your details and we\'ll confirm your participation via email.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),

              // Highlights
              _InfoRow(
                icon: Icons.check_circle,
                text: 'Open to all colleges & institutions',
                color: AppColors.accentPink,
              ),
              _InfoRow(
                icon: Icons.check_circle,
                text: 'Free registration',
                color: AppColors.accentPink,
              ),
              _InfoRow(
                icon: Icons.check_circle,
                text: 'Confirmation sent via email',
                color: AppColors.accentPink,
              ),
              const SizedBox(height: 28),

              // CTA
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  text: 'Register via Google Form',
                  icon: Icons.open_in_new_rounded,
                  gradient: AppColors.featuredGradient,
                  onPressed: () async {
                    final uri = Uri.parse(_externalFormUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Internal Students Card ────────────────────────────────────
  Widget _buildInternalCard(BuildContext context) {
    return GlowCard(
      glowColor: AppColors.accent,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              AppColors.accent.withValues(alpha: 0.06),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home_outlined, size: 14, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'INTERNAL STUDENTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.touch_app_rounded,
                  color: AppColors.accent,
                  size: 36,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Our Own Students?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),

              Text(
                'If you\'re a student of our college, registration is simple! Browse the events above, tap on any event poster you\'re interested in, and join directly from there.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),

              // Step-by-step guide
              _StepItem(
                stepNumber: '1',
                text: 'Browse the Events section above',
                color: AppColors.accent,
              ),
              _StepItem(
                stepNumber: '2',
                text: 'Tap on the event poster you want to join',
                color: AppColors.accent,
              ),
              _StepItem(
                stepNumber: '3',
                text: 'Follow the registration link inside the poster',
                color: AppColors.accent,
              ),
              const SizedBox(height: 20),

              // Highlights
              _InfoRow(
                icon: Icons.check_circle,
                text: 'No separate form needed',
                color: AppColors.accent,
              ),
              _InfoRow(
                icon: Icons.check_circle,
                text: 'Register directly from event posters',
                color: AppColors.accent,
              ),
              _InfoRow(
                icon: Icons.check_circle,
                text: 'Quick & hassle-free process',
                color: AppColors.accent,
              ),
              const SizedBox(height: 24),

              // Visual hint to scroll up to events
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_upward_rounded,
                        size: 18,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Scroll up to explore events',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

/// Reusable info row with check icon
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Numbered step indicator
class _StepItem extends StatelessWidget {
  final String stepNumber;
  final String text;
  final Color color;

  const _StepItem({
    required this.stepNumber,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
