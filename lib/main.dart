import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:iot_security_app/utils/app_routes.dart';
import 'package:iot_security_app/pages/login_page.dart';
import 'package:iot_security_app/providers/alert_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Firebase init
  runApp(const IoTSecurityApp());
}

class IoTSecurityApp extends StatelessWidget {
  const IoTSecurityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AlertProvider()..listenToAlerts(),
        ),
      ],
      child: MaterialApp(
        title: 'IoT Security System',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: appRoutes,
        home: const LoginPage(),
      ),
    );
  }
}
