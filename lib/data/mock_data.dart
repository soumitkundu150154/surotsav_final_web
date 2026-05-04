import 'package:flutter/material.dart';
import '../models/event_model.dart';

/// All real event data for Manthan / Surotsav 2026
class MockData {
  MockData._();

  // ── DAY 1 ─────────────────────────────────────────────────────
  static const List<EventModel> day1Events = [
    EventModel(
      name: 'Treasure Hunt',
      category: EventCategory.sports,
      description:
          'Embark on an exhilarating campus-wide treasure hunt! Follow cryptic clues, solve puzzles, and race against time to find the hidden treasure before anyone else.',
      icon: Icons.explore,
      posterAsset: 'assets/events/treasure_hunt_event.jpeg',
      day: 1,
      teamSize: 'Team of 3-4',
    ),
  ];

  // ── DAY 2 ─────────────────────────────────────────────────────
  static const List<EventModel> day2Events = [
    EventModel(
      name: 'Tyre Changing',
      category: EventCategory.sports,
      description:
          'Put your pit-stop skills to the test! Race against the clock to change a tyre with speed and precision. The fastest team wins.',
      icon: Icons.build_circle,
      posterAsset: 'assets/events/tyre_changing.jpeg',
      day: 2,
      teamSize: 'Team of 2',
    ),
    EventModel(
      name: 'Hit the Wicket',
      category: EventCategory.sports,
      description:
          'Show off your bowling prowess! Aim for the stumps and score maximum points. Accuracy and power are your best friends.',
      icon: Icons.sports_cricket,
      posterAsset: 'assets/events/Hit_the_wicket.jpeg',
      day: 2,
      teamSize: 'Individual',
    ),
    EventModel(
      name: 'Target the Goal',
      category: EventCategory.sports,
      description:
          'Take your best shot at the goal! Precision football shooting challenge where every kick counts. Can you hit the bullseye?',
      icon: Icons.sports_soccer,
      posterAsset: 'assets/events/Target_the_goal.jpeg',
      day: 2,
      teamSize: 'Individual',
    ),
    EventModel(
      name: 'Line Follower',
      category: EventCategory.tech,
      description:
          'Build and program a robot that can follow a line path with maximum speed and accuracy. The ultimate test of robotics engineering.',
      icon: Icons.smart_toy,
      posterAsset: 'assets/events/Line_follower.jpeg',
      day: 2,
      teamSize: 'Team of 2-3',
    ),
    EventModel(
      name: 'Robo Race',
      category: EventCategory.tech,
      description:
          'Design, build, and race your robot through an obstacle course! Navigate turns, ramps, and challenges to claim the championship.',
      icon: Icons.precision_manufacturing,
      posterAsset: 'assets/events/robo_race.jpeg',
      day: 2,
      teamSize: 'Team of 2-4',
    ),
    EventModel(
      name: 'UAV Race',
      category: EventCategory.tech,
      description:
          'Take to the skies! Pilot your UAV through an aerial obstacle course. Speed, control, and nerves of steel required.',
      icon: Icons.flight,
      posterAsset: 'assets/events/uav_race.jpeg',
      day: 2,
      teamSize: 'Team of 2-3',
    ),
    EventModel(
      name: 'BGMI Championship',
      category: EventCategory.gaming,
      description:
          'Battle it out in the ultimate BGMI showdown! Squad up, strategize, and claim the chicken dinner in this high-stakes tournament.',
      icon: Icons.sports_esports,
      posterAsset: 'assets/events/BGMI.jpeg',
      day: 2,
      teamSize: 'Squad of 4',
    ),
    EventModel(
      name: 'Free Fire Clash',
      category: EventCategory.gaming,
      description:
          'Drop in, loot up, and survive! Compete in the Free Fire Clash tournament and prove you\'re the last one standing.',
      icon: Icons.local_fire_department,
      posterAsset: 'assets/events/Free-Fire_event.jpeg',
      day: 2,
      teamSize: 'Squad of 4',
    ),
    EventModel(
      name: 'E-Football',
      category: EventCategory.gaming,
      description:
          'Showcase your virtual football skills in this intense E-Football tournament. Dribble, pass, and score your way to victory!',
      icon: Icons.sports_soccer,
      posterAsset: 'assets/events/E-Football.jpeg',
      day: 2,
      teamSize: 'Individual',
    ),
    EventModel(
      name: 'Model Making',
      category: EventCategory.creative,
      description:
          'Unleash your creativity and engineering skills! Build a working or display model that showcases innovation and craftsmanship.',
      icon: Icons.architecture,
      posterAsset: 'assets/events/Model_making_event.jpeg',
      day: 2,
      teamSize: 'Team of 2-4',
    ),
    EventModel(
      name: 'Reels Making',
      category: EventCategory.creative,
      description:
          'Capture, edit, and create the most engaging reel! Show your storytelling and video editing skills in this creative showdown.',
      icon: Icons.videocam,
      posterAsset: 'assets/events/reels.jpeg',
      day: 2,
      teamSize: 'Individual / Duo',
    ),
    EventModel(
      name: 'Photography',
      category: EventCategory.creative,
      description:
          'See the world through your lens! Capture stunning moments at the fest. The best photograph wins the crown.',
      icon: Icons.camera_alt,
      posterAsset: 'assets/events/photography.jpeg',
      day: 2,
      teamSize: 'Individual',
    ),
  ];

  // ── DAY 3 ─────────────────────────────────────────────────────
  static const List<EventModel> day3Events = [
    EventModel(
      name: 'Quiz',
      category: EventCategory.knowledge,
      description:
          'Test your knowledge across multiple domains — science, tech, pop culture, and more! The smartest minds will prevail.',
      icon: Icons.quiz,
      posterAsset: 'assets/events/quize_event.jpeg',
      day: 3,
      teamSize: 'Team of 2-3',
    ),
    EventModel(
      name: 'Debate',
      category: EventCategory.knowledge,
      description:
          'Articulate, argue, and convince! Engage in thought-provoking debates on contemporary topics. May the best argument win.',
      icon: Icons.record_voice_over,
      posterAsset: 'assets/events/debate_event.jpeg',
      day: 3,
      teamSize: 'Individual',
    ),
    EventModel(
      name: 'Puzzle',
      category: EventCategory.knowledge,
      description:
          'Race against time to solve intricate puzzles! Logic, pattern recognition, and speed — you\'ll need them all.',
      icon: Icons.extension,
      posterAsset: 'assets/events/puzzel_event.jpeg',
      day: 3,
      teamSize: 'Individual / Duo',
    ),
    EventModel(
      name: 'Debugging',
      category: EventCategory.tech,
      description:
          'Find and fix bugs in code under pressure! A must for every programmer. The cleanest debug wins the glory.',
      icon: Icons.bug_report,
      posterAsset: 'assets/events/debugging_event.jpeg',
      day: 3,
      teamSize: 'Individual',
    ),
  ];

  /// All events combined
  static const List<EventModel> allEvents = [
    ...day1Events,
    ...day2Events,
    ...day3Events,
  ];

  /// Website developers
  static const List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Soumit',
      role: 'Website Developer',
      imageAsset: 'assets/soumit.png',
      portfolioUrl: 'https://soumit-old-port.vercel.app/',
    ),
    TeamMember(
      name: 'Sayantani',
      role: 'Website Developer',
      imageAsset: 'assets/sayantani.png',
      portfolioUrl: 'https://sayantani-portfolio.vercel.app/',
    ),
  ];

  /// Instagram placeholder
  static const String instagramUrl = ''; // TODO: Add Instagram link

  /// Fest date — May 12, 2026 at 2:00 PM IST
  static final DateTime festDate = DateTime(2026, 5, 12, 14, 0, 0);
}
