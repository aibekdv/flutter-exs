import 'package:clean_architecture/feature/domain/entities/person_entity.dart';

import 'location_model.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.origin,
    required super.location,
    required super.image,
    required super.episode,
    required super.url,
    required super.created,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"],
      gender: json["gender"],
      origin: json["origin"] != null ? LocationModel.fromJson(json) : null,
      location: json["location"]!= null ? LocationModel.fromJson(json) : null,
      image: json["image"],
      episode: json["episode"].cast<String>(),
      url: json["url"],
      created: json["created"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "species": species,
      "type": type,
      "gender": gender,
      "origin": origin,
      "location": location,
      "image": image,
      "episode": episode,
      "url": url,
      "created": created,
    };
  }
}
