import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:repeat_mehrdadproject/screens/auth/welcome_back_page.dart';
import 'package:repeat_mehrdadproject/screens/auth/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomBar extends StatefulWidget {
  final TabController controller;
  final NetworkImage prof_img;
  final String prof_img_url;

  const CustomBottomBar({Key key, this.controller,this.prof_img,this.prof_img_url}) : super(key: key);

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
        (click_prof)?Spacer(flex: 50,):null,
        (click_prof)?Container(
          height: MediaQuery.of(context).size.height/8,
          child:Container(
            margin: const EdgeInsets.only( right: 10.0),
            height: 160,
            width: MediaQuery.of(context).size.width/4,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
//                border: Border.all(color: Colors.deepPurple,width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),

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
                    maxLines: 1,



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
                    maxLines: 1,



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
                IconButton(icon:Icon(Icons.account_circle_outlined),onPressed: () {
                  widget.controller.animateTo(1);
                },
                  iconSize:40.0,
                ),
                IconButton(icon:Icon(Icons.widgets_outlined),
                  onPressed: () {
                    widget.controller.animateTo(2);
                  },
                  iconSize:40.0,
                ),

                IconButton(icon:CircleAvatar(backgroundImage: (widget.prof_img_url!=null)?NetworkImage(widget.prof_img_url):widget.prof_img,

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
