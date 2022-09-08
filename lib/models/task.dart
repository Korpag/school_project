import 'dart:convert';
import 'package:school_project/models/report.dart';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    this.task,
    this.notifications,
  });

  TaskClass? task;
  List<dynamic>? notifications;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        task: TaskClass.fromJson(json["task"]),
        notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        if (task != null) "task": task!.toJson(),
        if (notifications != null)
          "notifications": List<dynamic>.from(notifications!.map((x) => x)),
      };
}

class TaskClass {
  TaskClass(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.dateOfFinishAcceptingReports,
      this.taskType,
      this.moderated,
      this.checkboxes,
      this.reportId,
      this.projectId,
      this.url,
      this.button,
      this.report});

  int? id;
  String? title;
  String? description;
  String? status;
  DateTime? dateOfFinishAcceptingReports;
  String? taskType;
  bool? moderated;
  int? reportId;
  List<CheckboxClass>? checkboxes;
  String? url;
  int? projectId;
  ReportClass? report;
  ButtonClass? button;

  factory TaskClass.fromJson(Map<String, dynamic> json) => TaskClass(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      status: json["status"],
      dateOfFinishAcceptingReports:
          DateTime.parse(json["date_of_finish_accepting_reports"]),
      taskType: json["task_type"],
      moderated: json["moderated"],
      checkboxes: json["checkboxes"] != null
          ? List<CheckboxClass>.from(
              json["checkboxes"].map((x) => CheckboxClass.fromJson(x)))
          : null,
      reportId: json["report_id"],
      projectId: json["project_id"],
      button: json["button"] != null ? ButtonClass.fromJson(json["button"]) : null,
      url: json["url"],
      report:
          json["report"] != null ? ReportClass.fromJson(json["report"]) : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        if (dateOfFinishAcceptingReports != null)
          "date_of_finish_accepting_reports":
              dateOfFinishAcceptingReports!.toIso8601String(),
        "task_type": taskType,
        "moderated": moderated,
        if (checkboxes != null)
          "checkboxes": List<dynamic>.from(checkboxes!.map((x) => x.toJson())),
        "report_id": reportId,
        "project_id": projectId,
        if (button != null) "button": button!.toJson(),
        "url": url,
        if (report != null) "report": report!.toJson(),
      };
}

class CheckboxClass {
  CheckboxClass({
    this.id,
    this.orderNum,
    this.title,
    this.taskId,
  });

  int? id;
  int? orderNum;
  String? title;
  int? taskId;

  factory CheckboxClass.fromJson(Map<String, dynamic> json) => CheckboxClass(
        id: json["id"],
        orderNum: json["order_num"],
        title: json["title"],
        taskId: json["task_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_num": orderNum,
        "title": title,
        "task_id": taskId,
      };
}

class ButtonClass {
  ButtonClass({
    this.id,
    this.orderNum,
    this.title,
    this.taskId,
  });

  int? id;
  int? orderNum;
  String? title;
  int? taskId;

  factory ButtonClass.fromJson(Map<String, dynamic> json) => ButtonClass(
        id: json["id"],
        orderNum: json["order_num"],
        title: json["title"],
        taskId: json["task_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_num": orderNum,
        "title": title,
        "task_id": taskId,
      };
}
