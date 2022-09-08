import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


/// Обязательный MaterialApp для тестирования UI виджетов
class RequiredMaterialApp extends StatelessWidget {
  final Widget widget;

  const RequiredMaterialApp({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ], supportedLocales: const [
      Locale('ru'),
    ], locale: const Locale('ru'), home: widget);
  }
}