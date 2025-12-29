import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/alert_model.dart';

class MockDataService {
  static List<AlertModel> getAlerts() {
    return [
      AlertModel(
        id: 'mock1',
        device: 'ESP32_MOTION_01',
        location: 'Front Door',
        motion: true,
        timestamp: Timestamp.fromDate(
          DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ),
      AlertModel(
        id: 'mock2',
        device: 'ESP32_MOTION_02',
        location: 'Living Room',
        motion: false,
        timestamp: Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ),
    ];
  }

  static bool getLiveMotionStatus() {
    // Simulated motion toggle every second
    return DateTime.now().second % 2 == 0;
  }
}
