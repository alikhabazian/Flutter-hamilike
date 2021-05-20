
import 'dart:convert';

import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';


import 'confirm_otp_page.dart';

Future<Map<String, dynamic>> postRequest ( String number) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/auth/login';
  var body = jsonEncode({
    'mobile':  number,

  });

  //print("Body: " + body);

  var response = await http.post(url,
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json"},
      body: body
      );
//  print(response);
  return json.decode(response.body);
      }





class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneNumber = TextEditingController(text: '913XXXXXXX');

  bool _isLoading = false;

  bool _validate = false;
  String text="";
  GlobalKey prefixKey = GlobalKey();
  double prefixWidth = 0;
  String pre='+98';
  String qq='Value isn\'t Normall';



  Widget prefix() {
    return Container(

      key: prefixKey,
      //padding: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
      margin: EdgeInsets.only(right: 4.0),

      child: CountryCodePicker(





        initialSelection: 'IR',
        onChanged: _onCountryChange,

        favorite: ['+98','IR'],
      )
    );
  }
  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
//    print("New Country selected: " + countryCode.toString());
    pre=countryCode.toString();
  }
  @override
  Widget build(BuildContext context) {
    Widget background = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/back.jpg'), fit: BoxFit.cover),
      ),
//      foregroundDecoration: BoxDecoration(color: transparentYellow),
    );

    Widget title = Text(
      'Forgot your Password?',
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
          'Enter your registered mobile number to get the OTP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget sendButton = Positioned(
      left: (MediaQuery.of(context).size.width / 4)-32,
      bottom: 40,
      child: InkWell(
        onTap: ()async {
          setState(() {
            _isLoading = true; // your loader has started to load
          });
//          Navigator.of(context).push(MaterialPageRoute(builder:(_)=>ConfirmOtpPage(number:'0'+phoneNumber.text )));



          if(phoneNumber.text.isEmpty |  (phoneNumber.text.length <10) ) {setState(() {
              _validate = true;
            });}

           else {
             if((phoneNumber.text[9]=='X')){
               setState(() {
                 _validate = true;
               });
             }
             else {
               var p = pre + phoneNumber.text;
               print("$p");
               _validate = false;


               var c=await postRequest('0'+phoneNumber.text);



               print(c.toString());
               if (c['success']==true ){
                 Navigator.of(context).push(MaterialPageRoute(builder:(_)=>ConfirmOtpPage(number:'0'+phoneNumber.text )));

             }
               else{
                 setState(() {

                   _validate = true;
                   qq=c['status_message'].replaceAll('-',' ');
                 });
               }


//              Map data = {
//              "mobile": '0'+phoneNumber.text
//              };
////              var body = json.encode(data);
//
//              http.post( uri ,body: data).then((response) => {print("Response status: ${response.statusCode}")});
////              print(response);

             }
             }
          setState(() {
            _isLoading = false; // your loader has started to load
          });




        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Send OTP",
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

    Widget phoneForm = Container(
      height: 210,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            width:MediaQuery.of(context).size.width-64.0,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0,bottom: 0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),)),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                      prefix(),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: TextField(

                        controller: phoneNumber,
                        style: TextStyle(fontSize: 16.0),
                        keyboardType: TextInputType.phone,

                        onChanged: (String newVal) {
                          int maxLength=10;
                          if(newVal.length <= maxLength){
                            text = newVal;
                          }else{
                            phoneNumber.value = new TextEditingValue(
                                text: text,




                                selection: new TextSelection(
                                    baseOffset: maxLength,
                                    extentOffset: maxLength,
                                    affinity: TextAffinity.downstream,
                                    isDirectional: false
                                ),
                                composing: new TextRange(
                                    start: 0, end: maxLength
                                )
                            );
                            phoneNumber.text = text;
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        showCursor: true,
                        decoration: InputDecoration(
//                        labelText: 'Enter the Value',

                          errorText: _validate ? qq : null,
//                            errorText:'sdfsd'
                        ),


                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          sendButton,
        ],
      ),
    );

    Widget resendAgainText = Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Didn't receive the OPT? ",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 14.0,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Resend again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ));
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        decoration:BoxDecoration(
            image:DecorationImage(
                image: AssetImage('assets/back.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: Container(
//          decoration: BoxDecoration(
//            color:transparentYellow
//          ),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: _isLoading? Center(child: CircularProgressIndicator(backgroundColor:Colors.deepOrange ,)):Stack(
              children: <Widget>[
                SingleChildScrollView(
                  reverse: true,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height-90,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(flex: 3),
                          title,
                          Spacer(),
                          subTitle,
                          Spacer(flex: 2),
                          phoneForm,
                          Spacer(flex: 2),
//                      resendAgainText,

                        ],
                      ),
                    ),
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


