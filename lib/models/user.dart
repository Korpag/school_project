import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.user,
    this.notifications,
  });

  UserClass? user;
  List<dynamic>? notifications;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
        notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        if (user != null) "user": user!.toJson(),
        if (notifications != null)
          "notifications": List<dynamic>.from(notifications!.map((x) => x)),
      };
}

class UserClass {
  UserClass({
    this.id,
    this.role,
    this.email,
    this.status,
    this.activatedAt,
    this.privacyStatus,
    this.privacyAgreementUrl,
    this.isCurator,
    this.firstName,
    this.lastName,
    this.patronymic,
    this.avatarUrl,
    this.sex,
    this.aboutMe,
    this.photoNum,
    this.allProjectParticipationsCount,
    this.challengeParticipationsCount,
    this.points,
    this.directions,
    this.location,
    this.createdAllProjectsCount,
    this.createdChallengesCount,
  });

  int? id;
  String? role;
  String? email;
  String? status;
  DateTime? activatedAt;
  String? privacyStatus;
  String? privacyAgreementUrl;
  bool? isCurator;
  String? firstName;
  String? lastName;
  String? patronymic;
  String? avatarUrl;
  String? sex;
  String? aboutMe;
  int? photoNum;
  int? allProjectParticipationsCount;
  int? challengeParticipationsCount;
  int? points;
  List<dynamic>? directions;
  Location? location;
  int? createdAllProjectsCount;
  int? createdChallengesCount;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        role: json["role"],
        email: json["email"],
        status: json["status"],
        activatedAt: DateTime.parse(json["activated_at"]),
        privacyStatus: json["privacy_status"],
        privacyAgreementUrl: json["privacy_agreement_url"],
        isCurator: json["is_curator"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        patronymic: json["patronymic"],
        avatarUrl: json["avatar_url"],
        sex: json["sex"],
        aboutMe: json["about_me"],
        photoNum: json["photo_num"],
        allProjectParticipationsCount: json["all_project_participations_count"],
        challengeParticipationsCount: json["challenge_participations_count"],
        points: json["points"],
        directions: List<dynamic>.from(json["directions"].map((x) => x)),
        location: Location.fromJson(json["location"]),
        createdAllProjectsCount: json["created_all_projects_count"],
        createdChallengesCount: json["created_challenges_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "email": email,
        "status": status,
        if (activatedAt != null) "activated_at": activatedAt!.toIso8601String(),
        "privacy_status": privacyStatus,
        "privacy_agreement_url": privacyAgreementUrl,
        "is_curator": isCurator,
        "first_name": firstName,
        "last_name": lastName,
        "patronymic": patronymic,
        "avatar_url": avatarUrl,
        "sex": sex,
        "about_me": aboutMe,
        "photo_num": photoNum,
        "all_project_participations_count": allProjectParticipationsCount,
        "challenge_participations_count": challengeParticipationsCount,
        "points": points,
        if (directions != null)
          "directions": List<dynamic>.from(directions!.map((x) => x)),
        if (location != null) "location": location!.toJson(),
        "created_all_projects_count": createdAllProjectsCount,
        "created_challenges_count": createdChallengesCount,
      };
}

class Location {
  Location({
    this.title,
    this.school,
    this.municipality,
    this.region,
    this.federalDistrict,
  });

  String? title;
  FederalDistrict? school;
  FederalDistrict? municipality;
  FederalDistrict? region;
  FederalDistrict? federalDistrict;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        title: json["title"],
        school: FederalDistrict.fromJson(json["school"]),
        municipality: FederalDistrict.fromJson(json["municipality"]),
        region: FederalDistrict.fromJson(json["region"]),
        federalDistrict: FederalDistrict.fromJson(json["federal_district"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        if (school != null) "school": school!.toJson(),
        if (municipality != null) "municipality": municipality!.toJson(),
        if (region != null) "region": region!.toJson(),
        if (federalDistrict != null)
          "federal_district": federalDistrict!.toJson(),
      };
}

class FederalDistrict {
  FederalDistrict();

  factory FederalDistrict.fromJson(Map<String, dynamic> json) =>
      FederalDistrict();

  Map<String, dynamic> toJson() => {};
}
