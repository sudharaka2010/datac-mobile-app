import 'package:flutter/material.dart';
import '../screens/account_settings_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/new_project_screen.dart';
import '../screens/upload_resource_screen.dart';
import '../screens/view_project_screen.dart';

class DatacDrawer extends StatelessWidget {
  const DatacDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('User Profile', style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('DATAC'),
            ),
            const Divider(),
            _item(
              context,
              icon: Icons.manage_accounts,
              label: 'Account',
              route: AccountSettingsScreen.route,
            ),
            _item(context, icon: Icons.dashboard, label: 'Dashboard', route: DashboardScreen.route),
            _item(context, icon: Icons.folder, label: 'Projects', route: ViewProjectScreen.route),
            _item(context, icon: Icons.add_box, label: 'New Project', route: NewProjectScreen.route),
            _item(context, icon: Icons.cloud_upload, label: 'Resource', route: UploadResourceScreen.route),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  static Widget _item(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}
