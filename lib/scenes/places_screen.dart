import 'package:flutter/material.dart';
import 'package:flutter_geolocation_test/modules/place_model.dart';
import 'package:flutter_geolocation_test/scenes/places_details_screen.dart';
import 'package:flutter_geolocation_test/services/place_service.dart';

class PlacesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PlacesScreenState();
  }
}

class PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Nearby Places")),
      body: _createContent(),
    );
  }

  Widget _createContent() {
    if (_places == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView(
        children: _places.map((f) {
          return new Card(
            child: new ListTile(
              title: new Text(f.name),
              leading: new Image.network(f.icon),
              subtitle: new Text(f.vicinity),
              trailing: new Column(children: <Widget>[
                new Icon(Icons.star_border),
                new Text(f.rating),
              ]),
              onTap: () {
                handleTap(f);
              },
            ),
          );
        }).toList(),
      );
    }
  }

  handleTap(Place place) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new PlaceDetailScreen(place)));
  }

  List<Place> _places;
  @override
  void initState() {
    super.initState();

    PlacesService.get().getNearbyPlaces().then((data) {
      this.setState(() {
        _places = data;
      });
    });
  }
}
