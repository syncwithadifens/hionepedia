// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  String? status;
  List<Favorited>? favorited;

  FavoriteModel({
    this.status,
    this.favorited,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        status: json["status"],
        favorited: json["favorited"] == null
            ? []
            : List<Favorited>.from(
                json["favorited"]!.map((x) => Favorited.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "favorited": favorited == null
            ? []
            : List<dynamic>.from(favorited!.map((x) => x.toJson())),
      };
}

class Favorited {
  String? animalId;
  String? name;
  String? slug;
  String? description;
  String? thumbnail;
  String? sound;
  String? model;
  String? offline;
  DateTime? createdAt;
  String? favoriteId;
  String? userId;

  Favorited({
    this.animalId,
    this.name,
    this.slug,
    this.description,
    this.thumbnail,
    this.sound,
    this.model,
    this.offline,
    this.createdAt,
    this.favoriteId,
    this.userId,
  });

  factory Favorited.fromJson(Map<String, dynamic> json) => Favorited(
        animalId: json["animal_id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        sound: json["sound"],
        model: json["model"],
        offline: json["offline"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        favoriteId: json["favorite_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "animal_id": animalId,
        "name": name,
        "slug": slug,
        "description": description,
        "thumbnail": thumbnail,
        "sound": sound,
        "model": model,
        "offline": offline,
        "created_at": createdAt?.toIso8601String(),
        "favorite_id": favoriteId,
        "user_id": userId,
      };
}
