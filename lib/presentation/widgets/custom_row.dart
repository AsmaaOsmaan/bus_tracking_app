import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final IconData? icon;
  final String? title;


  const CustomRow({Key? key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(icon!),
        SizedBox(width: 5,),
        Text(title!, overflow: TextOverflow.ellipsis,maxLines: 2,  softWrap: false,
            ),

      ],
    )  ;
  }
}
