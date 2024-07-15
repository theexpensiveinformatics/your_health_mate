import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/colors.dart';

class YHMEmojiContainer extends StatelessWidget {
  const YHMEmojiContainer({super.key, required this.img});

  final String img;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: YHMColors.newDarkOrange.withOpacity(0.5),blurRadius: 20,spreadRadius: 2)
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child:
        Image.asset(img,height: 60,width: 60,)
        ,
      ),
    );
  }
}
