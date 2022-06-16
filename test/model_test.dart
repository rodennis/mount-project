import 'package:flutter_test/flutter_test.dart';
import 'package:mount_project/models/apiData.dart';

void main() {
  group('data', () {});

  test('albums response', () async {
    final data = AlbumsData();
    final result = await data.fetchData;

    expect(!result.isEmpty, true);
  });

  test('counter should increase by 1', () {
    final data = AlbumsData();
    final result = data.incrementFavorites();

    expect(data.counter == 1, true);
  });

}
