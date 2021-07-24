import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;

const GOOGLE_API_KEY = "AIzaSyDuFPkMHY4-bHoBQWJ1iSRnXMy1U3FpeW8";

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) =>
      "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap,-74.015794&markers=color:green%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY";

  static Future<String> getAddressFrom(LatLng position) async {
    final Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY");
    final response = await http.get(url);

    return json.decode(response.body)["results"][0]["formatted_address"];
  }
}
