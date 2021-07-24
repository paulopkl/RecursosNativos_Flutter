import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/PlaceLocation.dart';
import 'package:great_places/utils/DB_util.dart';
import 'package:great_places/utils/LocationUtil.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);

    DBUtil.insert("places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "latitude": position.latitude,
      "longitude": position.longitude,
      "address": address,
    });

    notifyListeners();
  }

  Future<void> loadPlaces() async {
    final dataList = await DBUtil.getPlaces("places");

    _items = dataList
        .map(
          (place) => Place(
            id: place["id"] as String,
            title: place["title"] as String,
            image: File(place["image"] as String),
            location: PlaceLocation(
              latitude: place["latitude"] as double,
              longitude: place["longitude"] as double,
              address: place["address"] as String,
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}
