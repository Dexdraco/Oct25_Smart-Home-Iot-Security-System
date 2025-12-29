import 'package:flutter/material.dart';
import '../models/alert_model.dart';
import '../services/firestore_service.dart';

class AlertProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<AlertModel> _alerts = [];

  List<AlertModel> get alerts => _alerts;

  void listenToAlerts() {
    _firestoreService.getAlertsStream().listen((data) {
      _alerts = data;
      notifyListeners();
    });
  }
}
