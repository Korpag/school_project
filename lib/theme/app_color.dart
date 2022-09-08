import 'package:flutter/material.dart';

abstract class AppColor {
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color button = Color(0xff5768FA);
  static const Color disabledText = Color(0xffB2B5B9);
  static const Color text = Color(0xff6D7278);
  static const Color textTitle = Color(0xff202020);
  static const Color circularIndicatorColor = Color(0xff707070);
  static const Color favouritesStar = Color(0xff6236FF);
  static const Color favouritesStarThin = Color(0xff585252);
  static const Color projectAppBarGradientFirst = Color(0xffFCDA03);
  static const Color projectAppBarGradientSecond= Color(0xffFCC106);
  static const Color coinDescription = Color(0xff606060);
  static const Color coinBlack = Color(0xff202020);
  static const Color flash = Color(0xffF5F5F5);
  static const Color htmlText = Color(0xff464644);
  static const Color progressBarGradientFirstColor = Color(0xFFA4E0FA);
  static const Color progressBarGradientSecondColor = Color(0xFFC1D6BB);
  static const Color error = Color(0xFFE02020);
  static const Color checkboxGradientFirstColor = Color(0xff5867FA);
  static const Color checkboxGradientSecondColor = Color(0xff7E4bEF);
  static const Color autoCompleteFill = Color(0xffF6F7FF);
  static const Color autoCompleteText = Color(0xff757DBB);
  static const Color taskDone = Color(0xff6DD400);
  static const Color taskCancel = Color(0xffDE4141);
  static const Color imagePickerGradientFirst = Color(0xffABB3FC);
  static const Color imagePickerGradientSecond = Color(0xffBEA4F7);
  static const Color imagePickerErrorGradientFirst = Color(0xffFD8585);
  static const Color imagePickerErrorGradientSecond = Color(0xffFEAC8E);
  static const Color imagePickerShadow = Color(0xff5768FA);
  static const Color textMatch = Color(0xffFFFF99);
  static const Color navbarIconDisabled = Color(0xff989898);
  static const Color newsAppBar = Color(0xff0586C3);
  static const Color newsAppBarText = Color(0xff9CDFFF);
  static const Color shimmerOne = Color(0xffD5D5D5);
  static const Color shimmerTwo = Color(0xffE6E6E6);
  static const Color shimmerThree = Color(0xffA1A1A1);

  /// Временные тест данные для лейблов, пока нет их на беке
  static List<Color> testColor = [button, imagePickerErrorGradientFirst, autoCompleteText, taskDone, Colors.greenAccent, Colors.orangeAccent, autoCompleteText, taskDone, Colors.greenAccent, Colors.orangeAccent, Colors.lightGreen, Colors.blueGrey]..shuffle();
  static List<String> testString = ['Саморазвитие', 'Образование', 'Наука', 'Знания', 'Саморазвитие', 'Образование', 'Наука', 'Знания', 'Саморазвитие', 'Образование', 'Наука', 'Знания']..shuffle();
}
