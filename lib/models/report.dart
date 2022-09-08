import 'dart:convert';

import 'package:school_project/models/project.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  Report({
    this.report,
  });

  ReportClass? report;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        report: ReportClass.fromJson(json["report"]),
      );

  Map<String, dynamic> toJson() => {
        if (report != null) "report": report!.toJson(),
      };
}

class ReportClass {
  ReportClass(
      {this.id,
      this.comment,
      this.status,
      this.taskId,
      this.userId,
      this.photoUrl,
      this.followed,
      this.content,
      this.checkboxes});

  int? id;
  String? comment;
  String? photoUrl;
  String? status;
  int? taskId;
  int? userId;
  bool? followed;
  Content? content;
  List<CheckboxReport>? checkboxes;

  factory ReportClass.fromJson(Map<String, dynamic> json) => ReportClass(
        id: json["id"],
        comment: json["comment"],
        status: json["status"],
        photoUrl: json["photo_url"],
        taskId: json["task_id"],
        userId: json["user_id"],
        followed: json["followed"],
        checkboxes: json["checkboxes"] != null
            ? List<CheckboxReport>.from(
                json["checkboxes"].map((x) => CheckboxReport.fromJson(x)))
            : null,
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "photo_url": photoUrl,
        "status": status,
        "task_id": taskId,
        "user_id": userId,
        "followed": followed,
        if (content != null) "content": content!.toJson(),
        if (checkboxes != null)
          "checkboxes": List<dynamic>.from(checkboxes!.map((x) => x.toJson())),
      };
}

class CheckboxReport {
  CheckboxReport({
    this.taskCheckboxId,
    this.checked,
  });

  int? taskCheckboxId;
  bool? checked;

  factory CheckboxReport.fromJson(Map<String, dynamic> json) => CheckboxReport(
        taskCheckboxId: json["task_checkbox_id"],
        checked: json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "task_checkbox_id": taskCheckboxId,
        "checked": checked,
      };
}
