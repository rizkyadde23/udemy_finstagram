import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _homePageState();
  }
  const HomePage({super.key});
}

class _homePageState extends State<HomePage>{
  int selectedIndex = 0;
  final List<Widget> _pages = [
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
  ]; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("FINSTAGRAM", style: TextStyle(fontWeight: FontWeight.w600),),
        actions: [
          GestureDetector(
            onTap: () {
              
            },
            child: Icon(Icons.camera_alt_sharp),
          ),
          Padding(padding: EdgeInsetsGeometry.only(left: 8,right: 8)),
          GestureDetector(
            onTap: () {
              
            },
            child: Icon(Icons.logout_outlined),
          ),
          Padding(padding: EdgeInsetsGeometry.only(right: 8)),
        ],
      ),
      bottomNavigationBar: _bottomNavBar(),
      body: _pages[selectedIndex],
    ); 
  }

  Widget _bottomNavBar(){
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: "Feed",
          icon: Icon(Icons.feed)
          ),
          BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.account_box)
          ),
      ]
      );
  }
}