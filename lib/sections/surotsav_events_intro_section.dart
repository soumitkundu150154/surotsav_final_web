import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/scroll_reveal.dart';

class SurotsavEventsIntroSection extends StatelessWidget {
  const SurotsavEventsIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Container(
      width: size.width,
      // We use a relative positioned stack to put a glow behind the content
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.primary.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -200,
            left: size.width / 4,
            right: size.width / 4,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : 24,
              vertical: 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Section Header
                ScrollReveal(
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: Text(
                      'THE FOUR PILLARS',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: isDesktop ? 56 : 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ScrollReveal(
                  delay: const Duration(milliseconds: 100),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Experience the ultimate convergence of talent, passion, and energy at Surotsav 2026. Four distinct domains, one unforgettable journey.',
                      style: GoogleFonts.inter(
                        fontSize: isDesktop ? 18 : 16,
                        color: AppColors.textSecondary,
                        height: 1.6,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 100),

                // Events Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (isDesktop) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _buildEventCards(context, true),
                      );
                    } else {
                      return Column(
                        children: _buildEventCards(context, false),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEventCards(BuildContext context, bool isDesktop) {
    final events = [
      {
        'title': 'MOBMANIA',
        'subtitle': 'The Dance Arena',
        'icon': Icons.music_note,
        'color': const Color(0xFFFF3366),
        'desc': 'The Spark That Sets Everything in Motion',
      },
      {
        'title': 'MANTHAN',
        'subtitle': 'The Tech Fest',
        'icon': Icons.memory_rounded,
        'color': const Color(0xFF00F0FF),
        'desc': 'Ignite Your Mind. Fuel Your Future.',
      },
      {
        'title': 'UDDAN',
        'subtitle': 'The Freshers',
        'icon': Icons.palette_rounded,
        'color': const Color(0xFFFFD700),
        'desc': 'Welcoming fresh faces with music, memories, fun, and the spirit of a new beginning.',
      },
      {
        'title': 'TARANG',
        'subtitle': 'The Cultural Fest',
        'icon': Icons.music_note,
        'color': const Color(0xFF00FF66),
        'desc': 'Celebration of cultural, music and unity.\n\nLive music , DJ Nights, Cultural Performances, Closing Ceremony',
      },
    ];

    return List.generate(events.length, (index) {
      final event = events[index];
      return Padding(
        padding: EdgeInsets.only(bottom: isDesktop ? 0 : 32),
        child: ScrollReveal(
          delay: Duration(milliseconds: 200 + (index * 150)),
          child: _EventCard(
            title: event['title'] as String,
            subtitle: event['subtitle'] as String,
            icon: event['icon'] as IconData,
            color: event['color'] as Color,
            description: event['desc'] as String,
            isDesktop: isDesktop,
          ),
        ),
      );
    });
  }
}

class _EventCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String description;
  final bool isDesktop;

  const _EventCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.description,
    required this.isDesktop,
  });

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.isDesktop
        ? (MediaQuery.of(context).size.width - 160 - 60) / 4 // 160 horizontal padding, 60 total spacing
        : double.infinity;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        width: cardWidth,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -15.0 : 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceGlass,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered ? widget.color.withOpacity(0.5) : AppColors.primary.withOpacity(0.1),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: widget.color.withOpacity(0.15),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
              ],
            ),
            child: Stack(
              children: [
                // Massive Background Icon
                Positioned(
                  right: -30,
                  bottom: -30,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _isHovered ? 0.15 : 0.05,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 400),
                      scale: _isHovered ? 1.1 : 1.0,
                      child: Icon(
                        widget.icon,
                        size: 150,
                        color: widget.color,
                      ),
                    ),
                  ),
                ),
                
                // Card Content
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.color,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        widget.title,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: widget.color,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.description,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
