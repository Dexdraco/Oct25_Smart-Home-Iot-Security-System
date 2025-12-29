import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool motionDetected = MockDataService.getLiveMotionStatus();

    return Scaffold(
      appBar: AppBar(title: const Text('Live Monitoring')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sensors,
              size: 80,
              color: motionDetected ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 10),
            Text(
              motionDetected ? 'MOTION DETECTED' : 'NO MOTION',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
