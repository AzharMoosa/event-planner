import 'package:flutter/material.dart';
import 'package:going_out_planner/models/places_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceInfoScreenWidget extends StatefulWidget {
  final PlaceModel place;

  const PlaceInfoScreenWidget({Key? key, required this.place})
      : super(key: key);

  @override
  _PlaceInfoScreenState createState() => _PlaceInfoScreenState(place);
}

class _PlaceInfoScreenState extends State<PlaceInfoScreenWidget> {
  PlaceModel placeInfo;
  _PlaceInfoScreenState(this.placeInfo);

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        title: Text(placeInfo.name,
            style: TextStyle(
                color: Color(0xffeeeeee),
                fontSize: 21,
                fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    '${widget.place.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Location',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.place.location.address}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.place.location.postalCode}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.place.location.city}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${widget.place.location.country}',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Rating',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        for (var i = 0; i < widget.place.rating ~/ 1; i++)
                          Icon(Icons.star),
                        for (var i = widget.place.rating ~/ 1; i < 5; i++)
                          Icon(Icons.star_outline),
                        Text(
                          ' ${widget.place.rating} / 5.0',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'More Info',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 20),
                    child: InkWell(
                        onTap: () {
                          _launchURL(widget.place.info);
                        },
                        child: Text(
                          '${widget.place.info}',
                          style: TextStyle(fontSize: 18),
                        )))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
