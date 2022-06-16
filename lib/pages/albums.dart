import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:mount_project/models/apiData.dart';
import 'package:provider/provider.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AlbumsData>().fetchData;
    return Consumer<AlbumsData>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Ed Sheeran Albums'),
          leadingWidth: 100,
          leading: Text('Favorites = ${value.counter}')
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<AlbumsData>().initialValues();
            context.read<AlbumsData>().fetchData;
          },
          child: Center(
              child: value.map.isEmpty && !value.error
                  ? const CircularProgressIndicator()
                  : value.error
                      ? Text(
                          'something went wrong: ${value.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: (value.map['results'].length),
                          itemBuilder: (context, index) {
                            if (value.map['results'][index]['wrapperType'] == 
                            'collection') {
                              return Album(map: value.map['results'][index], value: value);
                            } else {
                              return const SizedBox.shrink();
                            }
                          }
                        )
          ),
        ),
      );
    });
  }
}

class Album extends StatelessWidget {
  const Album({Key? key, required this.map, this.value}) : super(key: key);
  final Map<String, dynamic> map;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // if (map['wrapperType'] == 'collection') ...[
                    Text(
                      map['collectionName'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Image.network(map['artworkUrl100'], fit: BoxFit.fill),
                    Text( 
                      '\$${map['collectionPrice'].toString()}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      map['releaseDate'].substring(0, 10),
                      textAlign: TextAlign.center,
                    ),
                    FavoriteButton(
                      isFavorite: false,
                      valueChanged: (isFavourite) {
                        if (isFavourite == false) {
                          value.decrementFavorites();
                        } else {
                          value.incrementFavorites();
                        }
                      },
                    ),
                  // ]
                ],
          )
        ),
      ),
    );
  }
}
