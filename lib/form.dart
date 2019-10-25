import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
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

  double price;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bathroomTextController = TextEditingController();
  final bedroomsTextController = TextEditingController();
  final sqftLivingTextController = TextEditingController();
  final conditionTextController = TextEditingController();
  final zipcodeTextController = TextEditingController();

  void submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    final Map<String, dynamic> data = {
      "bedrooms": int.parse(bedroomsTextController.text),
      "bathrooms": int.parse(bathroomTextController.text),
      "sqft_living": double.parse(sqftLivingTextController.text),
      "sqft_lot": sqft_lot,
      "floors": floors,
      "sqft_above": sqft_above,
      "sqft_lot15": sqft_lot15,
      "yr_built": yr_built,
      "condition": int.parse(conditionTextController.text),
      "zipcode": int.parse(zipcodeTextController.text)
    };
    var json_data = json.encode(data);
    print(json_data);

//https://house-price-prediction-ml.herokuapp.com
    http
        .post('https://house-price-prediction-ml.herokuapp.com/api/predict',
            headers: {'content-type': 'application/json'},
            body: json.encode(data))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
//                    print(json_data);
      setState(() {
        price = double.parse(responseData['predicted']);
        price = price.roundToDouble();
      });
//                    print(price);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Predicted house price'),
              content: Text(
                '\$$price',
                style: TextStyle(color: Colors.green),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: bedroomsTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number of bedrooms'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
                onSaved: (String value) {
                  setState(() {
                    bedrooms = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: bathroomTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number of bathrooms'),
                onSaved: (String value) {
                  setState(() {
                    bathrooms = int.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: sqftLivingTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sqft Living'),
                onSaved: (String value) {
                  setState(() {
                    sqft_living = double.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sqft Lot'),
                onSaved: (String value) {
                  setState(() {
                    sqft_lot = double.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number of floors'),
                onSaved: (String value) {
                  setState(() {
                    floors = int.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sqft above'),
                onSaved: (String value) {
                  setState(() {
                    sqft_above = double.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sqft Lot 15'),
                onSaved: (String value) {
                  setState(() {
                    sqft_lot15 = double.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Year built'),
                onSaved: (String value) {
                  setState(() {
                    yr_built = int.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: conditionTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Condition (1-5)'),
                onSaved: (String value) {
                  setState(() {
                    condition = int.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: zipcodeTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Zip Code'),
                onSaved: (String value) {
                  setState(() {
                    zipcode = int.parse(value);
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Predict'),
                onPressed: submitForm,
              )
            ],
          )),
    );
  }
}
