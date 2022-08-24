
import 'package:flutter/material.dart';
import '../../core/constants.dart';
class MenuHeader extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final bool? mainHeader;

  MenuHeader(
      {
        this.title,
        this.trailing,
        this.mainHeader,
        });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey
      ),
      child: Stack(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.arrow_back,
                      color: DARK_BLUE,
                      size: 25,
                    ),
                  ),
                ),
               const Spacer(),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              const  Spacer(),
                trailing!
              ],
            ),
          ),
        ],
      ),
    );
  }
}
