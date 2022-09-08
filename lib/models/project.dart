import 'dart:convert';
import 'package:school_project/models/task.dart';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    this.total,
    this.projects,
  });

  int? total;
  List<ProjectElement>? projects;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        total: json["total"],
        projects: List<ProjectElement>.from(
            json["projects"].map((x) => ProjectElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        if (projects != null)
          "projects": List<dynamic>.from(projects!.map((x) => x.toJson())),
      };
}

ProjectFull projectFullFromJson(String str) =>
    ProjectFull.fromJson(json.decode(str));

String projectFullToJson(ProjectFull data) => json.encode(data.toJson());

class ProjectFull {
  ProjectFull({
    this.project,
    this.notifications,
  });

  ProjectElement? project;
  List<dynamic>? notifications;

  factory ProjectFull.fromJson(Map<String, dynamic> json) => ProjectFull(
        project: ProjectElement.fromJson(json["project"]),
        notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        if (project != null) "project": project!.toJson(),
        if (notifications != null)
          "notifications": List<dynamic>.from(notifications!.map((x) => x)),
      };
}

class ProjectElement {
  ProjectElement({
    this.id,
    this.title,
    this.photoUrl,
    this.description,
    this.dateOfStart,
    this.dateOfFinish,
    this.restriction,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.points,
    this.status,
    this.shortDescription,
    this.urlVideo,
    this.illustration,
    this.createdAt,
    this.tasks,
    this.category,
    this.direction,
    this.subdirection,
    this.location,
    this.participantsCount,
    this.content,
    this.tags,
    this.isParticipated,
    this.isFavorite,
    this.isLiked,
    this.isTarget,
  });

  int? id;
  String? title;
  String? photoUrl;
  String? description;
  DateTime? dateOfStart;
  DateTime? dateOfFinish;
  String? restriction;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  int? points;
  String? status;
  String? shortDescription;
  String? urlVideo;
  String? illustration;
  DateTime? createdAt;
  String? category;
  Direction? direction;
  Direction? subdirection;
  Direction? location;
  int? participantsCount;
  Content? content;
  List<String>? tags;
  bool? isParticipated;
  bool? isFavorite;
  bool? isLiked;
  bool? isTarget;
  List<TaskClass>? tasks;

  factory ProjectElement.fromJson(Map<String, dynamic> json) => ProjectElement(
        id: json["id"],
        title: json["title"],
        photoUrl: json["photo_url"],
        description: json["description"],
        dateOfStart: DateTime.parse(json["date_of_start"]),
        dateOfFinish: DateTime.parse(json["date_of_finish"]),
        restriction: json["restriction"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        points: json["points"],
        status: json["status"],
        shortDescription: json["short_description"],
        urlVideo: json["url_video"],
        illustration: json["illustration"],
        createdAt: DateTime.parse(json["created_at"]),
        tasks: List<TaskClass>.from(json["tasks"].map((x) => TaskClass.fromJson(x))),
        category: json["category"],
        direction: Direction.fromJson(json["direction"]),
        subdirection: Direction.fromJson(json["subdirection"]),
        location: Direction.fromJson(json["location"]),
        participantsCount: json["participants_count"],
        content: Content.fromJson(json["content"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        isParticipated: json["is_participated"],
        isFavorite: json["is_favorite"],
        isLiked: json["is_liked"],
        isTarget: json["is_target"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photo_url": photoUrl,
        "description": description,
        if (dateOfStart != null)
          "date_of_start": dateOfStart!.toIso8601String(),
        if (dateOfFinish != null)
          "date_of_finish": dateOfFinish!.toIso8601String(),
        "restriction": restriction,
        "contact_name": contactName,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "points": points,
        "status": status,
        "short_description": shortDescription,
        "url_video": urlVideo,
        "illustration": illustration,
        if (createdAt != null) "created_at": createdAt!.toIso8601String(),
        if (tasks != null) "tasks": List<TaskClass>.from(tasks!.map((x) => x)),
        "category": category,
        if (direction != null) "direction": direction!.toJson(),
        if (subdirection != null) "subdirection": subdirection!.toJson(),
        if (location != null) "location": location!.toJson(),
        "participants_count": participantsCount,
        if (content != null) "content": content!.toJson(),
        if (tags != null) "tags": List<dynamic>.from(tags!.map((x) => x)),
        "is_participated": isParticipated,
        "is_favorite": isFavorite,
        "is_liked": isLiked,
        "is_target": isTarget,
      };
}

class Content {
  Content({
    this.media,
    this.other,
    this.links,
  });

  List<dynamic>? media;
  List<dynamic>? other;
  List<dynamic>? links;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        media: List<dynamic>.from(json["media"].map((x) => x)),
        other: List<dynamic>.from(json["other"].map((x) => x)),
        links: List<dynamic>.from(json["links"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        if (media != null) "media": List<dynamic>.from(media!.map((x) => x)),
        if (other != null) "other": List<dynamic>.from(other!.map((x) => x)),
        if (links != null) "links": List<dynamic>.from(links!.map((x) => x)),
      };
}

class Direction {
  Direction({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Location {
  Location();

  factory Location.fromJson(Map<String, dynamic> json) => Location();

  Map<String, dynamic> toJson() => {};
}
