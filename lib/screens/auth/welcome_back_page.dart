
import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:repeat_mehrdadproject/screens/main/main_page.dart';
import 'package:repeat_mehrdadproject/Custom_bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repeat_mehrdadproject/screens/settings/settings_page.dart';
import 'register_page.dart';
import 'dart:convert';
// import 'package:popup_menu/popup_menu.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';




Future<Map<String, dynamic>> delete_profiles ( String token,String pkey) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/account/account_delete';
  var body = jsonEncode({
    "pkey": pkey
  });

  var response = await http.delete(Uri.parse(url),
    headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
     body: body
  );
  print('hi');
  print(response.body);
  return json.decode(response.body);
}

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 400) * MediaQuery.of(context).size.width;
  }
}

class Const{
  static const String S1='Edit configuration';
  static const String S2='Set Default';
  static const String S3='Delete Account';

  static const List<String> chosis=[S1,S2,S3];
}


class options_login extends StatefulWidget {

  options_login(this.index,this.pkey,this.username,this.image_p,this.full_name,this.father);
  final father;
  final String pkey;
  final int index;
  final String username;
  final String image_p;
  final String full_name;

  @override
  _options_loginState createState() => _options_loginState();
}

class _options_loginState extends State<options_login> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void choice(String Ch)async{
    if(Ch=='Edit configuration'){
      final SharedPreferences prefs = await _prefs;

      prefs.setInt('index', widget.index);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SettingsPage()));

    }
    else if(Ch=='Set Default'){
      final SharedPreferences prefs = await _prefs;

      prefs.setInt('Default', widget.index);


    }
    else if(Ch=='Delete Account'){
      final SharedPreferences prefs = await _prefs;
      var token=prefs.getString('token');
      var response=await delete_profiles(token,widget.pkey);
      if(response["success"]){
        widget.father.asyncMethod();
      }




    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:() async{
          final SharedPreferences prefs = await _prefs;
          prefs.setString('pkey', this.widget.pkey);
          prefs.setInt('index', this.widget.index);
          // Navigator.of(context).pushNamedAndRemoveUntil()
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(img_url: widget.image_p, username: widget.username,)
              ),
              ModalRoute.withName("/Home")
          );
          // Navigator.of(context)
          //     .push(MaterialPageRoute(
          //     builder: (_) => MainPage(img_url: image_p, username: username,)
          // )
          // );
        }

         ,
        child:Container(
          margin: const EdgeInsets.only(bottom: 10,),
          height: MediaQuery.of(context).size.height/7,
          child:Container(
            height: 160,
            width: MediaQuery.of(context).size.width-64.0,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.2),
//                border: Border.all(color: Colors.deepPurple,width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),

            child: Row(

              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  child: CachedNetworkImage(
                    imageUrl: widget.image_p,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 50,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  // backgroundImage: ,
                  // backgroundImage: NetworkImage(image_p),
                ),

                Column(

                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
//                    Text(
//                      'Ali khabazian',
//
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//
//
//
//
//                          color: Colors.black,
//                          fontSize: 25.0,
//                          fontWeight: FontWeight.w900,
//                          shadows: [
//                            BoxShadow(
//                              color: Color.fromRGBO(0, 0, 0, 0.15),
//                              offset: Offset(0, 5),
//                              blurRadius: 10.0,
//                            )
//                          ]),
//                    ),
                    Text(widget.username,style: TextStyle(fontSize:
                    AdaptiveTextSize().getadaptiveTextSize(context, (widget.username.length<15)?20:15),
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          )
                        ]
                    )
                    ),
                    Text(
                      widget.full_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(

                          color: Colors.white30,
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
                  ],
                ),
//                Spacer(flex:7),
                PopupMenuButton<String>(

                  onSelected: choice,
                  itemBuilder: (BuildContext context){
                    return Const.chosis.map((String choice){
                      return PopupMenuItem<String>(value: choice,child: Text(choice));
                    }).toList();

                  },

                  icon: Icon(
                    Icons.more_vert,
                    size: 40,
                    color:  Colors.white30,
                  ),
                ),
              ],
            ),
          ),



        ));
  }
}


Future<Map<String, dynamic>> get_profiles ( String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/auth/profile';


  var response = await http.get(Uri.parse(url),
    headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
//      body: body
  );
  print('hi');
  print(response.body);
  return json.decode(response.body);
}
class loginoptions extends StatelessWidget {
  loginoptions({Key key, this.indexx}) : super(key: key);
  final int indexx;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => RegisterPage(indexx: indexx,)));
        } ,
        child:Container(
          margin: const EdgeInsets.only(top: 10,),
          height: MediaQuery.of(context).size.height/7,
          child:Container(

            height: 160,
            width: MediaQuery.of(context).size.width-64.0,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.2),
//                border: Border.all(color: Colors.deepPurple,width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),

            child: Center(
              child: Text('Add New ID +',
                textAlign: TextAlign.center,


                style: TextStyle(


                    color: Colors.white38,
                    fontSize: 38.0,
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
          ),



        ));
  }
}


class WelcomeBackPage extends StatefulWidget {


  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  bool _isLoading=true;
  var usernames;
  String username='ali';
  ImageProvider ss;
  var sss=0;






  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController email =
      TextEditingController(text: 'example@email.com');

  TextEditingController password = TextEditingController(text: '12345678');

  void asyncMethod() async {

    setState(() {
      _isLoading = true; // your loader has started to load
    });

    final SharedPreferences prefs = await _prefs;
      var token=prefs.getString('token');
      var response=await get_profiles(token);
      usernames=response['data']['accounts'];
      print(usernames);
    setState(() {
      _isLoading = false; // your loader has started to load
    });



  }

  @override
  void initState() {
    // TODO: implement initState
    // (() async {
    //   final SharedPreferences prefs = await _prefs;
    //   var token=prefs.getString('token');
    //   var response=await get_profiles(token);
    //   usernames=response['data']['accounts'];
    //   print(usernames);
    //   // usernames=prefs.getStringList('infos')??[];
    //   setState(() {
    //
    //   });
    // })();


    super.initState();
    asyncMethod();



  }
  @override
  Widget build(BuildContext context) {

    Widget welcomeBack = Text(
      'Add your Instagram Account to get like and Active Follower',
      textAlign: TextAlign.center,
      style: TextStyle(

          color: Colors.white,
          fontSize: 38.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Text(
      'An SMS OTP (one-time password) is a secure authorization method where a numeric or alphaunumeric code is sent to a mobile number. ',
      style: TextStyle(
        color: Colors.white24,
        fontSize: 16.0,
      ),
      textAlign: TextAlign.center,
    );

    Widget loginButton = Positioned(
      left: (MediaQuery.of(context).size.width / 4)-32,
      bottom: 40,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => RegisterPage(indexx: 0,)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Log In",
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



//     Widget loginoptions = InkWell(
//       onTap: () {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (_) => RegisterPage(indexx: 0,)));
//     } ,
//         child:Container(
//           margin: const EdgeInsets.only(top: 10,),
//              height: MediaQuery.of(context).size.height/7,
//             child:Container(
//
//             height: 160,
//             width: MediaQuery.of(context).size.width-64.0,
//             padding: const EdgeInsets.only(left: 32.0, right: 12.0),
//             decoration: BoxDecoration(
//                 color: Color.fromRGBO(255, 255, 255, 0.2),
// //                border: Border.all(color: Colors.deepPurple,width: 2),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 )),
//
//             child: Center(
//               child: Text('Add New ID +',
//                 textAlign: TextAlign.center,
//
//
//                 style: TextStyle(
//
//
//                     color: Colors.white38,
//                     fontSize: 38.0,
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       BoxShadow(
//                         color: Color.fromRGBO(0, 0, 0, 0.15),
//                         offset: Offset(0, 5),
//                         blurRadius: 10.0,
//                       )
//                     ]),
//               ),
//             ),
//           ),
//
//
//
//     ));

    Widget loginoptions1=InkWell(
//        onTap: ()async {
////          if(sss==1) {
////          Navigator.of(context)
////              .push(MaterialPageRoute(builder: (_) => MainPage(image_prof:ss ,username: username,)));
////          }
////          sss=sss+1;
//          final SharedPreferences prefs = await _prefs;
//            print((prefs.getStringList('infos')));
//         var s=jsonDecode(prefs.getStringList('infos')[0]) ;
//          print(s);
//         username=s['username'];
//         var im_url=s['data']['page']['profile_pic_url'];
//         print(im_url);
//          ss=NetworkImage(im_url);
//
//




//        } ,
        child:Container(
          height: MediaQuery.of(context).size.height/7,
          child:Container(
            height: 160,
            width: MediaQuery.of(context).size.width-64.0,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.2),
//                border: Border.all(color: Colors.deepPurple,width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),

            child: Row(

              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: (username=='ali')?AssetImage('assets/background.jpg'):ss,
                ),

                Column(

                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
//                    Text(
//                      'Ali khabazian',
//
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//
//
//
//
//                          color: Colors.black,
//                          fontSize: 25.0,
//                          fontWeight: FontWeight.w900,
//                          shadows: [
//                            BoxShadow(
//                              color: Color.fromRGBO(0, 0, 0, 0.15),
//                              offset: Offset(0, 5),
//                              blurRadius: 10.0,
//                            )
//                          ]),
//                    ),
                    Text(username,style: TextStyle(fontSize:
                    AdaptiveTextSize().getadaptiveTextSize(context, 20),
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                        shadows: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              offset: Offset(0, 5),
                              blurRadius: 10.0,
                            )
                          ]
                    )
                    ),
                    Text(
                      'Add your Instagram ',
                      textAlign: TextAlign.center,
                      style: TextStyle(

                          color: Colors.white30,
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
                  ],
                ),
//                Spacer(flex:7),
                Icon(
                  Icons.more_vert,
                  size: 40,
                  color:  Colors.white30,
                ),
              ],
            ),
          ),



        ));


    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot your password? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Reset password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(


      body: _isLoading? Center(child: CircularProgressIndicator(backgroundColor:Colors.deepOrange ,)):Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/back.jpg'),
                  fit: BoxFit.cover)
            ),
          ),
          Container(
//            decoration: BoxDecoration(
//                color: transparentYellow,
//
//            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right: 28.0,bottom: 85,top: 28),
            child:( usernames==null||usernames.isEmpty )? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 20),
                welcomeBack,
                Spacer(),
                subTitle,
                Spacer(flex: 10),
                loginoptions(indexx: 0),
                Spacer(flex: 20),
//                forgotPassword
              ],
            )
                :ListView.builder(

             physics: const AlwaysScrollableScrollPhysics(),
              itemCount: usernames.length+1,

                itemBuilder: (BuildContext context, int index) {
                  if(usernames.length==index){
                    return loginoptions(indexx: index,);
                  }
                  // var x=jsonDecode(usernames[index]);
                  var x=usernames[index];
                  print(x);
                  print(x["username"]);
                  // return options_login(index,x["username"],x["data"]['page']['profile_pic_url'],x["data"]['page']['full_name']);
                  return options_login(index,x['pkey'],x["username"],x['avatar']??'https://scontent-syd2-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-syd2-1.cdninstagram.com&_nc_ohc=b2E2ZiBMGFwAX_pErM9&edm=AL4D0a4BAAAA&ccb=7-4&oh=f02011f9911c912f654ba0b3ed145d12&oe=60B1C54F&_nc_sid=712cc3&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2-ccb7-4',x["username"],this);
                }

            ),
          )
        ],
      ),
    );
  }
}
