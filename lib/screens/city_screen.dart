// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:clima/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0e1c26),
              Color(0xFF2a454b),
              Color(0xFF0e1c26),
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25.0,
                    color: Color.fromARGB(255, 51, 84, 90),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          autocorrect: true,
                          enableSuggestions: true,
                          cursorColor: Colors.white,
                          decoration: kinputDecorations,
                          onChanged: (value) {
                            cityName = value;
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, cityName);
                        },
                        child: const Text(
                          'Get Weather',
                          style: kButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
