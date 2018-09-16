import 'package:flutter/material.dart';
import 'package:flutter_geolocation_test/modules/place_model.dart';
import 'package:flutter_geolocation_test/services/place_service.dart';

class PlaceDetailScreen extends StatefulWidget {
  Place _place;
  PlaceDetailScreen(this._place)
  @override
  State<StatefulWidget> createState() {
    return new PlaceDetailScreenState();
  }
}

class PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
        appBar: new AppBar(title: new Text('Detail')),
        body: new Center(
          child: new Text("Center"),
        ));
  }
bool _isLoading = true;
  @override void initState(){
    super.initState();
    PlacesService.get().getPlace(widget._place).then((data){
      this.setState((){
        widget._place = data;
        _isLoading = false;
      });
    });
  }
}
