import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/business.dart';

class BusinessService {
  static const String _cacheKey = 'businesses_cache';
  static const String _lastFetchKey = 'businesses_last_fetch';
  static const Duration _cacheExpiry = Duration(hours: 24);

  final Dio _dio = Dio();

  /// Fetch businesses from local JSON asset
  Future<List<Business>> fetchBusinesses() async {
    try {
      // Load from local asset
      final String jsonString = await rootBundle.loadString(
        'assets/data/businesses.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      final businesses = jsonList
          .map((json) => Business.fromJson(json as Map<String, dynamic>))
          .toList();

      // Cache the results
      await _cacheBusinesses(businesses);

      return businesses;
    } catch (e) {
      // If loading from asset fails, try to load from cache
      final cachedBusinesses = await _getCachedBusinesses();
      if (cachedBusinesses.isNotEmpty) {
        return cachedBusinesses;
      }
      rethrow;
    }
  }

  /// Cache businesses to local storage
  Future<void> _cacheBusinesses(List<Business> businesses) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(
        businesses.map((b) => b.toJson()).toList(),
      );
      await prefs.setString(_cacheKey, jsonString);
      await prefs.setInt(_lastFetchKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Silently fail caching - not critical for app functionality
      print('Failed to cache businesses: $e');
    }
  }

  /// Get cached businesses if they exist and are not expired
  Future<List<Business>> _getCachedBusinesses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);
      final lastFetch = prefs.getInt(_lastFetchKey);

      if (cachedJson == null || lastFetch == null) {
        return [];
      }

      // Check if cache is expired
      final lastFetchTime = DateTime.fromMillisecondsSinceEpoch(lastFetch);
      if (DateTime.now().difference(lastFetchTime) > _cacheExpiry) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(cachedJson);
      return jsonList
          .map((json) => Business.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Get businesses from cache only (for offline mode)
  Future<List<Business>> getCachedBusinesses() async {
    return await _getCachedBusinesses();
  }

  /// Clear cache
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_lastFetchKey);
    } catch (e) {
      print('Failed to clear cache: $e');
    }
  }
}
