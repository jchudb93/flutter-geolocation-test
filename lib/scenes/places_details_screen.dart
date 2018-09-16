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
        appBar: new AppBar(title: new Text(widget._place.name)),
        body: new Center(
          child: _createContent(),
        ));
  }

  Widget _createContent(){
    if (_isLoading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Text(widget._place.name, style: new TextStyle(
              color: Colors.green
            ),),
          ),

          new Divider(color: Colors.green),

          getCard("Address", widget._place.formatted_address, Icons.location_on),
          getCard("Working hours", widget._place.weekday_text.join("\n"), Icons.work)
        ],
      )
    }
  }
  Widget getCard(String header, String data, IconData iconData){

    return new Card(
      color: Colors.white,
      child: new Padding(
        padding: const EdgeInsets.all(10.0),child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(header, style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:  18.0
                )),new Icon(iconData, color: Colors.green)
              
              ],
            ),

            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top:10.0),
              child: new Text(data, textAlign:  TextAlign.start,)
            )
          ],
        )
      ),)
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
