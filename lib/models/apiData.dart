import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AlbumsData with ChangeNotifier {
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
    return _map;
  }

  void initialValues() {
    _map = {};
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }

  int _counter = 0;

  int incrementFavorites() {
    _counter = _counter + 1;
    notifyListeners();
    return _counter;
  }

  int get counter => _counter;
}

// class FavoritesCounter with ChangeNotifier {
// }
