import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/mock_data.dart';
import '../models/event_model.dart';
import '../widgets/section_title.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/glow_card.dart';
import 'package:url_launcher/url_launcher.dart';

/// Team / Organizers section with photo cards and View Profile
class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

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
          const ScrollReveal(
            child: SectionTitle(
              title: 'Built By',
              subtitle: 'The developers behind the Manthan 2026 website.',
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: MockData.teamMembers.asMap().entries.map((entry) {
              final index = entry.key;
              final member = entry.value;
              return ScrollReveal(
                delay: Duration(milliseconds: 200 + index * 150),
                child: _TeamCard(member: member),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatefulWidget {
  final TeamMember member;

  const _TeamCard({required this.member});

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
  Color _avatarColor(String name) {
    final colors = [
      AppColors.primary,
      AppColors.accent,
      AppColors.accentWarm,
      const Color.fromARGB(255, 29, 15, 226),
      const Color(0xFF10B981),
      const Color(0xFF8B5CF6),
    ];
    return colors[name.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _avatarColor(widget.member.name);
    final hasImage =
        widget.member.imageAsset != null &&
        widget.member.imageAsset!.isNotEmpty;

    return SizedBox(
      width: 240,
      child: GlowCard(
        glowColor: color,
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            // Avatar — photo or initials
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: hasImage
                    ? null
                    : LinearGradient(
                        colors: [color, color.withValues(alpha: 0.6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: Border.all(
                  color: color.withValues(alpha: 0.4),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.25),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: ClipOval(
                child: hasImage
                    ? Image.asset(
                        widget.member.imageAsset!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )
                    : Center(
                        child: Text(
                          widget.member.name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.member.name,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.member.role,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // View Profile button
            if (widget.member.portfolioUrl != null &&
                widget.member.portfolioUrl!.isNotEmpty)
              _ViewProfileButton(
                color: color,
                memberName: widget.member.name,
                onTap: () async {
                  final uri = Uri.parse(widget.member.portfolioUrl!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _ViewProfileButton extends StatefulWidget {
  final Color color;
  final String memberName;
  final VoidCallback onTap;

  const _ViewProfileButton({
    required this.color,
    required this.memberName,
    required this.onTap,
  });

  @override
  State<_ViewProfileButton> createState() => _ViewProfileButtonState();
}

class _ViewProfileButtonState extends State<_ViewProfileButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.color.withValues(alpha: _hovered ? 0.5 : 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_outline, size: 16, color: widget.color),
              const SizedBox(width: 8),
              Text(
                'View Profile',
                style: TextStyle(
                  color: widget.color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
