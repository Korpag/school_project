import 'package:image_picker/image_picker.dart';
import 'package:school_project/models/project.dart';
import 'package:school_project/models/report.dart';
import 'package:school_project/models/task.dart';
import 'package:school_project/utils/api_request.dart';

/// Запросы для проектов
class ProjectService {
  /// Получаем список проектов
  Future<Project> getProject() async {
    final response = await APIRequest.instance.send('projects', APIMethod.get);
    final data = projectFromJson(response.body);
    return data;
  }

  /// Получаем подробную информацию о проекте
  Future<ProjectFull> getFullProject({int? id}) async {
    final response =
        await APIRequest.instance.send('projects/$id', APIMethod.get);
    final data = projectFullFromJson(response.body);
    return data;
  }

  /// Поиск проектов
  Future<Project> getSearchProject({String? searchText}) async {
    final response = await APIRequest.instance
        .send('projects/search', APIMethod.get, data: {"search": searchText});
    final data = projectFromJson(response.body);
    return data;
  }
}

/// Запрос подробной информации для репортов
class ReportService {
  Future<Report> getReport({int? id}) async {
    final response =
        await APIRequest.instance.send('reports/$id', APIMethod.get);
    final data = reportFromJson(response.body);
    return data;
  }
}

/// Запросы для тасков
class TaskService {
  /// Получить информацию о таске
  Future<Task> getTask({int? id}) async {
    final response = await APIRequest.instance.send('tasks/$id', APIMethod.get);
    final data = taskFromJson(response.body);
    return data;
  }

  /// Отправить репорт
  Future postTask(
      {int? id, String? textTask, List? checkboxes, bool? buttonPushed}) async {
    await APIRequest.instance.send('reports', APIMethod.post, data: {
      "report": {
        "comment": textTask,
        "task_id": id,
        "checkboxes": checkboxes,
        "button_pushed": buttonPushed
      }
    });
  }

  /// Отправить репорт для изображений
  Future postImageTask({int? id, XFile? xFile}) async {
    var _response =
        await APIRequest.instance.send('reports', APIMethod.post, data: {
      "report": {"task_id": id}
    });
    if (_response['statusCode'] == 201) {
      if (xFile != null) {
        await APIRequest.instance.send(
            'reports/${_response["data"]["report"]["id"]}', APIMethod.patch,
            isMultipart: true,
            stream: xFile.readAsBytes().asStream(),
            length: await xFile.length(),
            field: "report[photo_source]");
      }
    }
  }

  /// Изменение статуса репорта (для модераторов и учителей)
  Future postChangeStatusReport({int? id, String? newStatus}) async {
    await APIRequest.instance
        .send('reports/$id/change_status', APIMethod.post, data: {
      "report": {
        "status": newStatus,
      }
    });
  }
}
