import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_icons.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/custom_appbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final ThemeData _theme = Theme.of(context);
    return Stack(
      children: [
        /// Сканнер
        MobileScanner(onDetect: (barcode, args) {
          if (barcode.rawValue != null) {
            _code = barcode.rawValue!;
            setState(() {});
          }
        }),
        Column(children: [
          /// AppBar
          CustomAppBar.mini(),

          /// Контейнер с информацией
          Container(
            height: _height * 0.163,
            color: AppColor.coinBlack.withOpacity(0.95),
            child: Center(
                child: Text(
              'Наведи камеру на QR код и нажми кнопку «сканировать»',
              textAlign: TextAlign.center,
              style: _theme.textTheme.caption,
            )),
          ),

          /// Контейнер с графическими рамками/зоной скана
          Expanded(
              child: Container(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset('lib/assets/images/qr.png')),
          )),

          /// Контейнер с кнопкой скана
          Container(
            height: _height * 0.26,
            color: AppColor.coinBlack.withOpacity(0.95),
            child: Center(
                child: Button(
              height: 100,
              widgetIcon: RotatedBox(
                  quarterTurns: 3,
                  child: Transform.scale(
                      scale: 0.6,
                      child: CustomIcons.mobile(
                          color: _code == ''
                              ? AppColor.disabledText
                              : AppColor.white))),
              onTap: () async {
                if (_code != '') {
                  http.get(Uri.parse(_code)).then((value) {
                    if (value.statusCode == 200) {
                      // todo что происходит если успешное чтение QR
                    }
                  });
                  _code = '';
                }
              },
            )),
          ),
        ]),
      ],
    );
  }
}
