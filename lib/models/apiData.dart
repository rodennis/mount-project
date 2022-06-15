import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AlbumsData with ChangeNotifier {
  static final AlbumsData instance = AlbumsData._();
  AlbumsData._();

  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<dynamic> get fetchData async {
    final response = await get(
        Uri.parse('https://itunes.apple.com/lookup?id=183313439&entity=album'));

    if (response.statusCode == 200) {
      try {
        _error = false;
        _map = jsonDecode(response.body);
        return _map;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = {};
      }
    } else {
      _error = true;
      _map = {};
      // test status codes here//
    }
    notifyListeners();
  }

  void initialValues() {
    _map = {};
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
