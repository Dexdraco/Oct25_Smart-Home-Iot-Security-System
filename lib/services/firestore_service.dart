import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/alert_model.dart';

class FirestoreService {
  final CollectionReference alertsCollection = FirebaseFirestore.instance
      .collection('motion_alerts');

  Stream<List<AlertModel>> getAlertsStream() {
    return alertsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AlertModel.fromFirestore(doc))
              .toList(),
        );
  }
}
