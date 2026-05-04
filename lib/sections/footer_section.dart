import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Footer section with links, social, and credits
class FooterSection extends StatelessWidget {
  final VoidCallback? onAboutTap;
  final VoidCallback? onEventsTap;
  final VoidCallback? onRegisterTap;

  const FooterSection({
    super.key,
    this.onAboutTap,
    this.onEventsTap,
    this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: 60,
        ),
        child: Column(
          children: [
            // Top row
            isMobile
                ? Column(
                    children: [
                      _buildBrand(context),
                      const SizedBox(height: 32),
                      _buildLinks(context),
                      const SizedBox(height: 32),
                      _buildSocial(context),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildBrand(context)),
                      Expanded(child: _buildLinks(context)),
                      Expanded(child: _buildSocial(context)),
                    ],
                  ),

            const SizedBox(height: 40),
            Divider(color: AppColors.textMuted.withValues(alpha: 0.15)),
            const SizedBox(height: 20),

            // Copyright
            Text(
              '© 2026 Surotsav — Manthan Tech Fest. All rights reserved.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Made with ❤️ Soumit Kundu © ',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrand(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo/logo_white.png',
              height: 36,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(width: 12),
            Text(
              'SUROTSAV \'26',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(letterSpacing: 2),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            'Where Innovation Meets Execution. The flagship tech fest experience.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK LINKS',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        _FooterLink(label: 'About', onTap: onAboutTap),
        _FooterLink(label: 'Events', onTap: onEventsTap),
        _FooterLink(label: 'Register', onTap: onRegisterTap),
      ],
    );
  }

  Widget _buildSocial(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONNECT',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        _FooterLink(
          label: 'Instagram',
          icon: Icons.camera_alt_outlined,
          onTap: () {
            // TODO: Open Instagram link
          },
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  const _FooterLink({required this.label, this.icon, this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 16,
                  color: _hovered ? AppColors.primary : AppColors.textMuted,
                ),
                const SizedBox(width: 8),
              ],
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _hovered ? AppColors.primary : AppColors.textMuted,
                  fontSize: 14,
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
