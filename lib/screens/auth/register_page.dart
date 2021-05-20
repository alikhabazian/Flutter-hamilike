
import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:flutter/material.dart';


import 'forgot_password_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repeat_mehrdadproject/screens/auth/two_step_login.dart';

//import 'package:ecommerce_int2/screens/intro_page.dart';
import 'package:repeat_mehrdadproject/screens/main/main_page.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';

bool notNull(Object o) => o != null;



Future<Map<String, dynamic>> login_app ( String username,String password,String pkey,String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/account/account_login';
  var body = jsonEncode({
    "username": username,
    "password": password,
    "api_type": "app",
    "pkey": pkey
  });

  //print("Body: " + body);

  var response = await http.post(url,
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
      body: body
  );
  print(response.body);
  return json.decode(response.body);
}

Future<Map<String, dynamic>> login_web ( String username,String password,String pkey,String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/account/account_login';
  var body = jsonEncode({
    "username": username,
    "password": password,
    "api_type": "web",
    "pkey": pkey
  });

  //print("Body: " + body);

  var response = await http.post(url,
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
      body: body
  );
  print(response.body);
  return json.decode(response.body);
}







class RegisterPage extends StatefulWidget {
  final int indexx;
  const RegisterPage(
      {Key key,this.indexx})
      : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController instagram =
      TextEditingController(text: 'Instagram username');

  TextEditingController password = TextEditingController(text: '');
  String text_error;
  var op_error;
  bool eye=true;


  bool _isLoading=false;
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
          setState(() {
            _isLoading = true; // your loader has started to load
          });
//          Navigator.of(context)
//            .push(MaterialPageRoute(builder: (_) => MainPage()));
          print('token1');
          final SharedPreferences prefs = await _prefs;
          print('token2');
          String token=prefs.getString('token');
          print(token);
          print('token3');
          print(password.text);
          var c1=await login_app(instagram.text,password.text,"",token);
          String pkey="";
          if (c1["status"]==200)
            {
              pkey=c1["data"]["account"]["pkey"];
            }
          var c2=await login_web(instagram.text,password.text,pkey,token);
          if(c1["status"]==200 && c2["status"]==200 ){






            final SharedPreferences prefs = await _prefs;
            var info=jsonEncode({
              'username':instagram.text,
              'password':password.text,
              'data':c1["data"]["page_info"]["data"],
              'pkey':c1["data"]["account"]["pkey"],
            });

            prefs.setString('pkey', c1["data"]["account"]["pkey"]);
            prefs.setInt('index', widget.indexx);

            var lis=prefs.getStringList('infos') ?? [];
            lis.add(info);
            prefs.setStringList('infos',lis);




            Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MainPage(img_url:c1["data"]["page_info"]["data"]["page"]["profile_pic_url"])));


          }else if(c1["status"]==202 || c2["status"]==202){//instagram-2step
            DialogTextField tex=DialogTextField(hintText: "two step code");

            final result=await showTextInputDialog(context: context,message:"enter your two step code",title: "Two step", textFields: [tex]);
            print(tex.toString());
            print(result);
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) => Two_step()));
          }else if(c1["status"]==201 || c2["status"]==201){//challenge
            final result=await showOkAlertDialog(context: context,message:'your account  has been challenged you can continue after solve this problem please solve the problem in instagrm application then continue process ' ,title: '${"instagram-account-login-challenge".replaceAll('-', ' ')}',okLabel: 'Ok',barrierDismissible: false);

            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) => Two_step()));












          }else{
            var s;
            if(c1["status"]!=200){
              s=c1["status_message"];
            }else{
              s=c2["status_message"];
            }
            text_error=s;
            op_error=1.0;
            setState(() {

            });


          }
          setState(() {
            _isLoading = false; // your loader has started to load
          });


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
                  child: TextField(
                    controller: instagram,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: password,
                    style: TextStyle(fontSize: 16.0),
                    obscureText: eye,

                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: (){
                          eye=!eye;
                          setState(() {
                            
                          });
                        },
                          child: eye?Icon(Icons.visibility_off):Icon(Icons.visibility)
                      ) ,

                    ),

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
                        Spacer(flex:3),
                        // Padding(
                        //     padding: EdgeInsets.only(bottom: 20), child: socialRegister)
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
                  ),
                  _isLoading? Center(child: CircularProgressIndicator(backgroundColor:Colors.deepOrange ,)):null
                ].where(notNull).toList(),
              ),
            );
  }
}
