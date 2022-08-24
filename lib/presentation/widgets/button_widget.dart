import 'package:flutter/material.dart';

import '../../core/sized_config.dart';

class ButtonWidget extends StatelessWidget {
 final String text;
 final IconData icon;

 const ButtonWidget({Key? key,required this.text,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   SizeConfig().init(context);

   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Container(

      height:SizeConfig.defaultSize!*5 ,
      width:SizeConfig.defaultSize!*15 ,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey

       ),
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(
          children: [
           Icon(icon),
           SizedBox(width: 5,),
           Text(text),
          ],
         ),
       ),
      ),
   );
  }
}
