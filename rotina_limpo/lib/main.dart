import 'package:flutter/material.dart';
import 'package:rotina_limpo/app.dart';
import 'package:rotina_limpo/core/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDi();
  runApp(const RotinaApp());
}
