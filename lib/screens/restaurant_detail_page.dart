import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:HungryHippos/yelp_api/restaurant_detail.dart';
import 'package:HungryHippos/utilities/webview.dart';

class RestaurantDetailPage extends StatefulWidget {
  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  void _launchMapsUrl(String addy) async {
    final url = 'https://www.google.com/maps/search/${Uri.encodeFull(addy)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LinkedHashMap args = ModalRoute.of(context).settings.arguments;
    RestaurantDetail restaurantDetail = args['restaurantDetail'];
    String name = restaurantDetail.name;
    String imageUrl = restaurantDetail.imageUrl;
    double rating = restaurantDetail.rating;
    String phone = restaurantDetail.phone;
    String address = restaurantDetail.address;
    String url = restaurantDetail.url;
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: _screenSize.width * 0.08,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: _screenSize.height * 0.5,
              padding: EdgeInsets.only(top: 30),
              child: Image(
                image: NetworkImage(imageUrl),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tap on the address to open it up in Google Maps or tap on the phone to open it up in your dialer!",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: FlatButton(
                onPressed: () => _launchMapsUrl(address),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Address: " + address,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => launch("tel://" + phone),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Phone: " + phone,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: displayRating(rating),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebViewContainer(url)));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "See this restaurant on Yelp! ->",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[200],
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> displayRating(double rating) {
    List<Widget> displayRatingList = new List();

    displayRatingList.add(Container(
      padding: EdgeInsets.only(right: 8),
      child: Text(
        rating.toString(),
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ));

    for (int i = 0; i < rating.floor(); i++) {
      displayRatingList.add(Container(
        child: Icon(
          FontAwesomeIcons.solidStar,
          color: Colors.amber,
          size: 15.0,
        ),
      ));
    }

    if (rating.floor() != rating) {
      displayRatingList.add(Container(
        child: Icon(
          FontAwesomeIcons.solidStarHalf,
          color: Colors.amber,
          size: 15.0,
        ),
      ));
    }

    return displayRatingList;
  }
}