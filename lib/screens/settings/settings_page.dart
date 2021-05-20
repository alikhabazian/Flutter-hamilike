import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:repeat_mehrdadproject/custom_background.dart';
import 'package:repeat_mehrdadproject/screens/auth/welcome_back_page.dart';
// import 'package:repeat_mehrdadproject/screens/settings/change_country.dart';
// import 'package:ecommerce_int2/screens/settings/change_password_page.dart';
// import 'package:ecommerce_int2/screens/settings/legal_about_page.dart';
// import 'package:ecommerce_int2/screens/settings/notifications_settings_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:textfield_tags/textfield_tags.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:adaptive_dialog/adaptive_dialog.dart';

// import 'change_language_page.dart';
Future<Map<String, dynamic>> get_profile ( String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/auth/profile';
//  var body = jsonEncode({
//    "username": username,
//    "password": password,
//    "api_type": "app",
//    "pkey": ""
//  });

  //print("Body: " + body);

  var response = await http.get(url,
    headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
//      body: body
  );
  print(response.body);
  return json.decode(response.body);
}

Future<Map<String, dynamic>> setconfig ( String pkey
                                        ,bool allow_action
                                        ,bool followers_on
                                        ,int followers_to_add
                                        ,bool like_on
                                        ,bool like_all
                                        ,int like_for_each_post
                                        ,int like_hours_limit
                                        ,bool like_by_hashtag
                                        ,List<String> like_hashtags
                                        ,bool comment_on
                                        ,bool comment_all
                                        ,int comment_for_each_post
                                        ,int comment_hours_limit
                                        ,bool comment_by_hashtag
                                        ,List<String> comment_hashtags
                                        ,String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/account/account_config';
  var body = jsonEncode({
    "pkey": pkey,
    "allow_action": allow_action,
    "filters": {
              "followers_on": followers_on,
              "followers_to_add": followers_to_add,
              "like_on": like_on,
              "like_all": like_all,
              "like_for_each_post": like_for_each_post,
              "like_hours_limit": like_hours_limit,
              "like_by_hashtag": like_by_hashtag,
              "like_hashtags": like_hashtags,//array
              "comment_on": comment_on,
              "comment_all": comment_all,
              "comment_for_each_post": comment_for_each_post,
              "comment_hours_limit": comment_hours_limit,
              "comment_by_hashtag": comment_by_hashtag,
              "comment_hashtags": comment_hashtags//array


              }

  });


  print("Body: " + body);

  var response = await http.post(url,
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
      body: body
  );
  print(response.body);
  return json.decode(response.body);
}






class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = true;
  bool allow_action=false;
  bool d=false;
  bool dd=false;
  bool ddd=false;
  int dropdownValue_fllow = 100;
  bool dropdownValue_which_like = true;
  int dropdownValue_like=100;
  int dropdownValue_like_hour = 0;
  // int dropdownValue = 1000;
  List<String> dropdownValue_like_hashtag =[] ;

  bool dropdownValue_which_comment = true;
  int dropdownValue_comment=100;
  int dropdownValue_comment_hour = 0;

  List<String> dropdownValue_comment_hashtag =[] ;





  int followers_to_add;




@override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataLoadFunction();
  }

  dataLoadFunction() async {
    setState(() {
      _isLoading = true; // your loader has started to load
    });
    // fetch you data over here
    final SharedPreferences prefs = await _prefs;






    var token=prefs.getString('token');
    var index=prefs.getInt('index');
    if (index==null) {
      final result=await showOkAlertDialog(context: context,title: 'you are not select your account',message: "go to accounts list and select your selected acount",okLabel: 'Ok',barrierDismissible: false);
      if(result==OkCancelResult.ok){
        Navigator.pop(context);
      }
      // showDialog(context: context, builder: (context) {
      //   return Dialog(
      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      //       elevation: 16,
      //       child:Container(
      //         height: 200.0,
      //         width: 300.0,
      //         child: Center(child: Column(
      //           mainAxisAlignment : MainAxisAlignment.center,
      //           children: [
      //
      //             Text("you are not select your account"),
      //             GestureDetector(
      //               child: Container(
      //                 height: 20,
      //
      //                 color: Colors.deepOrange,
      //                 child: Text('go back')
      //                 ,
      //               ),
      //               onTap: (){
      //                 print('d');
      //                 // setState(() { });
      //                 Navigator.pop(context);
      //                 Navigator.pop(context);
      //               },)
      //           ],
      //         )),
      //
      //       )
      //   );
      // });
    }
    var response=await get_profile(token);
    print('index');
    print(index);
    var filtters=response["data"]["accounts"][index]["filters"];
    print("filtters");
    print(filtters);
    if(filtters==null){
      setState(() {
        _isLoading = false; // your loder will stop to finish after the data fetch
      });
    }
    allow_action=response["data"]["accounts"][index]["allow_action"];

    d=filtters['followers_on'];

    dd=filtters["like_on"];
    ddd=filtters['comment_on'];
    dropdownValue_fllow = d?filtters["followers_to_add"]:100;
    dropdownValue_which_like =dd? filtters["like_all"]:true;
    dropdownValue_like=dd?filtters["like_for_each_post"]:100;
    dropdownValue_like_hour = filtters["like_hours_limit"];
    // int dropdownValue = 1000;





    dropdownValue_like_hashtag =( filtters["like_hashtags"] as List<dynamic>).cast<String>();

    dropdownValue_which_comment = ddd? filtters["comment_all"]:true;
    dropdownValue_comment=ddd?filtters["comment_for_each_post"]:100;
    dropdownValue_comment_hour = filtters["comment_hours_limit"];

    dropdownValue_comment_hashtag =(filtters["comment_hashtags"] as List<dynamic>).cast<String>() ;

    setState(() {
      _isLoading = false; // your loder will stop to finish after the data fetch
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          title: Text(
            'Config',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
        ),
        body:_isLoading? Center(child: CircularProgressIndicator(backgroundColor:Colors.deepOrange ,)):SafeArea(
          bottom: true,
          child: LayoutBuilder(
                      builder:(builder,constraints)=> SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),

                    title: Text('Enable allow action with this account'),
                    subtitle: Text('You give coin by each account was enabled',style: TextStyle(
                        color: Colors.white60
                    ),),
                    leading: Checkbox(value: allow_action,),
//                    trailing: Icon(Icons.chevron_right, color: yellow),
                    onTap: () {

                      setState(() {
                        allow_action=!allow_action;
                      });
                      // Navigator.of(context).push(
                      // MaterialPageRoute(builder: (_) => SettingsPage()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  ListTile(

                    title: Text('Enable Follow Actions'),
                    subtitle: Text('By adding this action your user show-in follow list and any user '
                        'may follow you. The cost of each follow is 25 coin',style: TextStyle(
                      color: Colors.white60
                    ),),
                    leading: Checkbox(value: d,),
//                    trailing: Icon(Icons.chevron_right, color: yellow),
                    onTap: () {

                      setState(() {
                        d=!d;
                      });
                     // Navigator.of(context).push(
                       // MaterialPageRoute(builder: (_) => SettingsPage()));
                      },
                  ),

                  ListTile(
                    enabled: d,
                    title: Text('How many followers do you want?'),
                    subtitle: Column(
                      children: [Text('You can select Max number of follower that you need.After'
                          'this number follow Action will be disable and you can reset any time do you want'),
                              DropdownButton<int>(value: dropdownValue_fllow,dropdownColor: Colors.blue,

                          items: <int>[100,200,500,1000,5000 ]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(


                              value: value,
                              child: Text(value<1000?'${value} followers':'${value/1000}K followers'),
                            );
                          }).toList(),

                          onChanged: d?(int newValue){
                            print(newValue);
                            setState(() {
                              dropdownValue_fllow = newValue;
                            });

                          }:null,
                        ),
                                    ]),
//                    leading: Image.asset('assets/icons/language.png'),
                                    onTap: () {




                          // Navigator.of(context).push(
                          // MaterialPageRoute(builder: (_) => ChangeLanguagePage()));
                                      },

                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Like',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  ListTile(

                    title: Text('Enable Like Actions'),
                    subtitle: Text('By adding this action your user post will be like with other user',style: TextStyle(
                        color: Colors.white60
                    ),),
                    leading: Checkbox(value: dd,),
//                    trailing: Icon(Icons.chevron_right, color: yellow),
                    onTap: () {

                      setState(() {
                        dd=!dd;
                      });
//                      Navigator.of(context).push(
//                        MaterialPageRoute(builder: (_) => SettingsPage()));
                    },
                  ),
                  ListTile(
                    enabled: dd,
                    title: Text('Which post will be like by other'),
                    subtitle:Center(
                      child: DropdownButton<bool>(value: dropdownValue_which_like,dropdownColor: Colors.blue,

                        items: <bool>[true, false]
                            .map<DropdownMenuItem<bool>>((bool value) {
                          return DropdownMenuItem<bool>(


                            value: value,
                            child: Text(value?'all posts':'hashtaged posts'),
                          );
                        }).toList(),

                        onChanged: dd?(bool newValue){
                          print(newValue);
                          setState(() {
                            dropdownValue_which_like = newValue;
                          });

                        }:null,
                      ),
                    ),



                  ),
                  ListTile(
                    enabled: dd,
                    title: Text('How many like do you need for each post of page?'),
                    subtitle:Center(
                      child: DropdownButton<int>(value: dropdownValue_like,dropdownColor: Colors.blue,

                        items: <int>[100,200,500,1000,5000 ]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(


                            value: value,
                            child: Text(value<1000?'${value} likes':'${value/1000}K  likes'),
                          );
                        }).toList(),

                        onChanged: dd?(int newValue){
                          print(newValue);
                          setState(() {
                            dropdownValue_like = newValue;
                          });

                        }:null,
                      ),
                    ),



                  ),
                  ListTile(
                    enabled: dd,
                    title: Text('how many hour after published make like for you post?'),
                    subtitle:Center(
                      child: DropdownButton<int>(value: dropdownValue_like_hour,dropdownColor: Colors.blue,

                        items: <int>[0, 3, 6, 9, 12]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(


                            value: value,
                            child: Text(value!=0?'$value':'unlimited'),
                          );
                        }).toList(),

                        onChanged: dd?(int newValue){
                          print(newValue);
                          setState(() {
                            dropdownValue_like_hour = newValue;
                          });

                        }:null,
                      ),
                    ),



                  ),
                  ListTile(
                    enabled: dd && !dropdownValue_which_like,
                    title: Text('Hashtag'),
                    subtitle:Center(

                      child:  TextFieldTags(



                        initialTags: dropdownValue_like_hashtag,






                          tagsStyler: TagsStyler(
                              tagTextStyle: TextStyle(fontWeight: FontWeight.bold),
                              tagDecoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8.0), ),
                              tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.red[900]),
                              tagPadding: const EdgeInsets.all(6.0)
                          ),
                          textFieldStyler: TextFieldStyler(textFieldEnabled:dd && !dropdownValue_which_like ,textFieldFocusedBorder: OutlineInputBorder( borderSide:BorderSide(color: Colors.black))),
                          onTag: (tag) {dropdownValue_like_hashtag.add(tag);},
                          onDelete: (tag) {dropdownValue_like_hashtag.remove(tag);},


                      )
                    ),



                  ),


                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Comment',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  ListTile(

                    title: Text('Enable Comment Actions'),
                    subtitle: Text('By adding this action your user post will be comment with other user',style: TextStyle(
                        color: Colors.white60
                    ),),
                    leading: Checkbox(value: ddd,),
//                    trailing: Icon(Icons.chevron_right, color: yellow),
                    onTap: () {

                      setState(() {
                        ddd=!ddd;
                      });
//                      Navigator.of(context).push(
//                        MaterialPageRoute(builder: (_) => SettingsPage()));
                    },
                  ),
                  ListTile(
                    enabled: ddd,
                    title: Text('Which post will be comment by other'),
                    subtitle:Center(
                      child: DropdownButton<bool>(value: dropdownValue_which_comment,dropdownColor: Colors.blue,

                        items: <bool>[true, false]
                            .map<DropdownMenuItem<bool>>((bool value) {
                          return DropdownMenuItem<bool>(


                            value: value,
                            child: Text(value?'all posts':'hashtaged posts'),
                          );
                        }).toList(),

                        onChanged: ddd?(bool newValue){
                          print(newValue);
                          setState(() {
                            dropdownValue_which_comment = newValue;
                          });

                        }:null,
                      ),
                    ),



                  ),
                  ListTile(
                    enabled: ddd,
                    title: Text('How many comment do you need for each post of page?'),
                    subtitle:Center(
                      child: DropdownButton<int>(value: dropdownValue_comment,dropdownColor: Colors.blue,

                        items: <int>[100,200,500,1000,5000 ]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(


                            value: value,
                            child: Text(value<1000?'${value} comment':'${value/1000}K  likes'),
                          );
                        }).toList(),

                        onChanged: ddd?(int newValue){
                          print(newValue);
                          setState(() {
                            dropdownValue_comment = newValue;
                          });

                        }:null,
                      ),
                    ),



                  ),
                  ListTile(
                    enabled: ddd,
                    title: Text('how many hour after published make comment for you post?'),
                    subtitle:Center(
                      child: DropdownButton<int>(value: dropdownValue_comment_hour,dropdownColor: Colors.blue,

                        items: <int>[0, 3, 6, 9, 12]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(


                            value: value,
                            child: Text(value!=0?'$value':'unlimited'),
                          );
                        }).toList(),

                        onChanged: ddd?(int newValue){
                          print(newValue);
                          setState(() {
                            dropdownValue_comment_hour = newValue;
                          });

                        }:null,
                      ),
                    ),



                  ),
                  ListTile(
                    enabled: ddd && !dropdownValue_which_comment,
                    title: Text('Hashtag'),
                    subtitle:Center(

                        child:  TextFieldTags(



                          initialTags: dropdownValue_comment_hashtag,






                          tagsStyler: TagsStyler(
                              tagTextStyle: TextStyle(fontWeight: FontWeight.bold),
                              tagDecoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8.0), ),
                              tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.red[900]),
                              tagPadding: const EdgeInsets.all(6.0)
                          ),
                          textFieldStyler: TextFieldStyler(textFieldEnabled:ddd && !dropdownValue_which_comment ,textFieldFocusedBorder: OutlineInputBorder( borderSide:BorderSide(color: Colors.black))),
                          onTag: (tag) {dropdownValue_comment_hashtag.add(tag);},
                          onDelete: (tag) {dropdownValue_comment_hashtag.remove(tag);},


                        )
                    ),



                  ),
                  ListTile(

                    title: Center(child: Text('Change',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent),)),
                    onTap: ()async{
                      final SharedPreferences prefs = await _prefs;
                      String token=prefs.getString('token');
                      String pkey=prefs.getString('pkey');


                      var response=await setconfig(pkey,allow_action,d,dropdownValue_fllow,dd,dropdownValue_which_like,dropdownValue_like,dropdownValue_like_hour,!dropdownValue_which_like,dropdownValue_like_hashtag,ddd,dropdownValue_which_comment,dropdownValue_comment,dropdownValue_comment_hour,!dropdownValue_which_comment,dropdownValue_comment_hashtag,token);
                      if(response['success']==true) {
                        Navigator.of(context).pop();
                      }

                      // followers_to_add=int.parse(dropdownValue.split(" ")[0]);

                    },



                  ),
/*
                   ListTile(
                    title: Text('Change Country'),
                     leading: Image.asset('assets/icons/country.png'),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ChangeCountryPage())),
                  ),
                   ListTile(
                    title: Text('Notifications'),
                     leading: Image.asset('assets/icons/notifications.png'),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NotificationSettingsPage())),
                  ),
                   ListTile(
                    title: Text('Legal & About'),
                     leading: Image.asset('assets/icons/legal.png'),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => LegalAboutPage())),
                  ),
                   ListTile(
                    title: Text('About Us'),
                     leading: Image.asset('assets/icons/about_us.png'),
                    onTap: (){},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Account',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  ListTile(
                    title: Text('Change Password'),
                    leading: Image.asset('assets/icons/change_pass.png'),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ChangePasswordPage())),
                  ),
                  ListTile(
                    title: Text('Sign out'),
                      leading: Image.asset('assets/icons/sign_out.png'),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => WelcomeBackPage())),
                  ),
*/
                ],
              ),
            ),
                        ),
                      )
          ),
        ),
      ),
    );
  }
}
