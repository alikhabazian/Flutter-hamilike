import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {

  final TabController controller;
  final NetworkImage prof_img;

  const CustomBottomBar({Key key, this.controller,this.prof_img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(icon:Icon(Icons.info_outlined),
          onPressed: () {
              controller.animateTo(0);
            },


      ),
          IconButton(icon:Icon(Icons.account_circle_outlined),onPressed: () {
            controller.animateTo(1);
          },),
          IconButton(icon:Icon(Icons.widgets_outlined),
            onPressed: () {
              controller.animateTo(2);
            },),
          IconButton(icon:CircleAvatar(backgroundImage: this.prof_img,

          ),
            onPressed: () {
              controller.animateTo(3);
            },
          ),

//          IconButton(
//            icon: SvgPicture.asset(
//                    'assets/icons/home_icon.svg',
//                    fit: BoxFit.fitWidth,
//                    ),
//            onPressed: () {
//              controller.animateTo(0);
//            },
//          ),
//          IconButton(
//            icon: Image.asset('assets/icons/category_icon.png'),
//            onPressed: () {
//              controller.animateTo(1);
//            },
//          ),
//          IconButton(
//            icon: SvgPicture.asset('assets/icons/cart_icon.svg'),
//            onPressed: () {
//              controller.animateTo(2);
//            },
//          ),
//          IconButton(
//            icon: Image.asset('assets/icons/profile_icon.png'),
//            onPressed: () {
//              controller.animateTo(3);
//            },
//          )
        ],
      ),
    );
  }
}
