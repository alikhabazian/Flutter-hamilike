
import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:flutter/material.dart';

//import 'package:ecommerce_int2/screens/wallet/int';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> two_steps ( String username,String password,String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/account/account_two_step';
  var body = jsonEncode({
    "username": username,
    "password": password,
    "api_type": "app",
    "pkey": ""
  });

  //print("Body: " + body);

  var response = await http.post(Uri.parse(url),
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
      body: body
  );
  print(response.body);
  return json.decode(response.body);
}

Future<Map<String, dynamic>> login_web ( String username,String password,String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/account/account_login';
  var body = jsonEncode({
    "username": username,
    "password": password,
    "api_type": "web",
    "pkey": ""
  });

  //print("Body: " + body);

  var response = await http.post(Uri.parse(url),
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
      body: body
  );
  print(response.body);
  return json.decode(response.body);
}





//Two_step

class Two_step extends StatefulWidget {
  @override
  _Two_step createState() => _Two_step();
}

class _Two_step extends State<Two_step> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController instagram =
  TextEditingController(text: 'Instagram username');

  TextEditingController password = TextEditingController(text: '');
  String text_error;
  var op_error;
//  TextEditingController cmfPassword = TextEditingController(text: '12345678');


  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Glad To Meet You',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget registerButton = Positioned(
      left: (MediaQuery.of(context).size.width / 4)-28,
      bottom: 40,
      child: InkWell(
        onTap: () async{
          final SharedPreferences prefs = await _prefs;
          String token=prefs.getString('token');
          print(token);
          var c1=await two_steps(instagram.text,password.text,token);
          var c2=await two_steps(instagram.text,password.text,token);
          if(c1["status"]==200 && c2["status"]==200 ){
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (_) => ()));


          }else if(c1["status"]==202 || c2["status"]==202){//instagram-2step




          }else{
            var s;
            if(c1["status"]!=200){
              s=c1["status_message"];
            }else{
              s=c2["status_message"];
            }
            text_error=s;
            op_error=1;
            setState(() {

            });


          }


//          Navigator.of(context)
//              .push(MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Register",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: mainButton,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget registerForm = Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
//                    controller: instagram,
                   "2 step cod:",
                    style: TextStyle(fontSize: 16.0,color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: password,
                    style: TextStyle(fontSize: 16.0),
//                    obscureText: true,
                  ),
                ),

              ],
            ),
          ),
          new Opacity(opacity: op_error?? 0, child: new Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Text(text_error ?? 'hide',style: TextStyle(
                color: Colors.red
            ),),
          )),

          registerButton,
        ],
      ),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        Text(
          'You can sign in with',
          style: TextStyle(
              fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.find_replace),
              onPressed: () {},
              color: Colors.white,
            ),
            IconButton(
                icon: Icon(Icons.find_replace),
                onPressed: () {},
                color: Colors.white),
          ],
        )
      ],
    );

    return Scaffold(

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: transparentYellow,

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(flex:3),
                title,
                Spacer(),

                subTitle,
                Spacer(flex:2),

                registerForm,
                Spacer(flex:2),
                Padding(
                    padding: EdgeInsets.only(bottom: 20), child: socialRegister)
              ],
            ),
          ),

          Positioned(
            top: 35,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
