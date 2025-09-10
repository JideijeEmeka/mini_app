import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

@JsonSerializable()
class Business {
  final String name;
  final String location;
  final String contactNumber;

  const Business({
    required this.name,
    required this.location,
    required this.contactNumber,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    // Normalize the messy keys from the API
    return Business(
      name: _validateString(json['biz_name'], 'Business name'),
      location: _validateString(json['bss_location'], 'Location'),
      contactNumber: _validateString(json['contct_no'], 'Contact number'),
    );
  }

  Map<String, dynamic> toJson() => _$BusinessToJson(this);

  static String _validateString(dynamic value, String fieldName) {
    if (value == null) {
      throw ArgumentError('$fieldName cannot be null');
    }
    if (value is! String) {
      throw ArgumentError('$fieldName must be a string');
    }
    if (value.trim().isEmpty) {
      throw ArgumentError('$fieldName cannot be empty');
    }
    return value.trim();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Business &&
        other.name == name &&
        other.location == location &&
        other.contactNumber == contactNumber;
  }

  @override
  int get hashCode => Object.hash(name, location, contactNumber);

  @override
  String toString() {
    return 'Business(name: $name, location: $location, contactNumber: $contactNumber)';
  }
}
