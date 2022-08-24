import 'package:bus_tracking_app/business_logic/cubit/places/place_cubit.dart';
import 'package:bus_tracking_app/data/repo/map_repo.dart';
import 'package:bus_tracking_app/data/webservcies/placeswebservices.dart';
import 'package:bus_tracking_app/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(

create: (BuildContext context)=>PlacesCubit(PlaceRepository(PlacesWebServices())),
          child: const Home()),
    );
  }
}


