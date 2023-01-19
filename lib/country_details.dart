import 'dart:core';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountryDetails extends StatelessWidget {
  String name;
  String country;
      String countryCode;
      num newDeaths;
  num totalDeaths;
  num totalRecovered;
      String date;
  num totalConfirmed;
  CountryDetails({Key? key,required this.name,required this.country,required this.countryCode,required this.date,
    required this.totalRecovered,required this.newDeaths,required this.totalDeaths,required this.totalConfirmed
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ListTile(
                    leading: const Text('Date'),
                    trailing: Text(date),
                  ),
                ),),
                Card(
                  child: ListTile(
                    leading: const Text('Total Recovered'),
                    trailing: Text('$totalRecovered'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Text('Total Deaths'),
                    trailing: Text('$totalDeaths'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Text('New Deaths'),
                    trailing: Text('$newDeaths'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Text('Total Confirmed'),
                    trailing: Text('$totalConfirmed'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 460,
            child: Center(child: CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                radius: 70,
                child: Text(countryCode,style: const TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),)),
          ),
        ],
      ),
    );
  }
}
