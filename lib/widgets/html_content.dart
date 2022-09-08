import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:school_project/theme/app_color.dart';

class HtmlContent extends StatelessWidget {
  final String? data;

  const HtmlContent({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data ?? '',
      style: {
        'body': Style(
            fontFamily: 'Inter',
            color: AppColor.htmlText,
            margin: EdgeInsets.zero)
      },
    );
  }
}
