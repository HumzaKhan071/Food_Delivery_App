// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:food_delivery_final/data/data.dart';
import 'package:food_delivery_final/models/restaurant.dart';
import 'package:food_delivery_final/screens/cart_screen.dart';
import 'package:food_delivery_final/screens/restaurant_screen.dart';
import 'package:food_delivery_final/widgets/rating_stars.dart';
import 'package:food_delivery_final/widgets/recent_oders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildResturants() {
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RestaurantScreen(restaurant: restaurant))),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1.0, color: Colors.grey.shade200)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(
                    height: 150.0,
                    width: 150.0,
                    image: AssetImage(restaurant.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingStars(restaurant.rating),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      restaurant.address,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "0.2 miles away",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    });
    return Column(
      children: restaurantList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: Text("Food Delivery App"),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.account_circle),
          iconSize: 30,
        ),
        actions: [
          FlatButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen())),
              child: Text(
                "Cart (${currentUser.cart.length})",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      width: 0.8, color: Theme.of(context).primaryColor),
                ),
                hintText: "Search food or Resturants",
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Nearby Resturants",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2),
                ),
              ),
              _buildResturants(),
            ],
          )
        ],
      ),
    );
  }
}
