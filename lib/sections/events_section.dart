import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/event_model.dart';
import '../data/mock_data.dart';
import '../widgets/section_title.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/glow_card.dart';

/// Events section with day/category filtering and poster cards
class EventsSection extends StatefulWidget {
  const EventsSection({super.key});

  @override
  State<EventsSection> createState() => _EventsSectionState();
}

class _EventsSectionState extends State<EventsSection> {
  int _selectedDay = 0; // 0 = All
  EventCategory _selectedCategory = EventCategory.all;

  List<EventModel> get _filteredEvents {
    var events = MockData.allEvents;
    if (_selectedDay > 0) {
      events = events.where((e) => e.day == _selectedDay).toList();
    }
    if (_selectedCategory != EventCategory.all) {
      events =
          events.where((e) => e.category == _selectedCategory).toList();
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet =
        MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 100,
      ),
      child: Column(
        children: [
          const ScrollReveal(
            child: SectionTitle(
              title: 'Events',
              subtitle:
                  '17+ events across 3 days — tech, sports, gaming, creative, and knowledge.',
            ),
          ),
          const SizedBox(height: 40),

          // Day filter
          ScrollReveal(
            delay: const Duration(milliseconds: 200),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _DayChip(
                    label: 'All Days',
                    isSelected: _selectedDay == 0,
                    onTap: () => setState(() => _selectedDay = 0)),
                _DayChip(
                    label: 'Day 1',
                    isSelected: _selectedDay == 1,
                    onTap: () => setState(() => _selectedDay = 1)),
                _DayChip(
                    label: 'Day 2',
                    isSelected: _selectedDay == 2,
                    onTap: () => setState(() => _selectedDay = 2)),
                _DayChip(
                    label: 'Day 3',
                    isSelected: _selectedDay == 3,
                    onTap: () => setState(() => _selectedDay = 3)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Category filter
          ScrollReveal(
            delay: const Duration(milliseconds: 300),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: EventCategory.values.map((cat) {
                return _CategoryChip(
                  category: cat,
                  isSelected: _selectedCategory == cat,
                  onTap: () =>
                      setState(() => _selectedCategory = cat),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 48),

          // Events grid
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _filteredEvents.isEmpty
                ? Padding(
                    key: const ValueKey('empty'),
                    padding: const EdgeInsets.all(60),
                    child: Column(
                      children: [
                        Icon(Icons.search_off,
                            size: 48, color: AppColors.textMuted),
                        const SizedBox(height: 16),
                        Text(
                          'No events match this filter',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  )
                : Wrap(
                    key: ValueKey('$_selectedDay-$_selectedCategory'),
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: _filteredEvents.map((event) {
                      final cardWidth = isMobile
                          ? MediaQuery.of(context).size.width - 48
                          : isTablet
                              ? (MediaQuery.of(context).size.width - 180) / 2
                              : (MediaQuery.of(context).size.width - 300) / 4;
                      return _EventCard(
                        event: event,
                        width: cardWidth.clamp(250, 350).toDouble(),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_DayChip> createState() => _DayChipState();
}

class _DayChipState extends State<_DayChip> {
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
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: widget.isSelected
                ? AppColors.primaryGradient
                : null,
            color: !widget.isSelected
                ? _hovered
                    ? AppColors.surfaceLight
                    : AppColors.surface
                : null,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: widget.isSelected
                  ? Colors.transparent
                  : AppColors.textMuted.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isSelected
                  ? Colors.white
                  : AppColors.textSecondary,
              fontWeight:
                  widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final EventCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  Color get _color {
    return switch (category) {
      EventCategory.all => AppColors.primary,
      EventCategory.tech => AppColors.categoryTech,
      EventCategory.sports => AppColors.categorySports,
      EventCategory.gaming => AppColors.categoryGaming,
      EventCategory.creative => AppColors.categoryCreative,
      EventCategory.knowledge => AppColors.categoryKnowledge,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? _color.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? _color.withValues(alpha: 0.5)
                  : AppColors.textMuted.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(category.icon, size: 14, color: _color),
              const SizedBox(width: 6),
              Text(
                category.label,
                style: TextStyle(
                  color: isSelected ? _color : AppColors.textMuted,
                  fontSize: 12,
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

class _EventCard extends StatelessWidget {
  final EventModel event;
  final double width;

  const _EventCard({required this.event, required this.width});

  Color get _categoryColor {
    return switch (event.category) {
      EventCategory.tech => AppColors.categoryTech,
      EventCategory.sports => AppColors.categorySports,
      EventCategory.gaming => AppColors.categoryGaming,
      EventCategory.creative => AppColors.categoryCreative,
      EventCategory.knowledge => AppColors.categoryKnowledge,
      _ => AppColors.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GlowCard(
        glowColor: _categoryColor,
        padding: EdgeInsets.zero,
        onTap: () => _showEventDialog(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset(
                  event.posterAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.surfaceLight,
                    child: Icon(event.icon,
                        size: 48, color: _categoryColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category tag + Day
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _categoryColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event.category.label,
                          style: TextStyle(
                            color: _categoryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'DAY ${event.day}',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Title
                  Text(
                    event.name,
                    style:
                        Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    event.description,
                    style:
                        Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (event.teamSize != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.group,
                            size: 14,
                            color: AppColors.textMuted),
                        const SizedBox(width: 6),
                        Text(
                          event.teamSize!,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDialog(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.surface,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isWide ? 60 : 20,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: _categoryColor.withValues(alpha: 0.2),
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 900 : 500),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: isWide
                ? _buildWideDialogContent(ctx)
                : _buildNarrowDialogContent(ctx),
          ),
        ),
      ),
    );
  }

  /// Desktop/tablet: poster on left, details on right
  Widget _buildWideDialogContent(BuildContext ctx) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Poster — takes up ~45% of width
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  event.posterAsset,
                  fit: BoxFit.cover,
                ),
                // Subtle gradient overlay on right edge for blending
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.surface.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Details — takes up ~55%
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(36),
              child: _buildEventDetails(ctx),
            ),
          ),
        ],
      ),
    );
  }

  /// Mobile: poster on top (large), details below
  Widget _buildNarrowDialogContent(BuildContext ctx) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Poster — large, square
          AspectRatio(
            aspectRatio: 0.85,
            child: Image.asset(
              event.posterAsset,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: _buildEventDetails(ctx),
          ),
        ],
      ),
    );
  }

  /// Shared event details content
  Widget _buildEventDetails(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category + Day badges
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _categoryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(event.category.icon,
                      size: 13, color: _categoryColor),
                  const SizedBox(width: 6),
                  Text(
                    event.category.label,
                    style: TextStyle(
                      color: _categoryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'DAY ${event.day}',
                style: const TextStyle(
                  color: AppColors.primaryGlow,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Title
        Text(
          event.name,
          style: Theme.of(ctx).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),

        // Divider accent line
        Container(
          width: 50,
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_categoryColor, _categoryColor.withValues(alpha: 0.2)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),

        // Description
        Text(
          event.description,
          style: Theme.of(ctx).textTheme.bodyLarge,
        ),

        // Team size
        if (event.teamSize != null) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.textMuted.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _categoryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.group, size: 18, color: _categoryColor),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Team Size',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      event.teamSize!,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 28),
        // Close button
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () => Navigator.pop(ctx),
            icon: const Icon(Icons.close, size: 18),
            label: const Text('Close'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
