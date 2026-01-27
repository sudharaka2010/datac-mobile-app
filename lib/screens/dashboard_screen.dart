import 'package:flutter/material.dart';
import '../widgets/datac_drawer.dart';
import 'new_project_screen.dart';
import 'upload_resource_screen.dart';
import 'view_project_screen.dart';
import 'account_settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color.fromRGBO(48, 50, 61, 1);

    return Scaffold(
      drawer: const DatacDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => Navigator.pushNamed(context, AccountSettingsScreen.route),
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/bg_dark.png', fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.40)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.60),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(), // ✅ iOS feel
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        // ✅ iOS header (small brand + large title)
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                              ),
                              child: Text(
                                'DATAC',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  color: brandColor,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Today',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withValues(alpha: 0.70),
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Dashboard',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            fontSize: 32,
                            color: Colors.white,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Manage projects, uploads, and insights in one place.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            height: 1.35,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ✅ iOS-style summary glass card
                        _summaryCard(),

                        const SizedBox(height: 18),

                        Row(
                          children: [
                            const Text(
                              'Quick Actions',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                AccountSettingsScreen.route,
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white.withValues(alpha: 0.85),
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(10, 10),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'View Settings',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),

                // ✅ Modern iOS cards grid
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.crossAxisExtent;
                      final cols = w >= 700 ? 3 : 2;

                      return SliverGrid(
                        delegate: SliverChildListDelegate(
                          [
                            _iosTile(
                              context,
                              icon: Icons.folder_open_rounded,
                              title: 'New Project',
                              subtitle: 'Create a workspace',
                              route: NewProjectScreen.route,
                            ),
                            _iosTile(
                              context,
                              icon: Icons.cloud_upload_rounded,
                              title: 'Upload Resource',
                              subtitle: 'Add files & datasets',
                              route: UploadResourceScreen.route,
                            ),
                            _iosTile(
                              context,
                              icon: Icons.search_rounded,
                              title: 'View Projects',
                              subtitle: 'Search & open',
                              route: ViewProjectScreen.route,
                            ),
                            _iosTile(
                              context,
                              icon: Icons.edit_note_rounded,
                              title: 'Edit Project',
                              subtitle: 'Update details',
                              route: ViewProjectScreen.route,
                            ),
                            _iosTile(
                              context,
                              icon: Icons.tune_rounded,
                              title: 'Project Settings',
                              subtitle: 'Permissions & options',
                              route: ViewProjectScreen.route,
                            ),
                            _iosTile(
                              context,
                              icon: Icons.delete_outline_rounded,
                              title: 'Delete Project',
                              subtitle: 'Remove old work',
                              route: ViewProjectScreen.route,
                              danger: true,
                            ),
                          ],
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cols,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 1.08,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Summary card (iOS glass + aligned stat pills)
  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Quick snapshot of your activity.',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white.withValues(alpha: 0.70),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _StatPill(label: 'Projects', value: '08')),
              SizedBox(width: 10),
              Expanded(child: _StatPill(label: 'Uploads', value: '24')),
              SizedBox(width: 10),
              Expanded(child: _StatPill(label: 'Insights', value: '12')),
            ],
          )
        ],
      ),
    );
  }

  // ✅ iOS-style tile
  Widget _iosTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
    bool danger = false,
  }) {
    final iconBg = danger
        ? Colors.red.withValues(alpha: 0.18)
        : Colors.white.withValues(alpha: 0.12);

    final iconColor = danger ? Colors.redAccent : Colors.white;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top row (icon capsule + chevron)
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: 0.55),
                )
              ],
            ),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.8,
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Separate stat pill widget for perfect alignment
class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  const _StatPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }
}
