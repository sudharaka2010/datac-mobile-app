import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ViewProjectScreen extends StatefulWidget {
  static const route = '/view';
  const ViewProjectScreen({super.key});

  @override
  State<ViewProjectScreen> createState() => _ViewProjectScreenState();
}

class _ViewProjectScreenState extends State<ViewProjectScreen> {
  String? project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(title: const Text('View Project'), backgroundColor: Colors.transparent),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('View your project details', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                const Text('Select Project Name *', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: project,
                  items: const [
                    DropdownMenuItem(value: 'Annual GDP - 2026', child: Text('Annual GDP - 2026')),
                    DropdownMenuItem(value: 'Customer Survey', child: Text('Customer Survey')),
                  ],
                  onChanged: (v) => setState(() => project = v),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Annual GDP - 2026', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),

                // Chart Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      height: 180,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(show: false),
                          gridData: FlGridData(show: false),
                          barGroups: [
                            _bar(0, 80),
                            _bar(1, 55),
                            _bar(2, 30),
                            _bar(3, 70),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text('Category', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: 'GDP',
                  items: const [
                    DropdownMenuItem(value: 'GDP', child: Text('GDP')),
                    DropdownMenuItem(value: 'Population', child: Text('Population')),
                  ],
                  onChanged: (_) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 16),

                // Progress list like your second view screenshot
                Expanded(
                  child: ListView(
                    children: const [
                      _ProgressRow(label: 'Wholesale & Retail Trade', value: 0.50),
                      _ProgressRow(label: 'Transportation & Storage', value: 0.30),
                      _ProgressRow(label: 'Tourism & Hospitality', value: 0.65),
                      _ProgressRow(label: 'Banking, Finance & Insurance', value: 0.433),
                      _ProgressRow(label: 'Information & Communication Technology (ICT)', value: 0.515),
                      _ProgressRow(label: 'Public Administration, Education & Health', value: 0.672),
                    ],
                  ),
                ),
                const Text('DATAC Company Pvtet Ltd.', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 14,
          borderRadius: BorderRadius.circular(8),
        )
      ],
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final double value;
  const _ProgressRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).toStringAsFixed(1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
                  Text('$percent%'),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(value: value, minHeight: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
