import 'package:flutter/material.dart';
import 'package:mount_project/models/apiData.dart';
import 'package:provider/provider.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AlbumsData>().fetchData;
    return Center(
      child: Scaffold(
        appBar: AppBar(title: const Text('Ed Sheeran Albums')),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: Center(
            child: Consumer<AlbumsData>(builder: (context, value, child) {
              return value.map.isEmpty && !value.error
                  ? const CircularProgressIndicator()
                  : value.error
                      ? Text('something went wrong: ${value.errorMessage}')
                      : ListView.builder(itemBuilder: (context, index) {
                          return const Text('hi');
                        });
            }),
          ),
        ),
      ),
    );
  }
}
