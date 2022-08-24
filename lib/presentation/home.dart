import 'package:animate_do/animate_do.dart';
import 'package:bus_tracking_app/business_logic/cubit/places/place_cubit.dart';
import 'package:bus_tracking_app/business_logic/cubit/places/places_state.dart';
import 'package:bus_tracking_app/data/models/place_suggestions.dart';
import 'package:bus_tracking_app/data/repo/map_repo.dart';
import 'package:bus_tracking_app/presentation/map_screen.dart';
import 'package:bus_tracking_app/presentation/widgets/custom_row.dart';
import 'package:bus_tracking_app/presentation/widgets/header.dart';
import 'package:bus_tracking_app/presentation/widgets/place_item.dart';
import 'package:bus_tracking_app/presentation/widgets/routs_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:uuid/uuid.dart';

import '../core/constants.dart';
import '../core/theme.dart';
import '../data/webservcies/placeswebservices.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FloatingSearchBarController controller = FloatingSearchBarController();

  List<dynamic> places = [];
  String country = '';
  PlaceSuggestion? placeSuggestion;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detectCurrentLocationfuture();
    setState(() {});
  }

  Future<void> detectCurrentLocationfuture() async {
    await BlocProvider.of<PlacesCubit>(context).detectCurrentLocationfuture();
    country = BlocProvider.of<PlacesCubit>(context).placemark!.locality!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_COLORE2,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FadeIn(
            duration: const Duration(seconds: 1),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * .22,
                        child: MenuHeader(
                          title: 'Your Trip Planner',
                          trailing: const SizedBox(),
                          mainHeader: true,
                        )),
                    Container(
                      color: Colors.white,
                      height: 150,
                      width: double.infinity,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                  child: const CustomRow(
                                      title: "Go TODay@3:10 pm",
                                      icon: Icons.timelapse),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                  child: Text("hfdfdjhh"),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 2)),
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 70),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            CustomRow(
                              title: " currentLocation:" + country,
                              icon: Icons.cloud_circle_outlined,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(
                                  Icons.cloud_circle_outlined,
                                  color: Colors.teal,
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                  endIndent: 1,
                                )),
                                Icon(Icons.cloud_circle_outlined),
                              ],
                            ),

                            const CustomRow(
                              title: "Destination",
                              icon: Icons.travel_explore,
                            ),
                            Container(
                                height: places.length == 0 ? 60 : 300,
                                child: buildFloatingSearchBar())
                            //  buildFloatingSearchBar()
                          ],
                        ),
                      ),
                      //  SizedBox(height: 5,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Saved Routs",
                                style: headLineStyle,
                              ),
                            ),
                            RoutsItem(),
                            RoutsItem(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget buildSuggestionsBloc() {
    return BlocBuilder<PlacesCubit, PlacesState>(builder: (context, state) {
      if (state is PlacesLoaded) {
        places = (state).places;
        if (places.length != 0) {
          return buildPlcesList();
        } else
          return Container();
      } else
        return Container();
    });
  }

  Widget buildPlcesList() {
    return Container(
      height: places == 0 ? 0 : 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () async {
              placeSuggestion = places[index];
              await BlocProvider.of<PlacesCubit>(context)
                  .detectCurrentLocationfuture();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: (BuildContext context1) =>
                            PlacesCubit(PlaceRepository(PlacesWebServices())),
                        child: MapScreen(
                          placeSuggestion: places[index],
                        ))),
              );
            },
            child: PlaceItem(placeSuggestion: places[index]),
          );
        },
        itemCount: places.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      height: 60,
      // color: Colors.red,
      child: FloatingSearchBar(
        controller: controller,
        elevation: 6,
        hintStyle: const TextStyle(fontSize: 18),
        queryStyle: const TextStyle(fontSize: 18),
        hint: 'find the place',
        border: const BorderSide(style: BorderStyle.none),
        padding: const EdgeInsets.fromLTRB(2, 2, 2, 10),
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (quary) {
          getPlacesSuggestions(quary);
        },
        closeOnBackdropTap: true,
        onFocusChanged: (_) {},
        transition: CircularFloatingSearchBarTransition(spacing: 16),
        actions: [],
        builder: (context, transiction) {
          return ClipRect(
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSuggestionsBloc(),
                  // Container(child: Text("fdddddddddd"),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void getPlacesSuggestions(String Quary) {
    String sessionToken = Uuid().v4();
    BlocProvider.of<PlacesCubit>(context)
        .emitPlaceSuggestions(Quary, sessionToken);
  }
}
