import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LibraryFragment extends StatefulWidget {
  const LibraryFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LibraryFragment();
}

class _LibraryFragment extends State<LibraryFragment> {
  var isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/ic_youtube_name.png",
            width: 120,
          ),
          titleSpacing: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.cast, color: Colors.black)),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  // startSearchScreen();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/ic_user.jpg'),
                radius: 50,
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For IOS (dark icons)
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Center(
                child: Text("Library"),
              ));
  }
}
