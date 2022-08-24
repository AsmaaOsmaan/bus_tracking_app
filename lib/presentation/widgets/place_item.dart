import 'package:bus_tracking_app/data/models/place_suggestions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PlaceItem extends StatelessWidget {
  final PlaceSuggestion placeSuggestion;
  const PlaceItem({Key? key,required this.placeSuggestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subTitle=placeSuggestion.description.replaceAll(placeSuggestion.description.split(',')[0], '');
    print("sub:${subTitle}");
    return Container(
      width: double.infinity,
      padding:const  EdgeInsets.all(8),
      margin:const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: Colors.white,borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        leading: Container(width: 40,height: 40,

        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),
        child: Icon(Icons.place),

        ),
        title: RichText(text: TextSpan(
          children:[
            TextSpan(text: '${placeSuggestion.description.split(','[0])}\n',style:TextStyle(
              color: Colors.black,fontSize: 18,
              fontWeight: FontWeight.bold
            ) ),
            TextSpan(
              text: '${subTitle.substring(2)}',
              style: TextStyle(color: Colors.black,fontSize: 16)

            )
          ]
        ),),


      ),
    );
  }
}
