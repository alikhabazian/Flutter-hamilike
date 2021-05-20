import 'dart:convert';

import 'package:repeat_mehrdadproject/app_properties.dart';
// import 'package:repeat_mehrdadproject/screens/auth/welcome_back_page.dart';

import 'package:flutter/material.dart';
import 'package:repeat_mehrdadproject/screens/main/main_page.dart';
import 'package:repeat_mehrdadproject/screens/auth/forgot_password_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> get_profiles ( String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/auth/profile';


  var response = await http.get(url,
    headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
//      body: body
  );
  print('hi');
  print(response.body);
  return json.decode(response.body);
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _token;
  var token;

  Animation<double> opacity;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    getData();
    controller = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  Future<Null> getData() async {
    final SharedPreferences prefs = await _prefs;
    token=prefs.getString('token') ?? 'null';

  }
  void navigationPage() async{
//    Navigator.of(context)
//        .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeBackPage()));
//     SharedPreferences.setMockInitialValues({});
    final SharedPreferences prefs = await _prefs;
    // final token=prefs.getString('token') ?? 'null';
    // print(token);
    if(token != 'null'){

      int ind=prefs.getInt('Default')??0;
      // var usernames=prefs.getStringList('infos')??[];
      var usernames1=await get_profiles(token);
      print('ss ${usernames1.keys}');
      var usernames=usernames1['data']["accounts"];
      print(usernames);
      var ss=null;
      if(usernames.isNotEmpty) {
         // ss= jsonDecode(usernames[ind])['data']["page"]["profile_pic_url"];
         ss= usernames[ind]['avatar'];
         prefs.setString('pkey',usernames[ind]['pkey'] );
      }
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MainPage(img_url:ss,indexx: ind,)));

    }else{
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => ForgotPasswordPage()));

    }
//    Navigator.of(context)
//        .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));



  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(color: blu_purple),
        child: SafeArea(
          child: new Scaffold(
            body: Center(
              child: Column(

                children: <Widget>[
                  Expanded(
                    child: Opacity(
                        opacity: opacity.value,
                        child: new Image.asset('assets/logo.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'Powered by '),
                            TextSpan(
                                text: 'int2.io',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
