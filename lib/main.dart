import 'package:flutter/material.dart';
import 'package:school_project/pages/hard_auth.dart';
import 'package:school_project/services/news.dart';
import 'package:school_project/services/project.dart';
import 'package:school_project/services/user.dart';
import 'package:school_project/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/utils/api_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIRequest.instance = APIRequest();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HomeUserService()),
        RepositoryProvider(create: (context) => ProjectService()),
        RepositoryProvider(create: (context) => NewsService()),
        RepositoryProvider(create: (context) => ReportService()),
        RepositoryProvider(create: (context) => TaskService()),
      ],
      child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ru'),
          ],
          locale: const Locale('ru'),
          title: '',
          theme: appThemeData,
          home: const HardAuth()),
    );
  }
}