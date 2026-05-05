import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Sticky responsive navbar — glass on scroll, hamburger on mobile
class ResponsiveNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const ResponsiveNavbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<ResponsiveNavbar> createState() => _ResponsiveNavbarState();
}

class _ResponsiveNavbarState extends State<ResponsiveNavbar> {
  bool _isScrolled = false;
  String _activeSection = 'hero';

  final _navItems = const [
    ('About', 'about'),
    ('Events', 'events'),
    ('Featured', 'featured'),
    ('Team', 'team'),
    ('Register', 'register'),
  ];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = widget.scrollController.offset;
    final scrolled = offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }

    // Determine active section
    String active = 'hero';
    for (final entry in widget.sectionKeys.entries) {
      final key = entry.value;
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null && box.attached) {
          final pos = box.localToGlobal(Offset.zero).dy;
          if (pos <= 200) {
            active = entry.key;
          }
        }
      }
    }
    if (active != _activeSection) {
      setState(() => _activeSection = active);
    }
  }

  void _scrollTo(String section) {
    final key = widget.sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.background.withValues(alpha: 0.85)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: _isScrolled
              ? ImageFilter.blur(sigmaX: 20, sigmaY: 20)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Row(
            children: [
              // Logo
              GestureDetector(
                onTap: () => _scrollTo('intro'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/logo/logo_white.png',
                        height: 40,
                        filterQuality: FilterQuality.high,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'SUROTSAV',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Nav items or hamburger
              if (isMobile)
                _MobileMenuButton(
                  navItems: _navItems,
                  activeSection: _activeSection,
                  onTap: _scrollTo,
                )
              else
                Row(
                  children: _navItems.map((item) {
                    final isActive = _activeSection == item.$2;
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: _NavItem(
                        label: item.$1,
                        isActive: isActive,
                        onTap: () => _scrollTo(item.$2),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primary.withValues(alpha: 0.15)
                : _isHovered
                    ? AppColors.primary.withValues(alpha: 0.08)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: widget.isActive
                      ? AppColors.primary
                      : _isHovered
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                  fontWeight:
                      widget.isActive ? FontWeight.w700 : FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final List<(String, String)> navItems;
  final String activeSection;
  final Function(String) onTap;

  const _MobileMenuButton({
    required this.navItems,
    required this.activeSection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (ctx) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textMuted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...navItems.map((item) {
                    final isActive = activeSection == item.$2;
                    return ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 8,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                      title: Text(
                        item.$1,
                        style: TextStyle(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        onTap(item.$2);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
