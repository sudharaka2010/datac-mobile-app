import 'package:flutter/material.dart';

class NewProjectScreen extends StatefulWidget {
  static const route = '/new-project';
  const NewProjectScreen({super.key});

  @override
  State<NewProjectScreen> createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final tagsCtrl = TextEditingController();
  String? type;

  @override
  void dispose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    tagsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('New Project'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create a container to store data', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 16),

                const Text('Project Name *', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                TextField(
                  controller: nameCtrl,
                  decoration: _input('Enter project name'),
                ),

                const SizedBox(height: 14),
                const Text('Description', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                TextField(
                  controller: descCtrl,
                  maxLength: 200,
                  maxLines: 3,
                  decoration: _input('Enter project description'),
                ),

                const SizedBox(height: 10),
                const Text('Project Type *', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: type,
                  items: const [
                    DropdownMenuItem(value: 'GDP', child: Text('GDP')),
                    DropdownMenuItem(value: 'Survey', child: Text('Survey')),
                    DropdownMenuItem(value: 'Research', child: Text('Research')),
                  ],
                  onChanged: (v) => setState(() => type = v),
                  decoration: _input('Select Types'),
                ),

                const SizedBox(height: 14),
                const Text('Tags', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                TextField(
                  controller: tagsCtrl,
                  decoration: _input('Add tags'),
                ),

                const SizedBox(height: 18),
                const Text('Resource', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload from device'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Take a photo'),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Create Project'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('DATAC Company Pvtet Ltd.', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _input(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );
}
