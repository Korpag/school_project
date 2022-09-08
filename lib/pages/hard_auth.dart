import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_image.dart';
import 'package:school_project/utils/api_config.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/main_window.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Хардкорная страница авторизации, для получения токена. Чтобы не прописывать его каждый раз, пока не готова авторизация/регистрация

class HardAuth extends StatelessWidget {
  const HardAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.projectAppBarGradientFirst,
                  AppColor.projectAppBarGradientSecond,
                ]),
            image: DecorationImage(
                opacity: 0.1, image: AssetImage(CustomImage.background))),
        child: Center(
            child: Button(
          text: 'Войти',
          horizontalPadding: 40,
          fillColor: false,
          fontSize: 28,
          onTap: () async {
            final Map body = {
              "session": {"email": "gfsem@mail.ru", "password": "oneasy2022"}
            };
            final jsonString = json.encode(body);
            await http.post(Uri.parse('${APIConfig.url}/login'),
                body: jsonString,
                headers: {
                  "Content-Type": "application/json"
                }).then((value) {
              getToken(value: value.headers['x-auth-token']!);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainWindow()));
            });
          },
        )),
      ),
    );
  }
}

getToken({required String value}) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('key', value);
}
