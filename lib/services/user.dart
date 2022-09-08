import 'package:school_project/models/user.dart';
import 'package:school_project/utils/api_request.dart';

/// Запросы
class HomeUserService {
  /// Получаем информацию о пользователе
  Future<User> getUser() async {
    // TODO пока хардкором id, пока нет авторизации
    final response = await APIRequest.instance.send('users/3', APIMethod.get);
    final data = userFromJson(response.body);
    return data;
  }
}
