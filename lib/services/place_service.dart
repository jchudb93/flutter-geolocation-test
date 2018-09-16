import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_geolocation_test/modules/place_model.dart';class PlaceService{

  static final _service = new PlaceService();

  static PlaceService get() {

    return _service;
  }

  final String searchUrl ='';

  Future<List<Place>> getNearbyPlace() async {
    var response = await http.get(searchUrl, headers:{"Accept":"application/json"});
    var places = <Place>[];

    List data = json.decode(response.body)['results'];

    data.forEach((f) => places.add(new Place(f['icon'], f['name'], f['rating'].toString(), f['vicinity'], f['place_id'])));

    return places;
  }

}