import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/screen/fragment/HomeFragment.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  List<String> searchStrings = [];

  final _controller = TextEditingController();

  void getSearchSuggestion(String query) async {
    http.Response response = await http.get(Uri.parse(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$query&format=5&alt=json&gl=in"));

    List<dynamic> list = jsonDecode(response.body)[1];

    searchStrings.clear();

    for (var element in list) {
      searchStrings.add(element[0]);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 10,
        elevation: 0,
        title: SizedBox(
          height: 35,
          child: TextField(
            controller: _controller,
            maxLines: 1,
            textAlign: TextAlign.start,
            cursorHeight: 25,
            cursorWidth: 1,
            cursorColor: const Color.fromRGBO(204, 0, 0, 1),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 5),
                filled: true,
                fillColor: Colors.black12,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    _controller.clear();
                    setState((){
                      searchStrings.clear();
                    });
                  },
                ),
                hintText: 'Search YouTube',
                border: InputBorder.none),
            onChanged: (str) {
              getSearchSuggestion(str);
            },
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              if(value.trim() != "")
                {
                  Navigator.pop(context,value.toString());
                }
            },
            style: const TextStyle(
                color: Colors.black, fontSize: 14, height: 1.5 //Add this
                ),
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For IOS (dark icons)
        ),
      ),
      body: ListView.builder(
          itemCount: searchStrings.length > 10 ? 10 : searchStrings.length,
          itemBuilder: (context, pos) {
            return ListTile(
              onTap: (){
                Navigator.pop(context,searchStrings[pos]);
              },
              leading: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              title: Text(
                searchStrings[pos],
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                  onPressed: () {
                    _controller.value = TextEditingValue(
                      text: searchStrings[pos],
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: searchStrings[pos].length),
                      ),
                    );

                    getSearchSuggestion(searchStrings[pos]);
                  },
                  icon: const Icon(
                    Icons.arrow_upward,
                    color: Colors.black,
                  )),
            );
          }),
    );
  }
}
