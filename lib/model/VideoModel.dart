class VideoModel {
  String? kind;
  String? etag;
  String? nextPageToken;
  String? regionCode;
  PageInfo? pageInfo;
  List<VideoItems>? items;

  VideoModel({kind, etag, nextPageToken, regionCode, pageInfo, items});

  VideoModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    nextPageToken = json['nextPageToken'];
    regionCode = json['regionCode'];
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    if (json['items'] != null) {
      items = <VideoItems>[];
      json['items'].forEach((v) {
        items!.add(VideoItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['nextPageToken'] = nextPageToken;
    data['regionCode'] = regionCode;
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
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

class VideoItems {
  String? kind;
  String? etag;
  Id? id;
  Snippet? snippet;

  VideoItems({kind, etag, id, snippet});

  VideoItems.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    snippet =
        json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    if (id != null) {
      data['id'] = id!.toJson();
    }
    if (snippet != null) {
      data['snippet'] = snippet!.toJson();
    }
    return data;
  }
}

class Id {
  String? kind;
  String? videoId;

  Id({kind, videoId});

  Id.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['videoId'] = videoId;
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
  String? liveBroadcastContent;
  String? publishTime;

  Snippet(
      {publishedAt,
      channelId,
      title,
      description,
      thumbnails,
      channelTitle,
      liveBroadcastContent,
      publishTime});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null
        ? Thumbnails.fromJson(json['thumbnails'])
        : null;
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
    publishTime = json['publishTime'];
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
    data['liveBroadcastContent'] = liveBroadcastContent;
    data['publishTime'] = publishTime;
    return data;
  }
}

class Thumbnails {
  Smalls? small;
  Smalls? medium;
  Smalls? high;
  Smalls? standard;
  Smalls? maxres;

  Thumbnails({small, medium, high, standard, maxres});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    small = json['default'] != null ? Smalls.fromJson(json['default']) : null;
    medium = json['medium'] != null ? Smalls.fromJson(json['medium']) : null;
    high = json['high'] != null ? Smalls.fromJson(json['high']) : null;
    standard =
        json['standard'] != null ? Smalls.fromJson(json['standard']) : null;
    maxres = json['maxres'] != null ? Smalls.fromJson(json['maxres']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (small != null) {
      data['default'] = small!.toJson();
    }
    if (medium != null) {
      data['medium'] = medium!.toJson();
    }
    if (high != null) {
      data['high'] = high!.toJson();
    }
    if (standard != null) {
      data['standard'] = standard!.toJson();
    }
    if (maxres != null) {
      data['maxres'] = maxres!.toJson();
    }
    return data;
  }
}

class Smalls {
  String? url;
  int? width;
  int? height;

  Smalls({url, width, height});

  Smalls.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
