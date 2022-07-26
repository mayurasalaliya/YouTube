import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:youtube/screen/fragment/HomeFragment.dart';
import 'package:youtube/screen/fragment/LibraryFragment.dart';
import 'package:youtube/screen/fragment/SubscriptionsFragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  final ListQueue<int> _navigationQueue = ListQueue();

  var selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    SubscriptionsFragment(),
    LibraryFragment()
  ];

  Widget getBottomSheetElement(String name, IconData icons) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    icons,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          )),
    );
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: ctx,
        builder: (ctx) => Container(
            width: double.infinity,
            height: 250,
            color: Colors.white54,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Create",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                getBottomSheetElement(
                    "Create a Short", Icons.slow_motion_video_outlined),
                getBottomSheetElement("Upload a video", Icons.upload),
                getBottomSheetElement("Go live", Icons.live_tv),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 10,
            selectedItemColor: Colors.black,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            onTap: (index) {
              if(index != selectedIndex){
                _navigationQueue.removeWhere((element) => element == index);
                _navigationQueue.addLast(index);
                setState(() {
                  selectedIndex = index;
                });
              }
              setState(() {
                if (index == 2) {
                  _show(context);
                } else {
                  selectedIndex = index;
                }
              });
            },
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.slow_motion_video_outlined),
                  label: "Shorts"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline), label: "Create"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.subscriptions_outlined),
                  label: "Subscriptions"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_library_outlined), label: "Library"),
            ],
          ),
          body: Stack(
            children: [
              Offstage(
                offstage: selectedIndex != 0,
                child: TickerMode(
                    enabled: selectedIndex == 0, child: _widgetOptions[0]),
              ),
              Offstage(
                offstage: selectedIndex != 3,
                child: TickerMode(
                    enabled: selectedIndex == 3, child: _widgetOptions[1]),
              ),
              Offstage(
                offstage: selectedIndex != 4,
                child: TickerMode(
                    enabled: selectedIndex == 4, child: _widgetOptions[2]),
              )
            ],
          ),
        ),
        onWillPop: () async {
          if (_navigationQueue.isEmpty) return true;
          setState(() {
            _navigationQueue.removeLast();
            int position = _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
            selectedIndex = position;
          });
          return false;
        });
  }
}
