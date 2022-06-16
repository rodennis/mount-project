import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AlbumsData with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';
  int _counter = 0;

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  int get counter => _counter;

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
    } else if (response.statusCode == 404) {
      _error = true;
      _map = {};
      _errorMessage =
          'It looks like the page you are looking for doesnt exist.';
    } else if (response.statusCode == 500) {
      _error = true;
      _map = {};
      _errorMessage =
          'Sorry but it looks like the server encounterd an unexpected error. Please try reloading the page in a few minuts.';
    }
    notifyListeners();
    return _map;
  }

  void initialValues() {
    _map = {};
    _error = false;
    _errorMessage = '';
    _counter = 0;
    notifyListeners();
  }

  int incrementFavorites() {
    _counter = _counter + 1;
    notifyListeners();
    return _counter;
  }

  int decrementFavorites() {
    _counter = _counter - 1;
    notifyListeners();
    return _counter;
  }
}

// class FavoritesCounter with ChangeNotifier {
// }
