import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_button.dart';
import '../widgets/scroll_reveal.dart';

/// Full-viewport hero section with headline, tagline, CTAs
class HeroSection extends StatefulWidget {
  final VoidCallback onRegisterTap;
  final VoidCallback onExploreTap;

  const HeroSection({
    super.key,
    required this.onRegisterTap,
    required this.onExploreTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnim = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          // Radial glow behind title
          Positioned(
            top: size.height * 0.2,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (context, _) {
                return Center(
                  child: Container(
                    width: 500 * _pulseAnim.value,
                    height: 500 * _pulseAnim.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Content
          Center(
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, _) {
                return Opacity(
                  opacity: _fadeAnim.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideAnim.value),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 60,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo
                          ScrollReveal(
                            delay: const Duration(milliseconds: 200),
                            child: Image.asset(
                              'assets/logo/logo_white.png',
                              height: isMobile ? 100 : 140,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          SizedBox(height: isMobile ? 24 : 36),

                          // Headline
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                AppColors.primaryGradient
                                    .createShader(bounds),
                            child: Text(
                              'MANTHAN 2026',
                              style: isMobile
                                  ? Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        letterSpacing: 4,
                                      )
                                  : Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        letterSpacing: 6,
                                        fontSize: isTablet ? 56 : 72,
                                      ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Tagline
                          Text(
                            'Where Innovation Meets Execution',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: isMobile ? 16 : 22,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          // Description
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Text(
                              'The flagship tech fest of Surotsav — 3 days of innovation, competition, and celebration. Open to all colleges.',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: isMobile ? 32 : 48),

                          // CTA Buttons
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              GradientButton(
                                text: 'Register Now',
                                icon: Icons.arrow_forward_rounded,
                                onPressed: widget.onRegisterTap,
                              ),
                              GradientButton(
                                text: 'Explore Events',
                                icon: Icons.explore_outlined,
                                onPressed: widget.onExploreTap,
                                isOutline: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (context, _) {
                return Opacity(
                  opacity: _pulseAnim.value,
                  child: const Column(
                    children: [
                      Text(
                        'Scroll to explore',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textMuted,
                        size: 24,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
