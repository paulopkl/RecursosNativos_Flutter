import 'package:flutter/material.dart';
import 'package:great_places/providers/GreatPlacesProvider.dart';
import 'package:great_places/routes/AppRoutes.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Meus Lugares!")),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PlaceForm);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlacesProvider>(
                child: Center(
                  child: Text("Nenhum local cadastrado!"),
                ),
                builder: (ctx, greatPlaces, child) => greatPlaces.itemsCount ==
                            0 ||
                        greatPlaces.itemsCount == null
                    ? child!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlaces.itemByIndex(index).image,
                            ),
                          ),
                          title: Text(greatPlaces.itemByIndex(index).title),
                          subtitle: Text(
                            greatPlaces.itemByIndex(index).location!.address!,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.PlaceDetail,
                              arguments: greatPlaces.itemByIndex(index),
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
