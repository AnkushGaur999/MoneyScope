import 'package:flutter/material.dart';
import 'dart:ui';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Stack(
          children: [
            _backgroundGlow(),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _profileHeader(),
                  const SizedBox(height: 24),
                  _statsRow(),
                  const SizedBox(height: 24),
                  _actionGrid(),
                  const SizedBox(height: 24),
                  _logoutButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Background ----------
  Widget _backgroundGlow() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.2,
          colors: [Color(0xFF1E2A4A), Color(0xFF0B1220)],
        ),
      ),
    );
  }

  /// ---------- Profile Header ----------
  Widget _profileHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: .08)),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFF2C3A5A),
                    child: Icon(Icons.person, size: 48, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Jessica',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.verified, size: 16, color: Color(0xFF22C55E)),
                  SizedBox(width: 6),
                  Text(
                    'MoneyScope User',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- Balance & Investment ----------
  Widget _statsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.attach_money,
            label: 'Account Balance',
            value: '\$15,825',
            iconColor: const Color(0xFF22C55E),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.bar_chart,
            label: 'Total Investments',
            value: '\$10,530',
            iconColor: const Color(0xFF38BDF8),
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconColor.withValues(alpha: 0.15),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// ---------- Action Grid ----------
  Widget _actionGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _actionTile(Icons.stacked_bar_chart, 'Portfolio')),
            const SizedBox(width: 12),
            Expanded(child: _actionTile(Icons.track_changes, 'Goals')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _actionTile(Icons.pie_chart, 'Insights')),
            const SizedBox(width: 12),
            Expanded(child: _actionTile(Icons.analytics, 'Analysis')),
          ],
        ),
      ],
    );
  }

  Widget _actionTile(IconData icon, String title) {
    return _glassCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white70),
        ],
      ),
    );
  }

  /// ---------- Logout ----------
  Widget _logoutButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
        ),
      ),
      child: const Center(
        child: Text(
          'Log Out',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// ---------- Glass Card ----------
  Widget _glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: child,
        ),
      ),
    );
  }
}
