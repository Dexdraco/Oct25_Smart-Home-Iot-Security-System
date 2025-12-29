import 'package:flutter/material.dart';
import 'package:iot_security_app/pages/login_page.dart';
import 'package:iot_security_app/pages/dashboard_page.dart';
import 'package:iot_security_app/pages/monitoring_page.dart';
import 'package:iot_security_app/pages/alert_history_page.dart';
import 'package:iot_security_app/pages/settings_page.dart';
import 'package:iot_security_app/pages/profile_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginPage(),
  '/dashboard': (context) => const DashboardPage(),
  '/monitoring': (context) => const MonitoringPage(),
  '/alerts': (context) => const AlertHistoryPage(),
  '/settings': (context) => const SettingsPage(),
  '/profile': (context) => const ProfilePage(),
};
