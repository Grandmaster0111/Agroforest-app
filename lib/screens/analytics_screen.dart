import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/gen_l10n/app_localizations.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.analytics),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildChartCard(
            title: AppLocalizations.of(context)!.moistureTrends,
            child: _buildMoistureChart(),
          ),
          _buildChartCard(
            title: AppLocalizations.of(context)!.irrigationCycles,
            child: _buildIrrigationChart(),
          ),
          _buildChartCard(
            title: AppLocalizations.of(context)!.tankLevelTrends,
            child: _buildTankLevelChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({required String title, required Widget child}) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200,
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoistureChart() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sensor_data_history')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.docs;
        final spots = data.asMap().entries.map((entry) {
          final index = entry.key;
          final doc = entry.value;
          final moisture = (doc['soil_moisture'] as num).toDouble();
          return FlSpot(index.toDouble(), moisture);
        }).toList();

        return LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 3,
                color: Colors.blue,
              ),
            ],
            titlesData: const FlTitlesData(show: false),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
        );
      },
    );
  }

  Widget _buildIrrigationChart() {
    // Placeholder for irrigation cycle chart
    return const Center(child: Text('Irrigation cycle data unavailable.'));
  }

  Widget _buildTankLevelChart() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sensor_data_history')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.docs;
        final spots = data.asMap().entries.map((entry) {
          final index = entry.key;
          final doc = entry.value;
          final tankLevel = (doc['water_tank_level'] as num).toDouble();
          return FlSpot(index.toDouble(), tankLevel);
        }).toList();

        return LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 3,
                color: Colors.green,
              ),
            ],
            titlesData: const FlTitlesData(show: false),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
        );
      },
    );
  }
}
