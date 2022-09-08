import 'package:school_project/models/news.dart';
import 'package:school_project/utils/api_request.dart';

/// Запросы
class NewsService {
  /// Получаем список новостей
  Future<News> getNews() async {
    final response = await APIRequest.instance.send('news', APIMethod.get);
    final data = newsFromJson(response.body);
    return data;
  }

  /// Получаем подробную информацию о новости
  Future<NewsFull> getFullNews({int? id}) async {
    final response = await APIRequest.instance.send('news/$id', APIMethod.get);
    final data = newsFullFromJson(response.body);
    return data;
  }
}
