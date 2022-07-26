import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube/model/VideoModel.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../model/ChannelSnippet.dart';
import '../model/VideoSnippet.dart';
import '../model/YoutubeVideo.dart';
import '../util/Utils.dart';
import 'package:html/parser.dart' show parse;

YoutubeVideo? data;

class VideoViewScreen extends StatefulWidget {
  String? videoId;

  VideoViewScreen(this.videoId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoViewScreen();
}

class _VideoViewScreen extends State<VideoViewScreen> {
  static String key = "YOUR_API_KEY";

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  YoutubePlayerController? _ytbPlayerController;

  var isLoading = true;
  var isVisible = true;

  String videoIds = "";
  String channelIds = "";

  VideoModel? videoModel;
  VideoSnippet? videoSnippet;
  ChannelSnippet? channelSnippet;

  List<VideoItems> videoItems = [];

  Map<String, ChannelItems> channelThumb = {};
  Map<String, VideoSnippetItems> videoView = {};

  Future<void> callAPI(String relatedVideoId) async {
    setState(() {
      isLoading = true;
    });

    http.Response response = await http.get(
        Uri.parse(
            "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=40&relatedToVideoId=$relatedVideoId&key=$key"),
        headers: {"Accept": "application/json"});

    videoModel = VideoModel.fromJson(jsonDecode(parse(response.body).body!.text));

    log("search: ${response.statusCode}");

    for (VideoItems video in videoModel!.items!) {
      if (video.snippet != null) {
        videoItems.add(video);
        videoIds += "${video.id!.videoId},";
        channelIds += "${video.snippet!.channelId!},";
      }
    }

    response = await http.get(
        Uri.parse(
            "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=$videoIds&key=$key"),
        headers: {"Accept": "application/json"});

    log("video: ${response.statusCode}");

    videoSnippet = VideoSnippet.fromJson(jsonDecode(parse(response.body).body!.text));

    for (VideoSnippetItems video in videoSnippet!.items!) {
      videoView[video.id!] = video;
    }

    response = await http.get(
        Uri.parse(
            "https://www.googleapis.com/youtube/v3/channels?part=snippet,statistics&id=$channelIds&key=$key"),
        headers: {"Accept": "application/json"});

    log("channels: ${response.statusCode}");

    channelSnippet = ChannelSnippet.fromJson(jsonDecode(parse(response.body).body!.text));

    for (ChannelItems video in channelSnippet!.items!) {
      channelThumb[video.id!] = video;
    }

    setState(() {
      isLoading = false;
    });
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController!.close();
  }

  @override
  void initState() {
    super.initState();

    callAPI(widget.videoId!);

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController = YoutubePlayerController(
      initialVideoId: widget.videoId!,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
        autoPlay: true,
      ),
    );
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 0,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        clipBehavior: Clip.antiAlias,
        context: ctx,
        builder: (ctx) => DraggableScrollableSheet(
            initialChildSize: 0.68,
            //set this as you want
            maxChildSize: 0.97,
            //set this as you want
            minChildSize: 0,
            //set this as you want
            expand: false,
            controller: DraggableScrollableController(),
            builder: (context, scrollController) {
              return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 3,
                              width: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60))),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.clear,
                                          size: 30,
                                        ))
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        parse(data!.videoItems!.snippet!.title!).body!.text,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {},
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(50.0),
                                                child: Image.network(
                                                  data!.channelSnippet!.snippet!
                                                      .thumbnails!.small!.url!,
                                                  fit: BoxFit.cover,
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data!.videoItems!.snippet!
                                                .channelTitle!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        Utils.convertToReadable(data!
                                            .videoSnippet!
                                            .statistics!
                                            .likeCount!),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Text(
                                        "Likes",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        intl.NumberFormat.decimalPattern().format(
                                            double.parse(data!.videoSnippet!
                                                .statistics!.viewCount!)),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Text(
                                        "Views",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        months[DateTime.parse(data!.videoItems!
                                            .snippet!.publishedAt!)
                                            .month -
                                            1] +
                                            " " +
                                            DateTime.parse(data!.videoItems!
                                                .snippet!.publishedAt!)
                                                .day
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        DateTime.parse(data!.videoItems!.snippet!
                                            .publishedAt!)
                                            .year
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15, bottom: 15),
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0, bottom: 15),
                                child: ReadMoreText(parse(
                                  data!.videoSnippet!.snippet!.description!).body!.text,
                                  trimLines: 6,
                                  trimMode: TrimMode.Line,
                                  trimExpandedText: "",
                                  trimCollapsedText: "Read more",
                                ),
                              )
                            ],
                          ),
                        )
                      )

                    ],
                  )); //whatever you're returning, does not have to be a Container
            }));
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as YoutubeVideo;

    log(widget.videoId!);

    // _ytbPlayerController!.hideTopMenu();

    // _ytbPlayerController!.play();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For IOS (dark icons)
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              isVisible = false;
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            } else {
              isVisible = true;
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            }
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: isVisible
                      ? 16 / 9
                      : MediaQuery.of(context).size.aspectRatio,
                  child: _ytbPlayerController != null
                      ? YoutubePlayerIFrame(controller: _ytbPlayerController)
                      : const Center(child: CircularProgressIndicator()),
                ),
                Expanded(
                    child: Visibility(
                        visible: isVisible,
                        child: SingleChildScrollView(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {
                                      _show(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Text(parse(
                                                data!.videoItems!.snippet!
                                                    .title!).body!.text,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    height: 1.5),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .keyboard_arrow_down_sharp),
                                                padding:
                                                    const EdgeInsets.all(0),
                                                constraints:
                                                    const BoxConstraints(),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              "${Utils.convertToReadable(data!.videoSnippet!.statistics!.viewCount!)} views ⠂${timeago.format(DateTime.parse(data!.videoItems!.snippet!.publishedAt!)).replaceAll("about a", "1").replaceAll("about an", "1")}",
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2),
                                        ],
                                      ),
                                    ))),
                            const SizedBox(
                              height: 15,
                            ),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                              Icons.thumb_up_outlined),
                                        ),
                                        Text(
                                          Utils.convertToReadable(data!
                                                  .videoSnippet!
                                                  .statistics!
                                                  .likeCount!)
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 45,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                              Icons.thumb_down_outlined),
                                        ),
                                        const Text(
                                          "Dislike",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 45,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                              Ionicons.arrow_redo_outline),
                                        ),
                                        const Text(
                                          "Share",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 45,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                              Icons.add_circle_outline),
                                        ),
                                        const Text(
                                          "Create",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.download),
                                        ),
                                        const Text(
                                          "Download",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 45,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                              Icons.library_add_outlined),
                                        ),
                                        const Text(
                                          "Save",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 35,
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.network(
                                        data!.channelSnippet!.snippet!
                                            .thumbnails!.small!.url!,
                                        fit: BoxFit.cover,
                                        height: 30,
                                        width: 30,
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data!.videoItems!.snippet!.channelTitle!,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    data!.channelSnippet!.statistics!
                                                .hiddenSubscriberCount ==
                                            false
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "${Utils.convertToReadable(data!.channelSnippet!.statistics!.subscriberCount!)} subscribers",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                    fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          )
                                        : const Text(
                                            "",
                                            style: TextStyle(fontSize: 0),
                                          )
                                  ],
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "SUBSCRIBE",
                                  style: TextStyle(
                                      color: Color.fromRGBO(204, 0, 0, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Comments",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          Utils.convertToReadable(data!
                                              .videoSnippet!
                                              .statistics!
                                              .commentCount!),
                                          style: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.expand),
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        constraints: const BoxConstraints(),
                                        iconSize: 16,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: videoItems.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.videoId = videoItems[index]
                                                  .id!
                                                  .videoId!;

                                              videoIds = "";
                                              channelIds = "";

                                              data!.videoItems =
                                                  videoItems[index];
                                              data!.videoSnippet = videoView[
                                                  videoItems[index]
                                                      .id!
                                                      .videoId];
                                              data!.channelSnippet =
                                                  channelThumb[videoItems[index]
                                                      .snippet!
                                                      .channelId!];

                                              videoItems.clear();
                                              videoView.clear();
                                              channelThumb.clear();

                                              log(widget.videoId!);

                                              _ytbPlayerController!
                                                  .load(widget.videoId!);

                                              callAPI(widget.videoId!);
                                            });
                                          },
                                          child: Utils.getVideoCard(
                                              videoItems[index]
                                                  .snippet!
                                                  .thumbnails!
                                                  .high!
                                                  .url!,
                                              videoView[videoItems[index]
                                                      .id!
                                                      .videoId!]!
                                                  .contentDetails!
                                                  .duration!,
                                              channelThumb[videoItems[index]
                                                      .snippet!
                                                      .channelId!]!
                                                  .snippet!
                                                  .thumbnails!
                                                  .small!
                                                  .url!,
                                              videoItems[index].snippet!.title!,
                                              videoItems[index]
                                                  .snippet!
                                                  .channelTitle!,
                                              videoView[videoItems[index]
                                                      .id!
                                                      .videoId!]!
                                                  .statistics!
                                                  .viewCount!,
                                              videoItems[index]
                                                  .snippet!
                                                  .publishedAt!,
                                              videoItems[index]
                                                  .snippet!
                                                  .liveBroadcastContent!));
                                    },
                                  )
                          ],
                        ))))
              ],
            );
          },
        ));
  }
}
