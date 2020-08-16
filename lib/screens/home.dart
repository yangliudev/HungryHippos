import 'package:flutter/material.dart';

import 'package:HungryHippos/yelp_api/restaurant_detail.dart';
import 'package:HungryHippos/yelp_api/api.dart';
import "package:HungryHippos/screens/limit.dart";
import "package:HungryHippos/screens/limits.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var restaurantCategories = [
    "Chinese",
    "Korean",
    "Japanese",
    "Vietnamese",
    "Thai",
    "Mexican",
    "Italian",
    "French",
    "Spanish",
    "Greek",
    "Mediterranean",
    "Burgers",
  ];

  Limit _selectedLimit;

  @override
  void initState() {
    _selectedLimit = Limits.getSelectedLimit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.black87,
          child: ListView(children: createRestaurantCategories()),
        ),
      ),
    );
  }

  List<Widget> createRestaurantCategories() {
    List<Widget> restaurantCategoryList = new List();

    restaurantCategoryList.add(
      IconButton(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 24),
          icon: Icon(Icons.settings),
          iconSize: 30.0,
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          }),
    );

    restaurantCategoryList.add(
      Container(
        width: 400,
        height: 100,
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.only(top: 24),
        child: Text(
          'What do you want to eat today?',
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    for (int i = 0; i < restaurantCategories.length; i++) {
      String category = restaurantCategories[i];
      String categoryLowerCase = category.toLowerCase();

      restaurantCategoryList.add(
        InkWell(
          onTap: () {
            List<RestaurantDetail> restaurantDetails;
            SearchAPI.getNearbyRestaurants(categoryLowerCase)
                .then((value) => restaurantDetails = value)
                .whenComplete(() => Navigator.pushNamed(context, '/restaurants',
                    arguments: {'restaurantDetails': restaurantDetails}));
          },
          child: Container(
            height: 200.0,
            width: 300.0,
            alignment: Alignment(1.0, 1.0),
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.only(top: 24),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/' + categoryLowerCase + '.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );
    }
    return restaurantCategoryList;
  }
}
