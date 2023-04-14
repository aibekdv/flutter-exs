import 'package:clean_architecture/feature/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({required super.name, required super.url});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(name: json["name"], url: json["url"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
    };
  }
}
