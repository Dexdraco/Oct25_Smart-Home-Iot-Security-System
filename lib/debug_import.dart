import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/alert_model.dart';

void main() {
  final alert = AlertModel(
    id: 'debug1',
    device: 'ESP32_MOTION_01',
    location: 'Front Door',
    motion: true,
    timestamp: Timestamp.fromDate(DateTime.now()),
  );

  print('Device: ${alert.device}');
  print('Location: ${alert.location}');
  print('Motion: ${alert.motion ? "Detected" : "None"}');
  print('Timestamp: ${alert.timestamp.toDate()}');
}
