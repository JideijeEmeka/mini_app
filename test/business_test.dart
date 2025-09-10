import 'package:flutter_test/flutter_test.dart';
import 'package:mini_app/models/business.dart';

void main() {
  group('Business Model Tests', () {
    test('should create Business from valid JSON', () {
      final json = {
        'biz_name': 'Test Business',
        'bss_location': 'Test Location',
        'contct_no': '+1 555 123 4567',
      };

      final business = Business.fromJson(json);

      expect(business.name, 'Test Business');
      expect(business.location, 'Test Location');
      expect(business.contactNumber, '+1 555 123 4567');
    });

    test('should throw error for null business name', () {
      final json = {
        'biz_name': null,
        'bss_location': 'Test Location',
        'contct_no': '+1 555 123 4567',
      };

      expect(() => Business.fromJson(json), throwsA(isA<ArgumentError>()));
    });

    test('should throw error for empty business name', () {
      final json = {
        'biz_name': '',
        'bss_location': 'Test Location',
        'contct_no': '+1 555 123 4567',
      };

      expect(() => Business.fromJson(json), throwsA(isA<ArgumentError>()));
    });

    test('should trim whitespace from fields', () {
      final json = {
        'biz_name': '  Test Business  ',
        'bss_location': '  Test Location  ',
        'contct_no': '  +1 555 123 4567  ',
      };

      final business = Business.fromJson(json);

      expect(business.name, 'Test Business');
      expect(business.location, 'Test Location');
      expect(business.contactNumber, '+1 555 123 4567');
    });

    test('should support equality comparison', () {
      final business1 = Business(
        name: 'Test Business',
        location: 'Test Location',
        contactNumber: '+1 555 123 4567',
      );

      final business2 = Business(
        name: 'Test Business',
        location: 'Test Location',
        contactNumber: '+1 555 123 4567',
      );

      final business3 = Business(
        name: 'Different Business',
        location: 'Test Location',
        contactNumber: '+1 555 123 4567',
      );

      expect(business1, equals(business2));
      expect(business1, isNot(equals(business3)));
    });
  });
}
