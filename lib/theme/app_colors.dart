import 'package:flutter/material.dart';

/// Manthan 2026 — Design System Colors
class AppColors {
  AppColors._();

  // ── Core Palette ──────────────────────────────────────────────
  static const Color background = Color(0xFF0A0E1A);
  static const Color backgroundLight = Color(0xFF0F1629);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceLight = Color(0xFF1E293B);
  static const Color surfaceGlass = Color(0x99111827); // 60% opacity

  // ── Brand Colors ──────────────────────────────────────────────
  static const Color primary = Color(0xFF6366F1);       // Indigo
  static const Color primaryGlow = Color(0xFF818CF8);    // Lighter indigo
  static const Color primaryDark = Color(0xFF4F46E5);    // Deeper indigo
  static const Color accent = Color(0xFF06B6D4);         // Cyan
  static const Color accentGlow = Color(0xFF22D3EE);     // Lighter cyan
  static const Color accentWarm = Color(0xFFF59E0B);     // Amber (featured)
  static const Color accentWarmGlow = Color(0xFFFBBF24); // Lighter amber
  static const Color accentPink = Color(0xFFEC4899);     // Pink accent

  // ── Text Colors ───────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // ── Status Colors ─────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  // ── Category Colors ───────────────────────────────────────────
  static const Color categoryTech = Color(0xFF6366F1);
  static const Color categorySports = Color(0xFF10B981);
  static const Color categoryGaming = Color(0xFFEF4444);
  static const Color categoryCreative = Color(0xFFF59E0B);
  static const Color categoryKnowledge = Color(0xFF8B5CF6);

  // ── Gradients ─────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient featuredGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), accentPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [accentWarm, Color(0xFFEF4444)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surface, backgroundLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x80000000),
      background,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.6, 1.0],
  );

  // ── Glow Shadows ──────────────────────────────────────────────
  static List<BoxShadow> primaryGlowShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.4),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> accentGlowShadow = [
    BoxShadow(
      color: accent.withValues(alpha: 0.4),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> featuredGlowShadow = [
    BoxShadow(
      color: accentWarm.withValues(alpha: 0.3),
      blurRadius: 30,
      spreadRadius: 0,
    ),
  ];
}
