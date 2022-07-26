class ChannelSnippet {
  String? kind;
  String? etag;
  PageInfo? pageInfo;
  List<ChannelItems>? items;

  ChannelSnippet({kind, etag, pageInfo, items});

  ChannelSnippet.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    pageInfo = json['pageInfo'] != null
        ? PageInfo.fromJson(json['pageInfo'])
        : null;
    if (json['items'] != null) {
      items = <ChannelItems>[];
      json['items'].forEach((v) {
        items!.add(ChannelItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
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

class ChannelItems {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  Statistics? statistics;

  ChannelItems({kind, etag, id, snippet, statistics});

  ChannelItems.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet =
    json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
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
    if (this.statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

class Statistics {
  String? viewCount;
  String? subscriberCount;
  bool? hiddenSubscriberCount;
  String? videoCount;

  Statistics({this.viewCount, this.subscriberCount, this.hiddenSubscriberCount, this.videoCount});

  Statistics.fromJson(Map<String, dynamic> json) {
    viewCount = json['viewCount'];
    subscriberCount = json['subscriberCount'];
    hiddenSubscriberCount = json['hiddenSubscriberCount'];
    videoCount = json['videoCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewCount'] = this.viewCount;
    data['subscriberCount'] = this.subscriberCount;
    data['hiddenSubscriberCount'] = this.hiddenSubscriberCount;
    data['videoCount'] = this.videoCount;
    return data;
  }
}

class Snippet {
  String? title;
  String? description;
  String? customUrl;
  String? publishedAt;
  Thumbnails? thumbnails;
  Localized? localized;
  String? country;

  Snippet(
      {title,
        description,
        customUrl,
        publishedAt,
        thumbnails,
        localized,
        country});

  Snippet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    customUrl = json['customUrl'];
    publishedAt = json['publishedAt'];
    thumbnails = json['thumbnails'] != null
        ? Thumbnails.fromJson(json['thumbnails'])
        : null;
    localized = json['localized'] != null
        ? Localized.fromJson(json['localized'])
        : null;
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['customUrl'] = customUrl;
    data['publishedAt'] = publishedAt;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.toJson();
    }
    if (localized != null) {
      data['localized'] = localized!.toJson();
    }
    data['country'] = country;
    return data;
  }
}

class Thumbnails {
  Small? small;
  Small? medium;
  Small? high;

  Thumbnails({small, medium, high});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    small = json['default'] != null ? Small.fromJson(json['default']) : null;
    medium = json['medium'] != null ? Small.fromJson(json['medium']) : null;
    high = json['high'] != null ? Small.fromJson(json['high']) : null;
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
    return data;
  }
}

class Small {
  String? url;
  int? width;
  int? height;

  Small({url, width, height});

  Small.fromJson(Map<String, dynamic> json) {
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