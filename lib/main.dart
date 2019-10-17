import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int bedrooms;
  int bathrooms;
  double sqft_living;
  double sqft_lot;
  int floors;
  double sqft_above;
  double sqft_lot15;
  int yr_built;
  int condition;
  int zipcode;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Predict House Prices'),
          ),

        ),
        body: Container(

          margin: EdgeInsets.all(20),
          child: ListView(
          children: <Widget>[
            TextField(

              decoration: InputDecoration(hintText: 'Number of bedrooms', ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  bedrooms = int.parse(value);

                });
                print(bedrooms);
              },
            ),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Number of bathrooms'),
              onChanged: (String value) {
                setState(() {
                  bathrooms = int.parse(value);
                });
                print(bathrooms);
              },
            ),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Sqft Living'),
              onChanged: (String value) {
                setState(() {
                  sqft_living = double.parse(value);
                });
                print(sqft_living);
              },
            ),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Sqft Lot'),
              onChanged: (String value) {
                setState(() {
                  sqft_lot = double.parse(value);
                });
                print(sqft_lot);
              },
            ),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Number of floors'),
              onChanged: (String value) {
                setState(() {
                  floors = int.parse(value);
                });
                print(floors);
              },
            ),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Sqft above'),
              onChanged: (String value) {
                setState(() {
                  sqft_above = double.parse(value);
                });
                print(sqft_above);
              },
            ),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Sqft Lot 15'),
              onChanged: (String value) {
                setState(() {
                  sqft_lot15 = double.parse(value);
                });
                print(sqft_lot15);
              },
            ),


            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Year Built'),
              onChanged: (String value) {
                setState(() {
                  yr_built = int.parse(value);
                });
                print(yr_built);
              },
            ),

            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Condition (1-5)'),
              onChanged: (String value) {
                setState(() {
                  condition = int.parse(value);
                });
                print(condition);
              },
            ),

            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'ZipCode'),
              onChanged: (String value) {
                setState(() {
                  zipcode = int.parse(value);
                });
                print(zipcode);
              },
            ),
            RaisedButton(
              onPressed: () {
                final Map<String, dynamic> data = {
                  "bedrooms" : bedrooms,
                  "bathrooms" : bathrooms,
                  "sqft_living" : sqft_living,
                  "sqft_lot" : sqft_lot,
                  "floors" : floors,
                  "sqft_above" : sqft_above,
                  "sqft_lot15" : sqft_lot15,
                  "yr_built" : yr_built,
                  "condition" : condition,
                  "zipcode" : zipcode
                };

                var json_data = json.encode(data);
//                var client = Uri.http('localhost:36174', 'api/predict');
                http.post('http://10.0.2.2:36174/api/predict',
                    headers: {'content-type' : 'application/json'},
                    body: json.encode(data))
                .then((http.Response response) {
                    final Map<String, dynamic> responseData = json.decode(response.body);
//                    print(json_data);
                    print(responseData);
                });

//              http.get('http://127.0.0.1:36174/pred').then((http.Response response) {
//                print(responseyes.statusCode);
//              });
//                print(data);
              },
              child: Text('Predict'),
            )
          ],
        ),
      ),
      ),
    );
  }
}
