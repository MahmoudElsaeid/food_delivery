import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/order/order_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int _selectedIndex = 0;

   late PersistentTabController _controller;

   List pages=[
     MainFoodPage(),
     SignInPage(),
     CartHistory(),
     AccountPage()
  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

  }

   List<Widget> _buildScreens() {
     return [
       MainFoodPage(),
       OrderPage(),
       CartHistory(),
       AccountPage(),
     ];
   }

   List<PersistentBottomNavBarItem> _navBarsItems() {
     return [
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.home),
         title: ("Home"),
         activeColorPrimary: AppColors.mainColor,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.archivebox),
         title: ("Archive"),
         activeColorPrimary: AppColors.mainColor,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.shopping_cart),
         title: ("Cart"),
         activeColorPrimary: AppColors.mainColor,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon: Icon(CupertinoIcons.person),
         title: ("me"),
         activeColorPrimary: AppColors.mainColor,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
     ];
   }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,

        unselectedItemColor: Colors.black26,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            title: Text('History')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            title: Text('Cart')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            title: Text('me')
          ),
        ],
      ),
    );
  }*/
   @override
   Widget build(BuildContext context) {
     return PersistentTabView(
       context,
       controller: _controller,
       screens: _buildScreens(),
       items: _navBarsItems(),
       confineInSafeArea: true,
       backgroundColor: Colors.white, // Default is Colors.white.
       handleAndroidBackButtonPress: true, // Default is true.
       resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
       stateManagement: true, // Default is true.
       hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
       decoration: NavBarDecoration(
         borderRadius: BorderRadius.circular(10.0),
         colorBehindNavBar: Colors.white,
       ),
       popAllScreensOnTapOfSelectedTab: true,
       popActionScreens: PopActionScreensType.all,
       itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
         duration: Duration(milliseconds: 200),
         curve: Curves.ease,
       ),
       screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
         animateTabTransition: true,
         curve: Curves.ease,
         duration: Duration(milliseconds: 200),
       ),
       navBarStyle: NavBarStyle.style14, // Choose the nav bar style with this property.
     );
   }
}