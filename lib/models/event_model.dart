import 'package:flutter/material.dart';

/// Event category enum for filtering
enum EventCategory {
  all('All', Icons.apps),
  tech('Tech', Icons.memory),
  sports('Sports', Icons.sports_soccer),
  gaming('Gaming', Icons.sports_esports),
  creative('Creative', Icons.palette),
  knowledge('Knowledge', Icons.school);

  final String label;
  final IconData icon;
  const EventCategory(this.label, this.icon);
}

/// Model representing a fest event
class EventModel {
  final String name;
  final EventCategory category;
  final String description;
  final IconData icon;
  final String posterAsset;
  final int day;
  final String? prizePool;
  final String? teamSize;
  final String? venue;
  final String? duration;

  const EventModel({
    required this.name,
    required this.category,
    required this.description,
    required this.icon,
    required this.posterAsset,
    required this.day,
    this.prizePool,
    this.teamSize,
    this.venue,
    this.duration,
  });
}

/// Model representing a team/organizer member
class TeamMember {
  final String name;
  final String role;
  final String? imageAsset;
  final String? instagramUrl;
  final String? portfolioUrl;

  const TeamMember({
    required this.name,
    required this.role,
    this.imageAsset,
    this.instagramUrl,
    this.portfolioUrl,
  });
}
