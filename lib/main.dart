import 'package:flutter/material.dart';
import 'package:rotina/app.dart';
import 'package:rotina/core/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDi();
  runApp(const RotinaApp());
}
