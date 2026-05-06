import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suorotsav_2026/widgets/scroll_reveal.dart';
import '../theme/app_colors.dart';

class SurotsavIntroSection extends StatefulWidget {
  final VoidCallback onExploreTap;

  const SurotsavIntroSection({super.key, required this.onExploreTap});

  @override
  State<SurotsavIntroSection> createState() => _SurotsavIntroSectionState();
}

class _SurotsavIntroSectionState extends State<SurotsavIntroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // The White Logo
                    ScrollReveal(
                      delay: Duration(milliseconds: 200),
                      child: Image.asset(
                        'assets/logo/logo_white.png',
                        // width: size.width * 0.4,
                        height: isMobile ? 200 : 300,
                        // fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Main Title
                    Text(
                      'SUROTSAV 2026',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: size.width > 800 ? 80 : 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 8,
                        shadows: [
                          Shadow(
                            color: AppColors.primary.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Dummy Intro Text
                    Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Where technology meets creativity, sports meet passion, and talent meets opportunity. \n\nWelcome to Surotsav 2026 — the grand fest of Dr. Sudhir Chandra Sur Institute of Technology & Sports Complex, crafted to inspire, connect, and celebrate brilliance.",
                        style: GoogleFonts.inter(
                          fontSize: size.width > 800 ? 20 : 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textSecondary,
                          height: 1.6,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Scroll Down Indicator
                    GestureDetector(
                      onTap: widget.onExploreTap,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Column(
                          children: [
                            Text(
                              'EXPLORE MANTHAN & MORE',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
