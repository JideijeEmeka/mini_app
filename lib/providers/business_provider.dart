import 'package:flutter/foundation.dart';
import '../models/business.dart';
import '../services/business_service.dart';

enum BusinessState { initial, loading, loaded, error, empty }

class BusinessProvider with ChangeNotifier {
  final BusinessService _businessService = BusinessService();

  BusinessState _state = BusinessState.initial;
  List<Business> _businesses = [];
  String? _errorMessage;

  BusinessState get state => _state;
  List<Business> get businesses => _businesses;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == BusinessState.loading;
  bool get hasError => _state == BusinessState.error;
  bool get isEmpty => _state == BusinessState.empty;
  bool get isLoaded => _state == BusinessState.loaded;

  /// Load businesses from service
  Future<void> loadBusinesses() async {
    if (_state == BusinessState.loading) return;

    _setState(BusinessState.loading);

    try {
      final businesses = await _businessService.fetchBusinesses();

      if (businesses.isEmpty) {
        _setState(BusinessState.empty);
      } else {
        _businesses = businesses;
        _setState(BusinessState.loaded);
      }
    } catch (e) {
      _errorMessage = e.toString();
      _setState(BusinessState.error);
    }
  }

  /// Load businesses from cache only (offline mode)
  Future<void> loadCachedBusinesses() async {
    if (_state == BusinessState.loading) return;

    _setState(BusinessState.loading);

    try {
      final businesses = await _businessService.getCachedBusinesses();

      if (businesses.isEmpty) {
        _setState(BusinessState.empty);
      } else {
        _businesses = businesses;
        _setState(BusinessState.loaded);
      }
    } catch (e) {
      _errorMessage = e.toString();
      _setState(BusinessState.error);
    }
  }

  /// Retry loading businesses
  Future<void> retry() async {
    await loadBusinesses();
  }

  /// Clear cache and reload
  Future<void> refresh() async {
    await _businessService.clearCache();
    await loadBusinesses();
  }

  void _setState(BusinessState newState) {
    _state = newState;
    notifyListeners();
  }
}
