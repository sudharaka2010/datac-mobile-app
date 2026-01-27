import 'package:flutter/material.dart';
import '../widgets/datac_drawer.dart';

class AccountSettingsScreen extends StatelessWidget {
  static const route = '/account';
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DatacDrawer(),
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('DATAC'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                  const SizedBox(height: 10),
                  const Text('Peter Nelson', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const Text('peter.nelson@outlook.com'),
                  const Text('ID:#123456', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 18),
                  _card('Change Password'),
                  _card('Two-Factor Authentication'),
                  _card('Login Activity'),
                  _card('Primary Email Changed'),
                  _card('Data & Storage'),
                  const SizedBox(height: 18),
                  const Divider(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Privacy & policy\nCompany Details\nUser Guide',
                        style: TextStyle(color: Colors.black54)),
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('DATAC Company Pvtet Ltd.',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ),
    );
  }
}
