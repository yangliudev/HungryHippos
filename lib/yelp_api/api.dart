import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:geolocator/geolocator.dart';
import 'package:HungryHippos/yelp_api/geolocation.dart';
import "package:HungryHippos/screens/limits.dart";

import 'package:http/http.dart' as http;

import 'package:HungryHippos/yelp_api/restaurant_detail.dart';

class SearchAPI {

  static Future<List<RestaurantDetail>> getRestaurantDetail(String lat, String lon, String category) async {
    List<RestaurantDetail> restaurantDetails = new List();
    String limit = Limits.getSelectedLimit().toString();

    var response = await http.get(
        "https://api.yelp.com/v3/businesses/search?term=restaurants&limit=" + limit + "&latitude=" + lat + "&longitude=" + lon + "&categories=" + category,
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ZHHxgEsOXwdpGTJPchdABSGCGNo-SVqIGGKl19muVklrWrzOOKnJNJPyUVy7AHoY0aOmCOAUtDtskC8dEegIWs-ae5ZIKeS75iydo4vhgtBQfTF_XQTdNHCl7b6HXnYx"
        }
    );
    
    LinkedHashMap data = json.decode(response.body);

    List restaurants = data["businesses"];

    for (int i = 0; i < restaurants.length; i++) {
      var restaurant = restaurants[i];
      RestaurantDetail restaurantDetail = new RestaurantDetail(restaurant['name'], restaurant['image_url'],
      restaurant['phone'], restaurant['rating'], restaurant['location']['city'], restaurant['location']['display_address'][0] + " " + restaurant['location']['display_address'][1], restaurant['url']);
      restaurantDetails.add(restaurantDetail);
    }
    
    return restaurantDetails;
  }

  static Future<GeoLocation> getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double latitude = position.latitude;
    double longitude = position.longitude;
    GeoLocation geoLocation = new GeoLocation(latitude, longitude);

    print(position);
    return geoLocation;
  }

  static Future<List<RestaurantDetail>> getNearbyRestaurants(String category) async {
    GeoLocation geoLocation = await getCurrentLocation();
    String lat = geoLocation.latitude.toString();
    String lon = geoLocation.longitude.toString();
    List<RestaurantDetail> restaurantDetails = await getRestaurantDetail(lat, lon, category);
    return restaurantDetails;
  }
  
}