import 'package:flutter/material.dart';

class UploadResourceScreen extends StatefulWidget {
  static const route = '/upload';
  const UploadResourceScreen({super.key});

  @override
  State<UploadResourceScreen> createState() => _UploadResourceScreenState();
}

class _UploadResourceScreenState extends State<UploadResourceScreen> {
  String? project;
  String? format;

  final descCtrl = TextEditingController();

  @override
  void dispose() {
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(title: const Text('Upload Resource'), backgroundColor: Colors.transparent),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upload your resource to project', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 16),

                const Text('Select Project Name *', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: project,
                  items: const [
                    DropdownMenuItem(value: 'Annual GDP - 2026', child: Text('Annual GDP - 2026')),
                    DropdownMenuItem(value: 'Customer Survey', child: Text('Customer Survey')),
                  ],
                  onChanged: (v) => setState(() => project = v),
                  decoration: _input('Select project name'),
                ),

                const SizedBox(height: 14),
                const Text('Select Data Format', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: format,
                  items: const [
                    DropdownMenuItem(value: 'pdf', child: Text('pdf')),
                    DropdownMenuItem(value: 'xlsx', child: Text('xlsx')),
                    DropdownMenuItem(value: 'csv', child: Text('csv')),
                    DropdownMenuItem(value: 'docx', child: Text('docx')),
                  ],
                  onChanged: (v) => setState(() => format = v),
                  decoration: _input('Select format (ex: doc, docx, pdf, xls)'),
                ),

                const SizedBox(height: 14),
                const Text('Description Data Resource', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                TextField(
                  controller: descCtrl,
                  maxLength: 200,
                  maxLines: 3,
                  decoration: _input('Enter project description'),
                ),

                const SizedBox(height: 10),
                const Text('Upload Data file', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      _fileRow('Account_Detail.xlsx'),
                      const SizedBox(height: 8),
                      _fileRow('Project_Guide_Line.pdf'),
                    ],
                  ),
                ),

                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Delete resource'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Upload resource'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save Project'),
                  ),
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

  Widget _fileRow(String name) {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (_) {}),
        const Icon(Icons.insert_drive_file),
        const SizedBox(width: 8),
        Expanded(child: Text(name)),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: 'Select Category',
          items: const [
            DropdownMenuItem(value: 'Select Category', child: Text('Select Category')),
            DropdownMenuItem(value: 'GDP', child: Text('GDP')),
            DropdownMenuItem(value: 'Population', child: Text('Population')),
          ],
          onChanged: (_) {},
        )
      ],
    );
  }

  InputDecoration _input(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );
}
