import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.analytics)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChartCard(AppLocalizations.of(context)!.moistureTrends, _buildMoistureChart()),
              _buildChartCard(AppLocalizations.of(context)!.irrigationCycles, _buildIrrigationChart()),
              _buildChartCard(AppLocalizations.of(context)!.tankLevelTrends, _buildTankLevelChart()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }

  Widget _buildMoistureChart() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sensor_history')
          .orderBy('timestamp', descending: true)
          .limit(20)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final data = snapshot.data!.docs;
        List<FlSpot> spots = [];
        for (int i = 0; i < data.length; i++) {
          spots.add(FlSpot(i.toDouble(), data[i]['soil_moisture'].toDouble()));
        }

        return LineChart(
          LineChartData(lineBarsData: [LineChartBarData(spots: spots)]),
        );
      },
    );
  }

  Widget _buildIrrigationChart() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('irrigation_history')
          .orderBy('timestamp', descending: true)
          .limit(20)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final data = snapshot.data!.docs;
        List<BarChartGroupData> barGroups = [];
        for (int i = 0; i < data.length; i++) {
          barGroups.add(
            BarChartGroupData(
              x: i,
              barRods: [BarChartRodData(toY: data[i]['valve_on'] ? 1 : 0)],
            ),
          );
        }

        return BarChart(BarChartData(barGroups: barGroups));
      },
    );
  }

  Widget _buildTankLevelChart() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sensor_history')
          .orderBy('timestamp', descending: true)
          .limit(20)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final data = snapshot.data!.docs;
        List<FlSpot> spots = [];
        for (int i = 0; i < data.length; i++) {
          spots.add(
            FlSpot(i.toDouble(), data[i]['water_tank_level'].toDouble()),
          );
        }

        return LineChart(
          LineChartData(lineBarsData: [LineChartBarData(spots: spots)]),
        );
      },
    );
  }
}
