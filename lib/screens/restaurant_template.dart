import 'dart:collection';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'package:HungryHippos/yelp_api/restaurant_detail.dart';

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.black87,
          child: ListView(
            children: restaurantsContainer(),
          ),
        ),
      ),
    );
  }

  List<Widget> restaurantsContainer() {
    List<Widget> restaurantContainerList = new List();

    LinkedHashMap args = ModalRoute.of(context).settings.arguments;
    List<RestaurantDetail> restaurantDetails = args['restaurantDetails'];

    for (int i = 0; i < restaurantDetails.length; i++) {
      RestaurantDetail restaurantDetail = restaurantDetails[i];
      String name = restaurantDetail.name;
      String imageUrl = restaurantDetail.imageUrl;
      String city = restaurantDetail.city;
      double rating = restaurantDetail.rating;
      restaurantContainerList.add(
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: new FittedBox(
              child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/details',
                        arguments: {'restaurantDetail': restaurantDetail});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: displayRating(rating))),
                              ),
                              Container(
                                  child: Text(
                                city,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15.0,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 140,
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(24.0),
                          child: Image(
                            fit: BoxFit.contain,
                            alignment: Alignment.topRight,
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return restaurantContainerList;
  }

  List<Widget> displayRating(double rating) {
    List<Widget> displayRatingList = new List();

    displayRatingList.add(Container(
      padding: EdgeInsets.only(right: 8),
      child: Text(
        rating.toString(),
        style: TextStyle(
          color: Colors.black54,
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
