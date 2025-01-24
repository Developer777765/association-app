import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:temple_app/data/repository/login_repository.dart';

class TestScreen extends ConsumerStatefulWidget {
  String? nameOfScreen;
  TestScreen({required this.nameOfScreen});
  @override
  createState() => TestScreenState();
}

class TestScreenState extends ConsumerState<TestScreen> {
  GeoCode geoCode = GeoCode();
  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.nameOfScreen!),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Center(child: Text('')),
          ),
        ));
  }
}
