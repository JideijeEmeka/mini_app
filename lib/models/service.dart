import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  final String name;
  final String description;
  final double price;
  final String category;

  const Service({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Service &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.category == category;
  }

  @override
  int get hashCode => Object.hash(name, description, price, category);

  @override
  String toString() {
    return 'Service(name: $name, description: $description, price: $price, category: $category)';
  }
}
