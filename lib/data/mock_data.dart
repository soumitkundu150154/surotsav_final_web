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
      prizePool: 'Mystry Box + Certificates',
      duration: '3 hours',
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
      teamSize: 'Team of 1 - 2 members',
      duration: '5 min per team',
      prizePool: 'Certificates',
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
      duration: '15 min per round',
      prizePool: 'Certificates + Exciting Rewards',
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
      duration: '10 min per player',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'Line Follower',
      category: EventCategory.tech,
      description:
          'Build and program a robot that can follow a line path with maximum speed and accuracy. The ultimate test of robotics engineering.',
      icon: Icons.smart_toy,
      posterAsset: 'assets/events/Line_follower.jpeg',
      day: 2,
      teamSize: 'Team of 2-3 members',
      duration: '5 min per robot',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'Robo Race',
      category: EventCategory.tech,
      description:
          'Remote-controlled robots race through a challenging obstacle course. Speed and control determine the winner.',
      icon: Icons.precision_manufacturing,
      posterAsset: 'assets/events/robo_race.jpeg',
      day: 2,
      teamSize: 'Maximum 3 members',
      duration: 'Time taken by the Robo of \neach team to complete the race',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'UAV Race',
      category: EventCategory.tech,
      description:
          'Drone racing through a 3D obstacle course. Precision flying through gates and hoops.',
      icon: Icons.flight,
      posterAsset: 'assets/events/uav_race.jpeg',
      day: 2,
      teamSize: 'Team of 2 members(1 pilot, 1 spotter)',
      duration: '5 min per drone',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'BGMI Championship',
      category: EventCategory.gaming,
      description:
          'Squad-based BGMI tournament. Classic mode with custom room settings. Winner takes all.',
      icon: Icons.sports_esports,
      posterAsset: 'assets/events/BGMI.jpeg',
      day: 2,
      teamSize: 'Squad of 4',
      duration: '30 min per match',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'Free Fire Clash',
      category: EventCategory.gaming,
      description:
          'Garena Free Fire tournament. Squad matches with custom settings. Clutch or get clutched.',
      icon: Icons.local_fire_department,
      posterAsset: 'assets/events/Free-Fire_event.jpeg',
      day: 2,
      teamSize: 'Squad of 4',
      duration: '15 min per match',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'E-Football',
      category: EventCategory.gaming,
      description:
          '1v1 E-Football (PES) tournament. Single elimination bracket. Master of the pitch wins.',
      icon: Icons.sports_soccer,
      posterAsset: 'assets/events/E-Football.jpeg',
      day: 2,
      teamSize: 'Individual',
      duration: '15 min per match',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'Model Making',
      category: EventCategory.creative,
      description:
          'Create detailed scale models on given themes. Judged on creativity, detail, and presentation.',
      icon: Icons.architecture,
      posterAsset: 'assets/events/Model_making_event.jpeg',
      day: 2,
      teamSize: 'Team of 1 - 4 members',
      duration: '5 + 3 minutes per team',
      prizePool: 'Certificates + Rewards',
    ),
    EventModel(
      name: 'Reels Making',
      category: EventCategory.creative,
      description:
          'Produce engaging short-form video content. Judged on creativity, editing, and engagement potential.',
      icon: Icons.videocam,
      posterAsset: 'assets/events/reels.jpeg',
      day: 2,
      teamSize: '2 - 4 members',
      duration: '2 hours',
      prizePool: 'Certificates',
    ),
    EventModel(
      name: 'Photography',
      category: EventCategory.creative,
      description:
          'Theme-based photography competition. Submit your best shots and explain your vision.',
      icon: Icons.camera_alt,
      posterAsset: 'assets/events/photography.jpeg',
      day: 2,
      teamSize: 'Individual',
      duration: '3 hours',
      prizePool: 'Certificates + Exciting Rewards',
    ),
  ];

  // ── DAY 3 ─────────────────────────────────────────────────────
  static const List<EventModel> day3Events = [
    EventModel(
      name: 'Quiz',
      category: EventCategory.knowledge,
      description:
          'General knowledge quiz covering tech, science, current affairs, and pop culture. Fastest correct answers win.',
      icon: Icons.quiz,
      posterAsset: 'assets/events/quize_event.jpeg',
      day: 3,
      teamSize: 'Team of 2 members',
      duration: '10 - 15 seconds per question',
      prizePool: 'Certificates + Exciting Rewards to be revealed on spot',
    ),
    EventModel(
      name: 'Debate',
      category: EventCategory.knowledge,
      description:
          'Oxford style debate on tech and societal topics. Judged on argument quality, rebuttals, and presentation.',
      icon: Icons.record_voice_over,
      posterAsset: 'assets/events/debate_event.jpeg',
      day: 3,
      teamSize: '2 members per team',
      prizePool: 'Certificates + Exciting Rewards',
      duration: '3 + 1 (Rebuttal) Minutes per Speaker',
    ),
    EventModel(
      name: 'Puzzle',
      category: EventCategory.knowledge,
      description:
          'Race against time to solve intricate puzzles! Logic, pattern recognition, and speed — you\'ll need them all.',
      icon: Icons.extension,
      posterAsset: 'assets/events/puzzel_event.jpeg',
      day: 3,
      teamSize: 'Individual',
      duration: 'Each round has a fixed time limit.',
      prizePool: 'Certificates + Exciting Rewards',
    ),
    EventModel(
      name: 'Debugging',
      category: EventCategory.tech,
      description:
          'Code debugging challenge with intentionally buggy programs. Find and fix errors in minimal time.',
      icon: Icons.bug_report,
      posterAsset: 'assets/events/debugging_event.jpeg',
      day: 3,
      teamSize: 'Individual',
      duration: '60 minutes',
      prizePool:
          'Certificates + Exciting Rewards \n(as per the decision of the organisers)',
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
