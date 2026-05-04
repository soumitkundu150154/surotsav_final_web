import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/particle_background.dart';
import 'widgets/responsive_navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/events_section.dart';
import 'sections/featured_event_section.dart';
import 'sections/team_section.dart';
import 'sections/registration_section.dart';
import 'sections/footer_section.dart';

void main() {
  runApp(const ManthanApp());
}

class ManthanApp extends StatelessWidget {
  const ManthanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manthan 2026 — Surotsav Tech Fest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const ManthanHomePage(),
    );
  }
}

class ManthanHomePage extends StatefulWidget {
  const ManthanHomePage({super.key});

  @override
  State<ManthanHomePage> createState() => _ManthanHomePageState();
}

class _ManthanHomePageState extends State<ManthanHomePage> {
  final _scrollController = ScrollController();

  // Section keys for scroll navigation
  final _sectionKeys = <String, GlobalKey>{
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'events': GlobalKey(),
    'featured': GlobalKey(),
    'team': GlobalKey(),
    'register': GlobalKey(),
  };

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Particle background (fixed)
          const Positioned.fill(
            child: ParticleBackground(),
          ),

          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                // Hero
                Container(
                  key: _sectionKeys['hero'],
                  child: HeroSection(
                    onRegisterTap: () => _scrollToSection('register'),
                    onExploreTap: () => _scrollToSection('events'),
                  ),
                ),

                // About
                Container(
                  key: _sectionKeys['about'],
                  child: const AboutSection(),
                ),

                // Events
                Container(
                  key: _sectionKeys['events'],
                  child: const EventsSection(),
                ),

                // Featured
                Container(
                  key: _sectionKeys['featured'],
                  child: FeaturedEventSection(
                    onRegisterTap: () => _scrollToSection('register'),
                  ),
                ),

                // Team
                Container(
                  key: _sectionKeys['team'],
                  child: const TeamSection(),
                ),

                // Registration
                Container(
                  key: _sectionKeys['register'],
                  child: const RegistrationSection(),
                ),

                // Footer
                FooterSection(
                  onAboutTap: () => _scrollToSection('about'),
                  onEventsTap: () => _scrollToSection('events'),
                  onRegisterTap: () => _scrollToSection('register'),
                ),
              ],
            ),
          ),

          // Navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ResponsiveNavbar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}
