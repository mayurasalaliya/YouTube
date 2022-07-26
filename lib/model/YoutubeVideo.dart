import 'package:youtube/model/ChannelSnippet.dart';
import 'package:youtube/model/VideoModel.dart';
import 'package:youtube/model/VideoSnippet.dart';
import 'package:youtube_api/youtube_api.dart';

class YoutubeVideo{
  VideoItems? videoItems;
  VideoSnippetItems? videoSnippet;
  ChannelItems? channelSnippet;

  YoutubeVideo(this.videoItems,this.videoSnippet,this.channelSnippet);
}