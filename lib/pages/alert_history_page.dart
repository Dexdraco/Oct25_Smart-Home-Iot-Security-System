import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/alert_model.dart';
import '../services/mock_data_service.dart';

class AlertHistoryPage extends StatelessWidget {
  const AlertHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AlertModel> alerts = MockDataService.getAlerts();

    return Scaffold(
      appBar: AppBar(title: const Text('Alert History')),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];

          return ListTile(
            leading: Icon(
              alert.motion ? Icons.warning : Icons.check_circle,
              color: alert.motion ? Colors.red : Colors.green,
            ),
            title: Text(alert.device),
            subtitle: Text(
              '${alert.location} • ${DateFormat.yMd().add_jm().format(alert.timestamp.toDate())}',
            ),
            trailing: alert.motion
                ? const Icon(Icons.priority_high, color: Colors.red)
                : const Icon(Icons.check, color: Colors.green),
          );
        },
      ),
    );
  }
}
