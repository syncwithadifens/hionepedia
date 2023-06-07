// To parse this JSON data, do
//
//     final animalModel = animalModelFromJson(jsonString);

import 'dart:convert';

AnimalModel animalModelFromJson(String str) =>
    AnimalModel.fromJson(json.decode(str));

String animalModelToJson(AnimalModel data) => json.encode(data.toJson());

class AnimalModel {
  String? status;
  List<Animal>? animal;

  AnimalModel({
    this.status,
    this.animal,
  });

  factory AnimalModel.fromJson(Map<String, dynamic> json) => AnimalModel(
        status: json["status"],
        animal: json["animal"] == null
            ? []
            : List<Animal>.from(json["animal"]!.map((x) => Animal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "animal": animal == null
            ? []
            : List<dynamic>.from(animal!.map((x) => x.toJson())),
      };
}

class Animal {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? thumbnail;
  String? sound;
  String? model;
  DateTime? createdAt;

  Animal({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.thumbnail,
    this.sound,
    this.model,
    this.createdAt,
  });

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        sound: json["sound"],
        model: json["model"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "thumbnail": thumbnail,
        "sound": sound,
        "model": model,
        "created_at": createdAt?.toIso8601String(),
      };
}
