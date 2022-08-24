
import 'package:bus_tracking_app/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme.dart';
import 'custom_row.dart';
class RoutsItem extends StatelessWidget {
  const RoutsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: APP_COLORE2

      ),
child: Column(
  children: [
    Row(
      children: [
      const  Icon(Icons.do_disturb_sharp),
      const  SizedBox(width: 15,),
        Container(
          padding: EdgeInsets.all(8),
          //margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,

          ),
          child:const Text("1680-MR" ),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        CustomRow(title:"to home" ,icon:Icons.subdirectory_arrow_left_sharp,),

        Column(
          children:const [
           Text("26 KM"),
            Text("From You"),
          ],
        )
      ],
    ),

    CustomRow(title:"1680-MR" ,icon:Icons.do_disturb_sharp,),

  ],
),


    );
  }
}
