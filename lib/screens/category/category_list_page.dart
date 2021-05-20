import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:repeat_mehrdadproject/models/category.dart';
import 'package:repeat_mehrdadproject/screens/main/main_page.dart';
// import 'package:repeat_mehrdadproject/screens/product/components/color_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/staggered_category_card.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';





Future<Map<String, dynamic>> get_action ( String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/activity/next';
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

Future<Map<String, dynamic>> action ( String type,String pkey,String short_code,String media_id,String comment_content ,String action,String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/activity/action';
  var body = jsonEncode({
    "type": type,
    "pkey": pkey,
    "short_code": short_code,
    "media_id": media_id,
    'comment_content':comment_content,
    "action": action
  });

  print("Body: " + body);

  var response = await http.post(url,
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
      body: body
  );
  print(response.body);
  return json.decode(response.body);
}



class CategoryListPage extends StatefulWidget {
  final Function reset;
  CategoryListPage(this.reset);



  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  bool _isLoading = true;
  String type_of_action='Like';
  var shortcode;
  var image;
  var pkey;
  var coin=0;
  var type="";
  String comment="";
  var media_id="";
//  final MainPage that;
//  CategoryListPage({Key key, this.that}) : super(key: key);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool notNull(Object o) => o != null;
  void asyncMethod() async {
    setState(() {
      _isLoading = true; // your loader has started to load
    });
    final SharedPreferences prefs = await _prefs;

    var token=prefs.getString('token');

    var response1=await get_profile(token);
    coin=response1["data"]["coin"]["coin"];
    setState(() {
      // _isLoading = true; // your loader has started to load
    });

    var response=await get_action(token);
    if(response['status']!=200){
      final result=await showOkCancelAlertDialog(context: context,message:'${response['message']}' ,title: '${response['status_message'].replaceAll('-', ' ')}',okLabel: 'Try again',cancelLabel: 'Go main page',barrierDismissible: false);
      print('hi1');

      // print(result==OkCancelResult.ok);
      // print(result==OkCancelResult.cancel);
      // print('hi2');
      if(result==OkCancelResult.ok){
        asyncMethod();
      }
      else if(result==OkCancelResult.cancel){
        widget.reset();
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
      //             Text('${response['status_message']}'),
      //             GestureDetector(
      //               child: Container(
      //
      //                 color: Colors.deepOrange,
      //                 child: Text('Try again')
      //                 ,
      //               ),
      //               onTap: (){
      //                 print('d');
      //                 asyncMethod();
      //                 Navigator.pop(context);
      //               },)
      //           ],
      //         )),
      //
      //       )
      //   );
      // });
    }
    Map data=response["data"];

    if(data.containsKey("post_like")){
      type_of_action='Like';
      type='post_like';
      shortcode=data['post_like'] ['info']['post']["shortcode"];
      image=data['post_like'] ['info']['post']["media_url"];
      media_id=data['post_like'] ['info']['post']["media_id"];
    }else if(data.containsKey('account_follow')){
      type_of_action='Follow';
      type='account_follow';
      pkey=data["account_follow"]['pkey'];
      image=data['account_follow']['avatar'];



    }else if(data.containsKey('post_comment')){
      type_of_action='comment';
      type='post_comment';
      shortcode=data['post_comment'] ['info']['post']["shortcode"];
      image=data['post_comment'] ['info']['post']["media_url"];
      pkey=data["post_comment"]['pkey'];
      media_id=data["post_comment"]['info']['post']["media_id"];


    }

    setState(() {
      _isLoading = false; // your loader has started to load
    });








    // ....
  }

  List<Category> categories = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Gadgets',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Fashion',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Beauty',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];

  List<Category> searchResults;
  TextEditingController searchController = TextEditingController();
@override
  void setState(fn){
  // asyncMethod();
  print('$image');
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncMethod();
    // setState(() { });
      searchResults = categories;

  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF9F9F9),
      child: Container(
                  margin: const EdgeInsets.fromLTRB(0,10,0,80),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height-90,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment(-1, 0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      widget.reset();




                                    },
                                  ),
                                  Icon(Icons.monetization_on,color: Colors.orangeAccent,),
                                  Text(
                                    '$coin',
                                    style: TextStyle(
                                      color: darkGrey,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
//                      Container(
//                        padding: EdgeInsets.only(left: 16.0),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(5)),
//                          color: Colors.white,
//                        ),
//                        child: TextField(
//                          controller:searchController,
//                          decoration: InputDecoration(
//                              border: InputBorder.none,
//                              hintText: 'Search',
//                              prefixIcon: SvgPicture.asset('assets/icons/search_icon.svg', fit: BoxFit.scaleDown,)
//                          ),
//                          onChanged: (value) {
//                            if(value.isNotEmpty) {
//                              List<Category> tempList = List<Category>();
//                              categories.forEach((category) {
//                                if(category.category.toLowerCase().contains(value)) {
//                                  tempList.add(category);
//                                }
//                              });
//                              setState(() {
//                                searchResults.clear();
//                                searchResults.addAll(tempList);
//                              });
//                              return;
//                            } else {
//                              setState(() {
//                                searchResults.clear();
//                                searchResults.addAll(categories);
//                              });
//                            }
//                          },
//                        ),
//                      ),
//                      Flexible(
//                        child: ListView.builder(
//
//                          itemCount: searchResults.length,
//                          itemBuilder: (_, index) => Padding(
//                            padding: EdgeInsets.symmetric(vertical: 16.0,),
//                            child: StaggeredCardCard(
//                              begin: searchResults[index].begin,
//                              end: searchResults[index].end,
//                              categoryName: searchResults[index].category,
//                              assetPath: searchResults[index].image,
//                            ),
//                          ),
//                        ),
//                      )
                          Container(
                            margin: const EdgeInsets.only(top: 10,),
                            height: (MediaQuery.of(context).size.width)-64.0,
                            child:Container(

                              height: (MediaQuery.of(context).size.width)-64.0,
                              width: MediaQuery.of(context).size.width-64.0,
                              padding: const EdgeInsets.only(left: 12.0,top: 12.0, right: 12.0),
                              decoration: BoxDecoration(
                                  color: Colors.red[300],
//                border: Border.all(color: Colors.deepPurple,width: 2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),

                              child: Center(
                                child: _isLoading? Center(child: CircularProgressIndicator(backgroundColor:Colors.deepOrange ,)):Column(
                                   mainAxisSize : MainAxisSize.min,
                                  children: [
                                    (image!=null)?Container(width:MediaQuery.of(context).size.width*0.7 ,height:MediaQuery.of(context).size.width*0.7 ,child: FittedBox(fit:BoxFit.cover,child: Image(image: NetworkImage(image)))):null,
//                                Text('Add New ID +',
//                                  textAlign: TextAlign.center,
//
//
//                                  style: TextStyle(
//
//
//                                      color: Colors.white38,
//                                      fontSize: 38.0,
//                                      fontWeight: FontWeight.bold,
//                                      shadows: [
//                                        BoxShadow(
//                                          color: Color.fromRGBO(0, 0, 0, 0.15),
//                                          offset: Offset(0, 5),
//                                          blurRadius: 10.0,
//                                        )
//                                      ]),
//                                ),
                                  ].where(notNull).toList(),
                                ),
                              ),
                            ),



                          ),
                          Spacer(),
                          Container(

                            height: 55.0,
                            width: (MediaQuery.of(context).size.width)*0.85,
                            child: type_of_action=='comment'?new Scrollbar(
                                child: new TextField(
                                  controller: searchController,

                                  maxLines: null,
                                )
                            ):null,
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: ()async{
                                  final SharedPreferences prefs = await _prefs;

                                  var token=prefs.getString('token');
                                  var response=await action(type,pkey,shortcode,media_id,comment,'skip',token);
                                  if (response['status']==200) {

                                    // setState(() {
                                    //   searchController.clear();
                                    // });
                                    asyncMethod();
                                  }
                                  else{
                                    final result=await showOkAlertDialog(context: context,message:'${response['message']}' ,title: '${response['status_message'].replaceAll('-', ' ')}',okLabel: 'Try again',barrierDismissible: false);
                                    // print('hi1');

                                    // print(result==OkCancelResult.ok);
                                    // print(result==OkCancelResult.cancel);
                                    // print('hi2');
                                    if(result==OkCancelResult.ok){
                                      asyncMethod();
                                    }

                                    // showDialog(context: context, builder: (context) {
                                    //   return Dialog(
                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    //     elevation: 16,
                                    //       child:Container(
                                    //         height: 200.0,
                                    //         width: 300.0,
                                    //         child: Center(child: Text('${response['status_message']}')),
                                    //
                                    //       )
                                    //   );
                                    // });
                                  }

                                  // setState(() { });
                                  // asyncMethod();

                                },
                                child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 80,
                                child: Center(
                                    child: new Text("pass",
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
                              InkWell(
                                onTap: ()async{
                                  final SharedPreferences prefs = await _prefs;

                                  var token=prefs.getString('token');
                                  var response=await action(type,pkey,shortcode,media_id,searchController.text,'do',token);
                                  if (response['status']==200) {

                                    // setState(() {
                                    //   searchController.clear();
                                    // });
                                    asyncMethod();
                                  }
                                  else{
                                    final result=await showOkAlertDialog(context: context,message:'${response['message']}' ,title: '${response['status_message'].replaceAll('-', ' ')}',okLabel: 'Try again',barrierDismissible: false);
                                    // print('hi1');

                                    // print(result==OkCancelResult.ok);
                                    // print(result==OkCancelResult.cancel);
                                    // print('hi2');
                                    if(result==OkCancelResult.ok){
                                      asyncMethod();
                                    }

                                    // showDialog(context: context, builder: (context) {
                                    //   return Dialog(
                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    //     elevation: 16,
                                    //       child:Container(
                                    //         height: 200.0,
                                    //         width: 300.0,
                                    //         child: Center(child: Text('${response['status_message']}')),
                                    //
                                    //       )
                                    //   );
                                    // });
                                  }

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: 80,
                                  child: Center(
                                      child: new Text(type_of_action,
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
                            ],
                          ),
                          Spacer(),


                        ],

            ),
                    ),
                  ),
      ),
    );
  }
}

