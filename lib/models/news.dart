import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    this.total,
    this.news,
    this.notifications,
  });

  int? total;
  List<NewsElement>? news;
  List<dynamic>? notifications;

  factory News.fromJson(Map<String, dynamic> json) => News(
        total: json["total"],
        news: List<NewsElement>.from(
            json["news"].map((x) => NewsElement.fromJson(x))),
        notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        if (news != null)
          "news": List<dynamic>.from(news!.map((x) => x.toJson())),
        if (notifications != null)
          "notifications": List<dynamic>.from(notifications!.map((x) => x)),
      };
}

NewsFull newsFullFromJson(String str) => NewsFull.fromJson(json.decode(str));

String newsFullToJson(NewsFull data) => json.encode(data.toJson());

class NewsFull {
  NewsFull({
    this.news,
    this.notifications,
  });

  NewsElement? news;
  List<dynamic>? notifications;

  factory NewsFull.fromJson(Map<String, dynamic> json) => NewsFull(
        news: NewsElement.fromJson(json["news"]),
        notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        if (news != null) "news": news!.toJson(),
        if (notifications != null)
          "notifications": List<dynamic>.from(notifications!.map((x) => x)),
      };
}

class NewsElement {
  NewsElement({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.pictureUrl,
    this.categoryId,
    this.tags,
    this.category,
    this.direction,
    this.subdirection,
    this.location,
    this.isFavorite,
  });

  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  String? pictureUrl;
  int? categoryId;
  List<String>? tags;
  String? category;
  Direction? direction;
  Direction? subdirection;
  Location? location;
  bool? isFavorite;

  factory NewsElement.fromJson(Map<String, dynamic> json) => NewsElement(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        pictureUrl: json["picture_url"],
        categoryId: json["category_id"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        category: json["category"],
        direction: Direction.fromJson(json["direction"]),
        subdirection: Direction.fromJson(json["subdirection"]),
        location: Location.fromJson(json["location"]),
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        if (createdAt != null) "created_at": createdAt!.toIso8601String(),
        "picture_url": pictureUrl,
        "category_id": categoryId,
        if (tags != null) "tags": List<dynamic>.from(tags!.map((x) => x)),
        "category": category,
        if (direction != null) "direction": direction!.toJson(),
        if (subdirection != null) "subdirection": subdirection!.toJson(),
        if (location != null) "location": location!.toJson(),
        "is_favorite": isFavorite,
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
