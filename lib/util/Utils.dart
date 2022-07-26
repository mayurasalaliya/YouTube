import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:html/parser.dart' show parse;

class Utils {
  static String key = "";

  static String convertToReadable(String currentView) {
    try {
      // var suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentView);
      RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

      if (value < 1000) {
        return currentView;
      } else if (value < 1000000) {
        // less than a million
        double result = value / 1000;
        if (result < 10) {
          return "${result.toStringAsFixed(1).replaceAll(regex, '')}K";
        } else {
          return "${result.toStringAsFixed(0).replaceAll(regex, '')}K";
        }
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        if (result < 10) {
          return "${result.toStringAsFixed(1).replaceAll(regex, '')}M";
        } else {
          return "${result.toStringAsFixed(0)}M";
        }
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return "${result.toStringAsFixed(1).replaceAll(regex, '')}B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return "${result.toStringAsFixed(1).replaceAll(regex, '')}T";
      } else {
        return currentView;
      }
    } catch (e) {
      return currentView;
    }
  }

  static Widget getVideoCard(
      String thumbUrl,
      String duration,
      String channelThumbUrl,
      String videoTitle,
      String channelTitle,
      String viewCount,
      String publishedAt,
      String liveBroadcastContent) {
    return Wrap(
      children: [
        Column(children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl: thumbUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                  padding: const EdgeInsets.all(7),
                  child: Container(
                      decoration: BoxDecoration(
                          color: liveBroadcastContent == "live"
                              ? const Color.fromRGBO(204, 0, 0, 1)
                              : Colors.black,
                          borderRadius: const BorderRadius.all(Radius.circular(3))),
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      channelThumbUrl,
                      fit: BoxFit.cover,
                      height: 35,
                      width: 35,
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        parse(videoTitle).body!.text,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )),
                  const SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "$channelTitle ⠂${Utils.convertToReadable(viewCount)} views ⠂${timeago.format(DateTime.parse(publishedAt)).replaceAll("about a", "1").replaceAll("about an", "1")}",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2),
                  )
                ],
              )),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ]),
      ],
    );
  }
}
