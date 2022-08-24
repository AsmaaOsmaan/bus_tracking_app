import 'package:bus_tracking_app/core/sized_config.dart';
import 'package:bus_tracking_app/data/models/place_dirictions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';
import 'button_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  final PlaceDirections? placeDirections;
  var dt = DateTime.now();
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String time = DateFormat("hh:mm: a").format(DateTime.now());
  String data2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
//String data3=

  BottomSheetWidget({Key? key, this.placeDirections}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime today =  DateTime.now();
    //
    // var fiftyDaysFromNow = today.add(new Duration(minutes: int.parse(placeDirections!.totalDuration)));
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, right: 5, left: 5),
      child: Container(
        height: SizeConfig.defaultSize! * 30,
        width: SizeConfig.defaultSize! * 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      "Distance",
                      style: headLineStyle,
                    ),
                    Text(
                      placeDirections!.totalDistance,
                      style: textStyle,
                    ),
                    Text(
                      'trip taken on  ${date}',
                      style: textStyle2,
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    Text("Travel Time:${placeDirections!.totalDuration}"),
                    Row(
                      children: [
                        Row(
                          children: [Icon(Icons.watch_later), Text(time)],
                        ),
                        Row(
                          children: [Icon(Icons.watch_later), Text(time)],
                        ),
                      ],
                    )
                    // Text(placeDirections!.totalDuration),
                  ],
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From..",
                          style: headLineStyle,
                        ),
                        Text(data2),
                      ],
                    ),
                  ),
                  Expanded(child:  ButtonWidget(
                      text: 'Set Reminder',
                      icon: Icons.remove_from_queue_outlined))
                 ,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From..",
                          style: headLineStyle,
                        ),
                        Text(data2),
                      ],
                    ),
                  ),
                Expanded(child:   ButtonWidget(
                    text: 'Pay Online',
                    icon: Icons.remove_from_queue_outlined),)
                ],
              ),
            )
            // Text(placeDirections!.totalDistance),
            //  Text(placeDirections!.totalDuration),
          ],
        ),
      ),
    );
  }
}
