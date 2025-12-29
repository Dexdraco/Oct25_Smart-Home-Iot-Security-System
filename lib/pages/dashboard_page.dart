import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../providers/alert_provider.dart';
import '../models/alert_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool systemArmed = true;

  final List<_AlertChartData> alertChartData = [
    _AlertChartData('00:00', 2),
    _AlertChartData('04:00', 1),
    _AlertChartData('08:00', 3),
    _AlertChartData('12:00', 5),
    _AlertChartData('16:00', 2),
    _AlertChartData('20:00', 7),
    _AlertChartData('23:00', 4),
  ];

  final List<_Device> devices = [
    _Device('Front Door Sensor', 'Entrance', true, 85),
    _Device('Motion Detector', 'Living Room', true, 92),
    _Device('Window Sensor', 'Bedroom', false, 45),
    _Device('Camera', 'Backyard', true, 100),
  ];

  @override
  Widget build(BuildContext context) {
    final alerts = Provider.of<AlertProvider>(context).alerts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome back! Here's what's happening with your security system",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Status Cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _statusCard(
                  'System Status',
                  systemArmed ? 'Armed' : 'Disarmed',
                  systemArmed ? Icons.shield : Icons.shield_outlined,
                  systemArmed ? Colors.green : Colors.grey,
                ),
                _statusCard(
                  'Active Devices',
                  '12 / 14',
                  Icons.sensors,
                  Colors.blue,
                ),
                _statusCard(
                  'Alerts (24h)',
                  alerts.length.toString(),
                  Icons.notifications,
                  Colors.orange,
                ),
                _statusCard('Critical Alerts', '3', Icons.warning, Colors.red),
              ],
            ),

            const SizedBox(height: 24),

            // Quick Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: systemArmed
                            ? Colors.red
                            : Colors.green,
                      ),
                      onPressed: () {
                        setState(() => systemArmed = !systemArmed);
                      },
                      child: Text(systemArmed ? 'Disarm System' : 'Arm System'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Run System Test'),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settings'),
                      child: const Text('System Settings'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 LIVE FIRESTORE ALERTS (Merged)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Alerts (Live)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    alerts.isEmpty
                        ? const Text('No alerts yet.')
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: alerts.length,
                            itemBuilder: (context, index) {
                              final alert = alerts[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: alert.motion
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                title: Text(
                                  '${alert.device} — ${alert.location}',
                                ),
                                subtitle: Text(
                                  alert.motion
                                      ? 'Motion detected'
                                      : 'No motion',
                                ),
                                trailing: Text(
                                  alert.timestamp.toDate().toString().substring(
                                    0,
                                    16,
                                  ),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Alert Statistics Graph
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alert Statistics (24 Hours)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const labels = [
                                    '00',
                                    '04',
                                    '08',
                                    '12',
                                    '16',
                                    '20',
                                    '23',
                                  ];
                                  if (value.toInt() < labels.length) {
                                    return Text(labels[value.toInt()]);
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: alertChartData
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => FlSpot(
                                      e.key.toDouble(),
                                      e.value.alerts.toDouble(),
                                    ),
                                  )
                                  .toList(),
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Device Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Device Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: devices.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (context, index) {
                        final device = devices[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        device.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      device.active
                                          ? Icons.check_circle
                                          : Icons.warning,
                                      color: device.active
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ],
                                ),
                                Text(
                                  device.location,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                const Spacer(),
                                Text('Battery: ${device.battery}%'),
                                LinearProgressIndicator(
                                  value: device.battery / 100,
                                  color: device.battery > 70
                                      ? Colors.green
                                      : device.battery > 30
                                      ? Colors.orange
                                      : Colors.red,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Icon(icon, color: color, size: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ===========================
   LOCAL DATA MODELS
   =========================== */

class _AlertChartData {
  final String time;
  final int alerts;

  _AlertChartData(this.time, this.alerts);
}

class _Device {
  final String name;
  final String location;
  final bool active;
  final int battery;

  _Device(this.name, this.location, this.active, this.battery);
}
