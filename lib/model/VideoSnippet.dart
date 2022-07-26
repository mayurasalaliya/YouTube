import 'VideoModel.dart';

class VideoSnippet {
  String? kind;
  String? etag;
  List<VideoSnippetItems>? items;
  PageInfo? pageInfo;

  VideoSnippet({kind, etag, items, pageInfo});

  VideoSnippet.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    if (json['items'] != null) {
      items = <VideoSnippetItems>[];
      json['items'].forEach((v) { if(v != null) items!.add(VideoSnippetItems.fromJson(v)); });
    }
    pageInfo = json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    return data;
  }
}

class VideoSnippetItems {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  ContentDetails? contentDetails;
  Statistics? statistics;

  VideoSnippetItems({kind, etag, id, snippet, contentDetails, statistics});

  VideoSnippetItems.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet = json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
    contentDetails = json['contentDetails'] != null ? ContentDetails.fromJson(json['contentDetails']) : null;
    statistics = json['statistics'] != null ? Statistics.fromJson(json['statistics']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['id'] = id;
    if (snippet != null) {
      data['snippet'] = snippet!.toJson();
    }
    if (contentDetails != null) {
      data['contentDetails'] = contentDetails!.toJson();
    }
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  List<String>? tags;
  String? categoryId;
  String? liveBroadcastContent;
  String? defaultLanguage;
  Localized? localized;
  String? defaultAudioLanguage;

  Snippet({publishedAt, channelId, title, description, thumbnails, channelTitle, tags, categoryId, liveBroadcastContent, defaultLanguage, localized, defaultAudioLanguage});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
    channelTitle = json['channelTitle'];
    tags = json['tags'] != null ? json['tags'].cast<String>()! : null;
    categoryId = json['categoryId'];
    liveBroadcastContent = json['liveBroadcastContent'];
    defaultLanguage = json['defaultLanguage'];
    localized = json['localized'] != null ? Localized.fromJson(json['localized']) : null;
    defaultAudioLanguage = json['defaultAudioLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publishedAt'] = publishedAt;
    data['channelId'] = channelId;
    data['title'] = title;
    data['description'] = description;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.toJson();
    }
    data['channelTitle'] = channelTitle;
    data['tags'] = tags;
    data['categoryId'] = categoryId;
    data['liveBroadcastContent'] = liveBroadcastContent;
    data['defaultLanguage'] = defaultLanguage;
    if (localized != null) {
      data['localized'] = localized!.toJson();
    }
    data['defaultAudioLanguage'] = defaultAudioLanguage;
    return data;
  }
}

class Localized {
  String? title;
  String? description;

  Localized({title, description});

  Localized.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class ContentDetails {
  String? duration;
  String? dimension;
  String? definition;
  String? caption;
  bool? licensedContent;
  String? projection;

  ContentDetails({duration, dimension, definition, caption, licensedContent, contentRating, projection});

  ContentDetails.fromJson(Map<String, dynamic> json) {
    duration = getDuration(json['duration']);
    dimension = json['dimension'];
    definition = json['definition'];
    caption = json['caption'];
    licensedContent = json['licensedContent'];
    projection = json['projection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['dimension'] = dimension;
    data['definition'] = definition;
    data['caption'] = caption;
    data['licensedContent'] = licensedContent;
    data['projection'] = projection;
    return data;
  }
}

String? getDuration(String duration) {
  if (duration.isEmpty) return null;

  if(duration == "P0D") {
    return " LIVE ";
  }

  duration = duration.replaceFirst("PT", "");

  var validDuration = ["H", "M", "S"];
  if (!duration.contains(RegExp(r'[HMS]'))) {
    return null;
  }
  var hour = 0, min = 0, sec = 0;
  for (int i = 0; i < validDuration.length; i++) {
    var index = duration.indexOf(validDuration[i]);
    if (index != -1) {
      var valInString = duration.substring(0, index);
      var val = int.parse(valInString);
      if (i == 0) {
        hour = val;
      } else if (i == 1) {
        min = val;
      } else if (i == 2) {
        sec = val;
      }
      duration = duration.substring(valInString.length + 1);
    }
  }
  List buff = [];
  if (hour != 0) {
    buff.add(hour);
  }
  if (min == 0) {
    if (hour != 0) buff.add(min.toString().padLeft(2, '0'));
  } else {
    buff.add(min.toString().padLeft(2, '0'));
  }
  buff.add(sec.toString().padLeft(2, '0'));

  return buff.join(":");
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

class Statistics {
  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  Statistics({viewCount, likeCount, favoriteCount, commentCount});

  Statistics.fromJson(Map<String, dynamic> json) {
    viewCount = json['viewCount'];
    likeCount = json['likeCount'];
    favoriteCount = json['favoriteCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['viewCount'] = viewCount;
    data['likeCount'] = likeCount;
    data['favoriteCount'] = favoriteCount;
    data['commentCount'] = commentCount;
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({totalResults, resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalResults'] = totalResults;
    data['resultsPerPage'] = resultsPerPage;
    return data;
  }
}