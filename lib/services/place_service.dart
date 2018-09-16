import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_geolocation_test/modules/place_model.dart';

class PlacesService {
  static final _service = new PlacesService();

  static PlacesService get() {
    return _service;
  }

  final String searchUrl = '';

  Future<List<Place>> getNearbyPlaces() async {
    var response =
        await http.get(searchUrl, headers: {"Accept": "application/json"});
    var places = <Place>[];

    List data = json.decode(response.body)['results'];

    data.forEach((f) => places.add(new Place(f['icon'], f['name'],
        f['rating'].toString(), f['vicinity'], f['place_id'])));

    return places;
  }

  final String detailUrl = "";

  Future getPlace(Place place) async {
    var response = await http
        .get(detailUrl + place.id, headers: {"Accept": "application/json"});

    var result = json.decode(response.body)["resut"];

    List<String> weekdays = [];

    if (result["opening_hours"] != null) {
      weekdays = result["opening_hours"]["weekday_text"];
    }
    place.weekday_text = weekdays;
    place.formatted_address = result["formatted_address"];
    place.international_phone_number = result["international_phone_number"];
    return place;
  }
}
