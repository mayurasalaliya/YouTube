import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/model/VideoModel.dart';
import 'package:youtube/model/YoutubeVideo.dart';
import 'package:youtube/screen/VideoViewScreen.dart';

import '../../model/ChannelSnippet.dart';
import '../../model/VideoSnippet.dart';
import '../../util/Utils.dart';
import '../SearchScreen.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeFragment();
}

class _HomeFragment extends State<HomeFragment> {
  static String key = "YOUR_API_KEY";

  var isLoading = true;

  String videoIds = "";
  String channelIds = "";

  VideoModel? videoModel;
  VideoSnippet? videoSnippet;
  ChannelSnippet? channelSnippet;

  Map<String, ChannelItems> channelThumb = {};
  Map<String, VideoSnippetItems> videoView = {};

  Future<void> callAPI(String searchQuery) async {
    setState(() {
      isLoading = true;
    });

    http.Response response = await http.get(
        Uri.parse(
            "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$searchQuery&type=video&maxResults=40&key=$key"),
        headers: {"Accept": "application/json"});

    videoModel = VideoModel.fromJson(jsonDecode(response.body));

    videoIds = "";
    channelIds = "";

    for (VideoItems video in videoModel!.items!) {
      videoIds += "${video.id!.videoId},";
      channelIds += "${video.snippet!.channelId!},";
    }

    response = await http.get(
        Uri.parse(
            "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=$videoIds&key=$key"),
        headers: {"Accept": "application/json"});

    videoSnippet = VideoSnippet.fromJson(jsonDecode(response.body));

    videoView.clear();

    for (VideoSnippetItems video in videoSnippet!.items!) {
      videoView[video.id!] = video;
    }

    response = await http.get(
        Uri.parse(
            "https://www.googleapis.com/youtube/v3/channels?part=snippet,statistics&id=$channelIds&key=$key"),
        headers: {"Accept": "application/json"});

    channelSnippet = ChannelSnippet.fromJson(jsonDecode(response.body));

    channelThumb.clear();

    for (ChannelItems video in channelSnippet!.items!) {
      channelThumb[video.id!] = video;
    }

    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    callAPI("salman khan songs");

    print("Home initState");

    super.initState();
  }

  searchQuery(String str) {
    callAPI(str);
  }

  startSearchScreen() async{
    final query = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));

    print(query);
    if(query != null && query != "") {
      callAPI(query.toString());
    }

  }

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
                      startSearchScreen();
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
                : ListView.builder(
              itemCount: videoModel!.items!.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<String>(
                            builder: (context) => VideoViewScreen(
                                videoModel!.items![index].id!.videoId!),
                            settings: RouteSettings(
                                arguments: YoutubeVideo(
                                    videoModel!.items![index],
                                    videoView[
                                        videoModel!.items![index].id!.videoId],
                                    channelThumb[videoModel!
                                        .items![index].snippet!.channelId!]))),
                      );
                    },
                    child: Utils.getVideoCard(
                        videoModel!
                            .items![index].snippet!.thumbnails!.high!.url!,
                        videoView[videoModel!.items![index].id!.videoId!]!
                            .contentDetails!
                            .duration!,
                        channelThumb[
                                videoModel!.items![index].snippet!.channelId!]!
                            .snippet!
                            .thumbnails!
                            .small!
                            .url!,
                        videoModel!.items![index].snippet!.title!,
                        videoModel!.items![index].snippet!.channelTitle!,
                        videoView[videoModel!.items![index].id!.videoId!]!
                            .statistics!
                            .viewCount!,
                        videoModel!.items![index].snippet!.publishedAt!,
                        videoModel!
                            .items![index].snippet!.liveBroadcastContent!));
              },
            ));
  }
}
