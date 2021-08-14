import 'package:repeat_mehrdadproject/app_properties.dart';
// import 'package:repeat_mehrdadproject/screens/intro_page.dart';
import 'package:repeat_mehrdadproject/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:repeat_mehrdadproject/screens/auth/welcome_back_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
//import 'package:ecommerce_int2/date_time.dart';
//import 'dart:async';


int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;
bool timeout=false;
//var a=CountdownTimer(
//endTime: endTime,
//
//  textStyle: TextStyle(
//    color:
//  ),
//
//);


Future<Map<String, dynamic>> postRequest_verify ( String number,String code) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/auth/verify';
  var body = jsonEncode({
    'mobile':  number,
    'code':code,
  });

  //print("Body: " + body);

  var response = await http.post(Uri.parse(url),
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json"},
      body: body
  );
//  print(response);
  return json.decode(response.body);
}





class ConfirmOtpPage extends StatefulWidget {
  final String number;
  ConfirmOtpPage({Key key, @required this.number}) : super(key: key);

  @override

  _ConfirmOtpPageState createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _token;
  @override

  TextEditingController tx=TextEditingController();

  TextEditingController otp1 = TextEditingController(text: '1');
  TextEditingController otp2 = TextEditingController(text: '2');
  TextEditingController otp3 = TextEditingController(text: '3');
  TextEditingController otp4 = TextEditingController(text: '4');
  TextEditingController otp5 = TextEditingController(text: '5');
  TextEditingController otp6 = TextEditingController(text: '6');
  String number ;


//    static String number;

  @override
  void initState() {
//    Size size = widget.size;
    // TODO: implement initState
    super.initState();
    print('${widget.number}');
    number= widget.number;
  }
//  _ConfirmOtpPageState({this.number});


//  Widget resendAgainText = ;


  Widget otpBox(TextEditingController otpController) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: SizedBox(
          width: 9,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: otpController,
              decoration: InputDecoration(
                  border: InputBorder.none, contentPadding: EdgeInsets.zero),
              style: TextStyle(fontSize: 16.0),
              keyboardType: TextInputType.phone,
            ),
          ),
        ),
      ),
    );
  }


//  void startTimer() {
//    const oneSec = const Duration(seconds: 1);
//    _timer = new Timer.periodic(
//      oneSec,
//          (Timer timer) {
//        if (_start == 0) {
//          setState(() {
//            timer.cancel();
//          });
//        } else {
//          setState(() {
//            _start--;
//          });
//        }
//      },
//    );
//  }


  @override
  Widget build(BuildContext context) {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;
    timeout=false;
//    startTimer();
//    number=widget.number;



    Widget title = Text(
      'Confirm your OTP',
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
          'Please wait, we are confirming your OTP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget verifyButton = Center(
      child: InkWell(
        onTap: ()async {

          print(tx.text);
          print(number);
          var ss=await postRequest_verify(number,tx.text);
          print(ss.toString());
          if(ss['success']==true) {

            final SharedPreferences prefs = await _prefs;
            prefs.setString('token',ss['data']['token']);

            print(prefs.getString('token'));



//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (_) => IntroPage()));
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MainPage()));
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Verify",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(236, 60, 3, 1),
                    Color.fromRGBO(234, 60, 3, 1),
                    Color.fromRGBO(216, 78, 16, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
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

    Widget otpCode = Container(
      padding: const EdgeInsets.only(right: 28.0),
      height: 190,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          otpBox(otp1),
          otpBox(otp2),
          otpBox(otp3),
          otpBox(otp4),
          otpBox(otp5),
          otpBox(otp6)
        ],
      ),
    );

//    Widget resendText = Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          "Resend again after ",
//          style: TextStyle(
//            fontStyle: FontStyle.italic,
//            color: Color.fromRGBO(255, 255, 255, 0.5),
//            fontSize: 14.0,
//          ),
//        ),
//        InkWell(
//          onTap: () {},
//          child: Text(
//            '0:39',
//            style: TextStyle(
//              color: Colors.white,
//              fontWeight: FontWeight.bold,
//              fontSize: 14.0,
//            ),
//          ),
//        ),
//      ],
//    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
        child: Container(
//          decoration: BoxDecoration(color: transparentYellow),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(flex: 3),
                      title,
                      Spacer(),
                      subTitle,
                      Spacer(flex: 1),
                      Padding(
                        padding: const EdgeInsets.only(right: 28.0),
                        child: Center(
                          child: PinCodeTextField(
                            controller: tx,
                            highlightColor: Colors.white,
                            highlightAnimation: true,
                            highlightAnimationBeginColor: Colors.white,
                            highlightAnimationEndColor: Theme.of(context).primaryColor,
                            pinTextAnimatedSwitcherDuration: Duration(milliseconds: 500),
                            wrapAlignment: WrapAlignment.center,
                            hasTextBorderColor: Colors.transparent,
                            highlightPinBoxColor: Colors.white,
                            autofocus: true,
                            pinBoxHeight: MediaQuery.of(context).size.width/9,
                            pinBoxWidth: MediaQuery.of(context).size.width/9,
                            pinBoxRadius: 5,
                            defaultBorderColor: Colors.transparent,
                            pinBoxColor: Color.fromRGBO(255, 255, 255, 0.8),
                            maxLength: 6,
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
//                      otpCode,
                      Padding(
                        padding: const EdgeInsets.only(right: 28.0),
                        child: verifyButton,
                      ),
                      Spacer(flex: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Didn't receive the OPT? $number ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 14.0,
                            ),
                          ),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {

                              Navigator.of(context).pop();



                            },
                            child: Text(
                              'Wrong number!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Resend again after ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 14.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if(timeout){

                                Navigator.of(context).pop();

                               }
                            },
                            child: CountdownTimer(
                              endWidget: Text(
                                "Resend again",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromRGBO(0, 0, 00, 0.9),
                                  fontSize: 14.0,
                                ),
                              ),


                              textStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                fontSize: 14.0,
                              ),
                              endTime: endTime,
                              onEnd: (){timeout=true;},
                            )
                          ),
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
