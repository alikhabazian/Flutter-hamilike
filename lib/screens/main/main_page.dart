import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:repeat_mehrdadproject/app_properties.dart';
import 'package:repeat_mehrdadproject/custom_background.dart';
// import 'package:repeat_mehrdadproject/models/product.dart';
import 'package:repeat_mehrdadproject/screens/category/category_list_page.dart';
// import 'package:repeat_mehrdadproject/screens/notifications_page.dart';
import 'package:repeat_mehrdadproject/screens/profile_page.dart';
// import 'package:repeat_mehrdadproject/screens/search_page.dart';
// import 'package:repeat_mehrdadproject/screens/shop/check_out_page.dart';
// import 'package:repeat_mehrdadproject/screens/tracking_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:repeat_mehrdadproject/Custom_bottomBar.dart';
//import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';
import 'components/tab_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:repeat_mehrdadproject/screens/auth/welcome_back_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';




import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> get_profile ( String token) async {
  var url = 'https://fiberfake.neolyze.com/api/v2/auth/profile';
//  var body = jsonEncode({
//    "username": username,
//    "password": password,
//    "api_type": "app",
//    "pkey": ""
//  });

  //print("Body: " + body);

  var response = await http.get(Uri.parse(url),
      headers: {"accept": "application/json","Content-Type": "application/json-patch+json","Authorization":token},
//      body: body
  );
  print(response.body);
  return json.decode(response.body);
}








class MainPage extends StatefulWidget {
  final int indexx;
  final ImageProvider image_prof;
  final String username;
  final String img_url;
  const MainPage(
      {Key key, this.image_prof, this.username,this.img_url,this.indexx})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();


}

List<String> timelines = ['Weekly featured', 'Best of June', 'Best of 2018'];
String selectedTimeline = 'Weekly featured';

// List<Product> products = [
//   Product(
//       'assets/headphones_2.png',
//       'Skullcandy headset L325',
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
//       102.99),
//   Product(
//       'assets/headphones_3.png',
//       'Skullcandy headset X25',
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
//       55.99),
//   Product(
//       'assets/headphones.png',
//       'Blackzy PRO hedphones M003',
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
//       152.99),
// ];

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  bool check_is_any_true=false;
  bool _isLoading = true;
  String mobile="";
  int coin=2;
  int index_dashbord=0;//main
  SwiperController swiperController;
  TabController tabController;
  TabController bottomTabController;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();



  void reset_index(){
    setState(() {
      index_dashbord=0;
    });

  }

  void asyncMethod() async {
    final SharedPreferences prefs = await _prefs;

    var token=prefs.getString('token');
    var response=await get_profile(token);
    coin=response["data"]["coin"]["coin"];
    mobile=response["data"]["mobile"];






    // ....
  }

  @override
  void initState() {


    super.initState();
    setState(() { });




    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(initialIndex:2,length: 4, vsync: this);
    dataLoadFunction();

  }

  dataLoadFunction()async {
    setState(() {
      _isLoading = true; // your loader has started to load
    });
    final SharedPreferences prefs = await _prefs;

    var token=prefs.getString('token');
    var response=await get_profile(token);
    coin=response["data"]["coin"]["coin"];
    mobile=response["data"]["mobile"];


    var accounts=response["data"]["accounts"];
    print('here');
    print(accounts);
    print(accounts.length);
    check_is_any_true=false;
    for(int i=0;i<accounts.length;i++){
      print(accounts[i]["allow_action"]);
      check_is_any_true=check_is_any_true||accounts[i]["allow_action"];
    }
    print(check_is_any_true);

    print('here');


    setState(() {
      _isLoading = false; // your loder will stop to finish after the data fetch
    });

  }
  void callback() {
    print('g');
    this.dataLoadFunction();
  }


  @override
  void setState(fn)async {
    // await asyncMethod();
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    var usrnames;
    // Widget appBar = Container(
    //   height: kToolbarHeight + MediaQuery.of(context).padding.top,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       IconButton( onPressed: () => Navigator.of(context)
    //               .push(MaterialPageRoute(builder: (_) => NotificationsPage())),
    //           icon: Icon(Icons.notifications)),
    //       IconButton(
    //           onPressed: () => Navigator.of(context)
    //               .push(MaterialPageRoute(builder: (_) => SearchPage())),
    //           icon: SvgPicture.asset('assets/icons/search_icon.svg'))
    //     ],
    //   ),
    // );

    // Widget topHeader = Padding(
    //     padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: <Widget>[
    //         Flexible(
    //           child: InkWell(
    //             onTap: () {
    //               setState(() {
    //                 selectedTimeline = timelines[0];
    //                 products = [
    //                   Product(
    //                       'assets/headphones_2.png',
    //                       'Skullcandy headset L325',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       102.99),
    //                   Product(
    //                       'assets/headphones_3.png',
    //                       'Skullcandy headset X25',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       55.99),
    //                   Product(
    //                       'assets/headphones.png',
    //                       'Blackzy PRO hedphones M003',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       152.99),
    //                 ];
    //               });
    //             },
    //             child: Text(
    //               timelines[0],
    //               style: TextStyle(
    //                   fontSize: timelines[0] == selectedTimeline ? 20 : 14,
    //                   color: darkGrey),
    //             ),
    //           ),
    //         ),
    //         Flexible(
    //           child: InkWell(
    //             onTap: () {
    //               setState(() {
    //                 selectedTimeline = timelines[1];
    //                 products = [
    //                   Product(
    //                       'assets/bag_5.png',
    //                       'Skullcandy headset L325',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       102.99),
    //                   Product(
    //                       'assets/bag_6.png',
    //                       'Skullcandy headset X25',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       55.99),
    //                   Product(
    //                       'assets/bag_3.png',
    //                       'Blackzy PRO hedphones M003',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       152.99),
    //                 ];
    //               });
    //             },
    //             child: Text(timelines[1],
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontSize: timelines[1] == selectedTimeline ? 20 : 14,
    //                     color: darkGrey)),
    //           ),
    //         ),
    //         Flexible(
    //           child: InkWell(
    //             onTap: () {
    //               setState(() {
    //                 selectedTimeline = timelines[2];
    //                 products = [
    //                   Product(
    //                       'assets/headphone_13.png',
    //                       'Skullcandy headset L325',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       102.99),
    //                   Product(
    //                       'assets/jeans_4.png',
    //                       'Skullcandy headset X25',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       55.99),
    //                   Product(
    //                       'assets/ring_7.png',
    //                       'Blackzy PRO hedphones M003',
    //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //                       152.99),
    //                 ];
    //               });
    //             },
    //             child: Text(timelines[2],
    //                 textAlign: TextAlign.right,
    //                 style: TextStyle(
    //                     fontSize: timelines[2] == selectedTimeline ? 20 : 14,
    //                     color: darkGrey)),
    //           ),
    //         ),
    //       ],
    //     ));

    Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'Trending'),
        Tab(text: 'Sports'),
        Tab(text: 'Headsets'),
        Tab(text: 'Wireless'),
        Tab(text: 'Bluetooth'),
      ],
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
    );

    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,

        resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomPadding: false,

//      bottomNavigationBar: ,
        body: _isLoading? Center(child: CircularProgressIndicator(backgroundColor:Colors.deepOrange ,)):CustomPaint(
          // painter: MainBackground(),

          child: Stack(
            children: [

            TabBarView(
              controller: bottomTabController,
              physics: NeverScrollableScrollPhysics(),

              children: <Widget>[

//
//            CategoryListPage(),
                ProfilePage(),
                SafeArea(

                  child: Column(

                    children: [
                      Spacer(flex: 1),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 16.0, right: 16.0),child:Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 75,
                            backgroundImage: widget.image_prof ,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${mobile}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                        ,),
                      Spacer(flex: 1),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 16.0, right: 16.0),
                        child:
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width*0.5,
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          decoration: BoxDecoration(
//                          color: Color.fromRGBO(255, 255, 255, 0.05),

                              border: Border.all(color: Colors.deepPurple,width: 2),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Center(child: Row(
                            mainAxisAlignment : MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on_outlined,color: Colors.deepPurple,),
//                          Text('You have $coin coin'),
                              RichText(text: TextSpan(
                                  children: [
                                    TextSpan(text:'You have ',style: TextStyle(color:Colors.black )),
                                    TextSpan(text:'$coin ',style: TextStyle(color:Colors.deepOrangeAccent )),
                                    TextSpan(text:'coin',style: TextStyle(color:Colors.black )),
                                  ]
                              ))
                            ],
                          )),
                        )
                        ,),
                      Spacer(flex:2),

                      Row(
//                              mainAxisSize : MainAxisSize.min,
                        mainAxisAlignment : MainAxisAlignment.spaceEvenly,
//                              crossAxisAlignment : CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){},
                            child: Container(
                              height: MediaQuery.of(context).size.width/3.5,
                              width: MediaQuery.of(context).size.width/3.5,
                              padding: const EdgeInsets.only(left: 5.0, right:5.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.2),
                                  border: Border.all(color: Colors.black,width: 2),
                                  //                border: Border.all(color: Colors.deepPurple,width: 2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment :MainAxisAlignment.spaceEvenly,
                                children: [

                                  Icon(Icons.calculate,size:  MediaQuery.of(context).size.width/10,),
                                  FittedBox(fit: BoxFit.fitWidth, child: AutoSizeText('Accounting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(


//                             onTap: (){
//                               index_dashbord=2;//follow pages
//                               setState(() {
//
//                               });
// //                            Navigator.of(context)
// //                                .push(MaterialPageRoute(builder: (_) => CategoryListPage()));
//
//
//                             },
                            child: Container(
                              height: MediaQuery.of(context).size.width/3.5,
                              width: MediaQuery.of(context).size.width/3.5,
                              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.2),
                                  border: Border.all(color: Colors.black,width: 2),
                                  //                border: Border.all(color: Colors.deepPurple,width: 2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment :MainAxisAlignment.spaceEvenly,

                                children: [

                                  Icon(Icons.supervisor_account_rounded,size:  MediaQuery.of(context).size.width/10,),

                                  FittedBox(fit: BoxFit.fitWidth, child:AutoSizeText('Accounts',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1)),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      Spacer(flex: 2),
                      Row(
                        mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width/3.5,
                            width: MediaQuery.of(context).size.width/3.5,
                            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                border: Border.all(color: Colors.black,width: 2),
                                //                border: Border.all(color: Colors.deepPurple,width: 2),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                            child: Column(
                              mainAxisAlignment :MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.monetization_on_outlined,size:  MediaQuery.of(context).size.width/10,),
                                FittedBox(fit: BoxFit.fitWidth, child:AutoSizeText('Buy coin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1)),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width/3.5,
                            width: MediaQuery.of(context).size.width/3.5,
                            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                            decoration: BoxDecoration(


                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                border: Border.all(color: Colors.black,width: 2),
                                //                border: Border.all(color: Colors.deepPurple,width: 2),
                                borderRadius: BorderRadius.only(

                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                            child: Column(
                              mainAxisAlignment :MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.info_outline_rounded,size:  MediaQuery.of(context).size.width/10,),
                                FittedBox(fit: BoxFit.fitWidth, child:AutoSizeText('Information',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1,)),
                              ],
                            ),),
                        ],
                      ),


                      Spacer(flex: 5  ),
                    ],
                  ),
//              child: NestedScrollView(
//                headerSliverBuilder:
//                    (BuildContext context, bool innerBoxIsScrolled) {
//                  // These are the slivers that show up in the "outer" scroll view.
//                  return <Widget>[
//                    SliverToBoxAdapter(
//                      child:Padding(
//                      padding:
//                      EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),child:Column(
//                      children: [
//                        CircleAvatar(
//                          maxRadius: 48,
//                          backgroundImage: AssetImage('assets/background.jpg'),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text(
//                            'Rose Helbert',
//                            style: TextStyle(fontWeight: FontWeight.bold),
//                          ),
//                        ),
//                      ],
//                    )
//                      ,)
//                      ,),
//                    SliverToBoxAdapter(
//                      child:Center(
//                        child: Column(
//
//                          children: [
//                            Row(
//                              mainAxisAlignment : MainAxisAlignment.center,
//                              children: [
//                                Container(
//                              height: MediaQuery.of(context).size.width/4,
//                              width: MediaQuery.of(context).size.width/4,
//                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                              decoration: BoxDecoration(
//                              color: Color.fromRGBO(255, 255, 255, 0.2),
//        //                border: Border.all(color: Colors.deepPurple,width: 2),
//                              borderRadius: BorderRadius.only(
//                              topLeft: Radius.circular(10),
//                              bottomLeft: Radius.circular(10),
//                              bottomRight: Radius.circular(10),
//                              topRight: Radius.circular(10),
//                              )),
//                                child: Icon(Icons.favorite),
//                                ),
//                                Container(
//                                  height: MediaQuery.of(context).size.width/4,
//                                  width: MediaQuery.of(context).size.width/4,
//                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                                  decoration: BoxDecoration(
//                                      color: Color.fromRGBO(255, 255, 255, 0.2),
//                                      //                border: Border.all(color: Colors.deepPurple,width: 2),
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(10),
//                                        bottomLeft: Radius.circular(10),
//                                        bottomRight: Radius.circular(10),
//                                        topRight: Radius.circular(10),
//                                      )),
//                                  child: Icon(Icons.quick_contacts_dialer),
//                                ),
//
//                      ],
//                            ),
//                            Row(
//                              mainAxisAlignment : MainAxisAlignment.center,
//                              children: [
//                                Container(
//                                  height: MediaQuery.of(context).size.width/4,
//                                  width: MediaQuery.of(context).size.width/4,
//                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                                  decoration: BoxDecoration(
//                                      color: Color.fromRGBO(255, 255, 255, 0.2),
//                                      //                border: Border.all(color: Colors.deepPurple,width: 2),
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(10),
//                                        bottomLeft: Radius.circular(10),
//                                        bottomRight: Radius.circular(10),
//                                        topRight: Radius.circular(10),
//                                      )),
//                                  child: Icon(Icons.av_timer_rounded),
//                                ),
//                                Container(
//                                  height: MediaQuery.of(context).size.width/4,
//                                  width: MediaQuery.of(context).size.width/4,
//                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                                  decoration: BoxDecoration(
//                                      color: Color.fromRGBO(255, 255, 255, 0.2),
//                                      //                border: Border.all(color: Colors.deepPurple,width: 2),
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(10),
//                                        bottomLeft: Radius.circular(10),
//                                        bottomRight: Radius.circular(10),
//                                        topRight: Radius.circular(10),
//                                      )),
//                                  child: Icon(Icons.live_tv_rounded),),
//                              ],
//                            ),
//                          ],
//                        ),
//                      )
//                      ,),
//
////                    SliverToBoxAdapter(
////                      child: appBar,
////                    ),
////                    SliverToBoxAdapter(
////                      child: topHeader,
////                    ),
////                    SliverToBoxAdapter(
////                      child: ProductList(
////                        products: products,
////                      ),
////                    ),
////                    SliverToBoxAdapter(
////                      child: tabBar,
////                    )
//                  ];
//                },
//                body: TabView(
//                  tabController: tabController,
//                ),
//              ),

                ),
                [SafeArea(

                  child: Column(

                    children: [
                      Spacer(flex: 1),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 16.0, right: 16.0),child:Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 75,
                            backgroundImage: widget.image_prof ,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${mobile}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                        ,),
                      Spacer(flex: 1),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 16.0, right: 16.0),
                        child:
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width*0.5,
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          decoration: BoxDecoration(
//                          color: Color.fromRGBO(255, 255, 255, 0.05),
                              border: Border.all(color: Colors.deepPurple,width: 2),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Center(child: Row(
                            mainAxisAlignment : MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on_outlined,color: Colors.deepPurple,),
//                          Text('You have $coin coin'),
                              RichText(text: TextSpan(
                                  children: [
                                    TextSpan(text:'You have ',style: TextStyle(color:Colors.black )),
                                    TextSpan(text:'$coin ',style: TextStyle(color:Colors.deepOrangeAccent )),
                                    TextSpan(text:'coin',style: TextStyle(color:Colors.black )),
                                  ]
                              ))
                            ],
                          )),
                        )
                        ,),
                      Spacer(flex:2),

                      Row(
//                              mainAxisSize : MainAxisSize.min,
                        mainAxisAlignment : MainAxisAlignment.spaceEvenly,
//                              crossAxisAlignment : CrossAxisAlignment.start,
                        children: [

                          InkWell(



                            onTap: null,
                            child: Container(

                              height: MediaQuery.of(context).size.width/3.5,
                              width: MediaQuery.of(context).size.width/3.5,
                              padding: const EdgeInsets.only(left: 5.0, right:5.0),
                              decoration: BoxDecoration(

                                  color: Color.fromRGBO(255, 255, 255, 0.2),
                                 border: Border.all(color: Colors.black,width: 2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment :MainAxisAlignment.spaceEvenly,
                                children: [

                                  Icon(Icons.favorite,size:  MediaQuery.of(context).size.width/10,color: Colors.black12,),
                                  FittedBox(fit: BoxFit.fitWidth, child: AutoSizeText('Make like',style: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(


                            onTap: (){
                              if(check_is_any_true){
                                index_dashbord=2;//follow pages
                                setState(() {

                                });

                              }
                              else{
                                showOkAlertDialog(context:context, title: "All your page can't do actions",message: "Go to the settings and check \"Enable allow action with this account \" then save this or you aren't add any Instagram page");
                              }

//                            Navigator.of(context)
//                                .push(MaterialPageRoute(builder: (_) => CategoryListPage()));


                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width/3.5,
                              width: MediaQuery.of(context).size.width/3.5,
                              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.2),
                                  border: Border.all(color: Colors.black,width: 2),
                                  //                border: Border.all(color: Colors.deepPurple,width: 2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment :MainAxisAlignment.spaceEvenly,

                                children: [

                                  Icon(Icons.quick_contacts_dialer,size:  MediaQuery.of(context).size.width/10,),

                                  FittedBox(fit: BoxFit.fitWidth, child:AutoSizeText('Follow pages',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1)),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      Spacer(flex: 2),
                      Row(
                        mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width/3.5,
                            width: MediaQuery.of(context).size.width/3.5,
                            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                                // color: Color.fromRGBO(255, 255, 255, 0.2),
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                border: Border.all(color: Colors.black,width: 2),
                                //                border: Border.all(color: Colors.deepPurple,width: 2),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                            child: Column(
                              mainAxisAlignment :MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.av_timer_rounded,size:  MediaQuery.of(context).size.width/10,color: Colors.black12,),
                                FittedBox(fit: BoxFit.fitWidth, child:AutoSizeText('See story',style: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1)),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width/3.5,
                            width: MediaQuery.of(context).size.width/3.5,
                            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                            decoration: BoxDecoration(


                                // color: Color.fromRGBO(255, 255, 255, 0.2),
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                border: Border.all(color: Colors.black,width: 2),
                                //                border: Border.all(color: Colors.deepPurple,width: 2),
                                borderRadius: BorderRadius.only(

                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                            child: Column(
                              mainAxisAlignment :MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.live_tv_rounded,size:  MediaQuery.of(context).size.width/10,color: Colors.black12,),
                                FittedBox(fit: BoxFit.fitWidth, child:AutoSizeText('Join live',style: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1,)),
                              ],
                            ),),
                        ],
                      ),


                      Spacer(flex: 5  ),
                    ],
                  ),
//              child: NestedScrollView(
//                headerSliverBuilder:
//                    (BuildContext context, bool innerBoxIsScrolled) {
//                  // These are the slivers that show up in the "outer" scroll view.
//                  return <Widget>[
//                    SliverToBoxAdapter(
//                      child:Padding(
//                      padding:
//                      EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),child:Column(
//                      children: [
//                        CircleAvatar(
//                          maxRadius: 48,
//                          backgroundImage: AssetImage('assets/background.jpg'),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text(
//                            'Rose Helbert',
//                            style: TextStyle(fontWeight: FontWeight.bold),
//                          ),
//                        ),
//                      ],
//                    )
//                      ,)
//                      ,),
//                    SliverToBoxAdapter(
//                      child:Center(
//                        child: Column(
//
//                          children: [
//                            Row(
//                              mainAxisAlignment : MainAxisAlignment.center,
//                              children: [
//                                Container(
//                              height: MediaQuery.of(context).size.width/4,
//                              width: MediaQuery.of(context).size.width/4,
//                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                              decoration: BoxDecoration(
//                              color: Color.fromRGBO(255, 255, 255, 0.2),
//        //                border: Border.all(color: Colors.deepPurple,width: 2),
//                              borderRadius: BorderRadius.only(
//                              topLeft: Radius.circular(10),
//                              bottomLeft: Radius.circular(10),
//                              bottomRight: Radius.circular(10),
//                              topRight: Radius.circular(10),
//                              )),
//                                child: Icon(Icons.favorite),
//                                ),
//                                Container(
//                                  height: MediaQuery.of(context).size.width/4,
//                                  width: MediaQuery.of(context).size.width/4,
//                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                                  decoration: BoxDecoration(
//                                      color: Color.fromRGBO(255, 255, 255, 0.2),
//                                      //                border: Border.all(color: Colors.deepPurple,width: 2),
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(10),
//                                        bottomLeft: Radius.circular(10),
//                                        bottomRight: Radius.circular(10),
//                                        topRight: Radius.circular(10),
//                                      )),
//                                  child: Icon(Icons.quick_contacts_dialer),
//                                ),
//
//                      ],
//                            ),
//                            Row(
//                              mainAxisAlignment : MainAxisAlignment.center,
//                              children: [
//                                Container(
//                                  height: MediaQuery.of(context).size.width/4,
//                                  width: MediaQuery.of(context).size.width/4,
//                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                                  decoration: BoxDecoration(
//                                      color: Color.fromRGBO(255, 255, 255, 0.2),
//                                      //                border: Border.all(color: Colors.deepPurple,width: 2),
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(10),
//                                        bottomLeft: Radius.circular(10),
//                                        bottomRight: Radius.circular(10),
//                                        topRight: Radius.circular(10),
//                                      )),
//                                  child: Icon(Icons.av_timer_rounded),
//                                ),
//                                Container(
//                                  height: MediaQuery.of(context).size.width/4,
//                                  width: MediaQuery.of(context).size.width/4,
//                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//                                  decoration: BoxDecoration(
//                                      color: Color.fromRGBO(255, 255, 255, 0.2),
//                                      //                border: Border.all(color: Colors.deepPurple,width: 2),
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(10),
//                                        bottomLeft: Radius.circular(10),
//                                        bottomRight: Radius.circular(10),
//                                        topRight: Radius.circular(10),
//                                      )),
//                                  child: Icon(Icons.live_tv_rounded),),
//                              ],
//                            ),
//                          ],
//                        ),
//                      )
//                      ,),
//
////                    SliverToBoxAdapter(
////                      child: appBar,
////                    ),
////                    SliverToBoxAdapter(
////                      child: topHeader,
////                    ),
////                    SliverToBoxAdapter(
////                      child: ProductList(
////                        products: products,
////                      ),
////                    ),
////                    SliverToBoxAdapter(
////                      child: tabBar,
////                    )
//                  ];
//                },
//                body: TabView(
//                  tabController: tabController,
//                ),
//              ),

                ),CategoryListPage(reset_index),CategoryListPage(reset_index)][index_dashbord],
                WelcomeBackPage(),

              ],
            ),
              CustomBottomBar(callback: this.callback,controller: bottomTabController,prof_img: widget.image_prof,prof_img_url: widget.img_url,),
//            (click_prof)?Positioned(
//                bottom:10,
//                right:10 ,
//
//
//                child:Container(
//                  height: MediaQuery.of(context).size.height/7,
//                  child:Container(
//                    height: 160,
//                    width: MediaQuery.of(context).size.width/4,
//                    padding: const EdgeInsets.only(left: 32.0, right: 12.0),
//                    decoration: BoxDecoration(
//                        color: Color.fromRGBO(255, 255, 255, 1),
////                border: Border.all(color: Colors.deepPurple,width: 2),
//                        borderRadius: BorderRadius.only(
//                          topLeft: Radius.circular(10),
//                          bottomLeft: Radius.circular(10),
//                          bottomRight: Radius.circular(10),
//                          topRight: Radius.circular(10),
//                        )),
//
//                    child: Center(
//                      child: Text('Add New ID +',
//                        textAlign: TextAlign.center,
//
//
//                        style: TextStyle(
//
//
//                            color: Colors.white38,
//                            fontSize: 10.0,
//                            fontWeight: FontWeight.bold,
//                            shadows: [
//                              BoxShadow(
//                                color: Color.fromRGBO(0, 0, 0, 0.15),
//                                offset: Offset(0, 5),
//                                blurRadius: 10.0,
//                              )
//                            ]),
//                      ),
//                    ),
//                  ),
//
//
//
//                )
//            ):null
//            ,
            ],
          ),
        ),
      ),
    );
  }
}
