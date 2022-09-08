import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';

abstract class CustomIcons {
  /// Иконка рубля для главной
  static Image rub = _image(src: 'rub');

  /// Иконка стикеров для главной
  static Image sticker = _image(src: 'sticker');

  /// Иконка стикеров для главной
  static Image rubProject = _image(src: 'rub_project');

  /// Иконка главной для навбара
  static Image home({Color color = AppColor.navbarIconDisabled}) {
    return _image(src: 'home', color: color);
  }

  /// Иконка заданий для навбара
  static Image tasks({Color color = AppColor.navbarIconDisabled}) {
    return _image(src: 'tasks', color: color);
  }

  /// Иконка новостей для навбара
  static Image news({Color color = AppColor.navbarIconDisabled}) {
    return _image(src: 'news', color: color);
  }

  /// Иконка призов для навбара
  static Image prizes({Color color = AppColor.navbarIconDisabled}) {
    return _image(src: 'prizes', color: color);
  }

  /// Иконка кнопки назад
  static Image backButton({Color color = AppColor.white}) {
    return _image(src: 'back_button', color: color);
  }

  /// Иконка телефона
  static Image mobile({Color color = AppColor.white}) {
    return _image(src: 'mobile', color: color);
  }

  /// Иконка избранного
  static Image favourite({Color color = AppColor.white}) {
    return _image(src: 'favourite', color: color);
  }
}

Image _image({Color? color, required String src}) {
  return Image.asset('lib/assets/images/icons/$src.png', color: color);
}
