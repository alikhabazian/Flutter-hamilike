import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:repeat_mehrdadproject/screens/auth/welcome_back_page.dart';
import 'package:repeat_mehrdadproject/screens/auth/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repeat_mehrdadproject/screens/main/main_page.dart';

import 'package:cached_network_image/cached_network_image.dart';


class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  TooltipShapeBorder({
    this.radius = 16.0,
    this.arrowWidth = 20.0,
    this.arrowHeight = 10.0,
    this.arrowArc = 0.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx +0.5*x , rect.bottomCenter.dy)
      ..relativeLineTo(-x / 2 * r, y * r)
      ..relativeQuadraticBezierTo(-x / 2 * (1 - r), y * (1 - r), -x * (1 - r), 0)
      ..relativeLineTo(-x / 2 * r, -y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}


class CustomBottomBar extends StatefulWidget {
  final TabController controller;
  final NetworkImage prof_img;
  final String prof_img_url;
  final Function callback;

  const CustomBottomBar({Key key, this.callback,this.controller,this.prof_img,this.prof_img_url}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  bool notNull(Object o) => o != null;
  var click_prof=false;
  @override
  Widget build(BuildContext context) {

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return Column(


      crossAxisAlignment :CrossAxisAlignment.end,
      mainAxisAlignment :MainAxisAlignment.end,




      children: [
        (click_prof)?Spacer(flex: 100,):null,
        (click_prof)?Container(


          height: MediaQuery.of(context).size.height/8,
          child:Container(
            margin: const EdgeInsets.only( right: 10.0),
            height: 160,
            width: MediaQuery.of(context).size.width/3.5,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),

            decoration: ShapeDecoration(
              color: Colors.grey[200],
              shape: TooltipShapeBorder(arrowArc: 0.5),
              shadows: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 4.0, offset: Offset(2, 2))
              ],
            ),

            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    click_prof=false;
                    setState(() {

                    });


                    widget.controller.animateTo(3);
//                    Navigator.of(context)
//                        .push(MaterialPageRoute(builder: (_) => WelcomeBackPage(usernames: usrnames,)));
                  },
                  child: AutoSizeText('Account list',
                    textAlign: TextAlign.center,
                    // maxLines: 1,



                    style: TextStyle(


                        color: Colors.black,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          )
                        ]),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: (){
                    click_prof=false;
                    setState(() {

                    });
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) =>RegisterPage()));
                  },
                  child: AutoSizeText('Add account',
                    textAlign: TextAlign.center,
                    // maxLines: 1,



                    style: TextStyle(


                        color: Colors.black,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),



        ):null,
        (click_prof)?Spacer(flex: 1,):null,
        Container(




          color: Colors.grey[200],












          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(

                  icon:Icon(Icons.info_outlined),
                  onPressed: () {

                    widget.controller.animateTo(0);

                  },
                  iconSize:40.0,


                ),
                // IconButton(icon:Icon(Icons.account_circle_outlined),onPressed: () {
                //   print('hi');
                //   widget.callback();
                //   widget.controller.animateTo(1);
                // },
                //   iconSize:40.0,
                // ),
                IconButton(icon:Icon(Icons.widgets_outlined),
                  onPressed: () {
                    print('hi');
                    widget.callback();

                    widget.controller.animateTo(2);

                  },
                  iconSize:40.0,
                ),

                IconButton(icon:CircleAvatar(child: (widget.prof_img_url!=null)?CachedNetworkImage(imageUrl:widget.prof_img_url,placeholder: (context, url) => CircularProgressIndicator(),imageBuilder: (context, imageProvider) => CircleAvatar(
    radius: 50,
    backgroundImage: imageProvider,
    ),errorWidget: (context, url, error) => Icon(Icons.error)):widget.prof_img,

                ),
                  onPressed: () {

//                controller.animateTo(3);

                    setState(() {
                      click_prof= !(click_prof);

                    });

                  },
                  iconSize:40.0,
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
          ),
        ),
      ].where(notNull).toList(),
    );
  }
}
