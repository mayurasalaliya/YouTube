class CommentSnippet {
  String? kind;
  String? etag;
  String? nextPageToken;
  PageInfo? pageInfo;
  List<Items>? items;

  CommentSnippet(
      {kind, etag, nextPageToken, pageInfo, items});

  CommentSnippet.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    nextPageToken = json['nextPageToken'];
    pageInfo = json['pageInfo'] != null
        ? PageInfo.fromJson(json['pageInfo'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['nextPageToken'] = nextPageToken;
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

class Items {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  Replies? replies;

  Items({kind, etag, id, snippet, replies});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet =
    json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
    replies =
    json['replies'] != null ? Replies.fromJson(json['replies']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['id'] = id;
    if (snippet != null) {
      data['snippet'] = snippet!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.toJson();
    }
    return data;
  }
}

class Snippet {
  String? videoId;
  TopLevelComment? topLevelComment;
  bool? canReply;
  int? totalReplyCount;
  bool? isPublic;

  Snippet(
      {videoId,
        topLevelComment,
        canReply,
        totalReplyCount,
        isPublic});

  Snippet.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    topLevelComment = json['topLevelComment'] != null
        ? TopLevelComment.fromJson(json['topLevelComment'])
        : null;
    canReply = json['canReply'];
    totalReplyCount = json['totalReplyCount'];
    isPublic = json['isPublic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    if (topLevelComment != null) {
      data['topLevelComment'] = topLevelComment!.toJson();
    }
    data['canReply'] = canReply;
    data['totalReplyCount'] = totalReplyCount;
    data['isPublic'] = isPublic;
    return data;
  }
}

class TopLevelComment {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;

  TopLevelComment({kind, etag, id, snippet});

  TopLevelComment.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet =
    json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['id'] = id;
    if (snippet != null) {
      data['snippet'] = snippet!.toJson();
    }
    return data;
  }
}

class CommentItems {
  String? videoId;
  String? textDisplay;
  String? textOriginal;
  String? authorDisplayName;
  String? authorProfileImageUrl;
  String? authorChannelUrl;
  AuthorChannelId? authorChannelId;
  bool? canRate;
  String? viewerRating;
  int? likeCount;
  String? publishedAt;
  String? updatedAt;

  CommentItems(
      {videoId,
        textDisplay,
        textOriginal,
        authorDisplayName,
        authorProfileImageUrl,
        authorChannelUrl,
        authorChannelId,
        canRate,
        viewerRating,
        likeCount,
        publishedAt,
        updatedAt});

  CommentItems.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    textDisplay = json['textDisplay'];
    textOriginal = json['textOriginal'];
    authorDisplayName = json['authorDisplayName'];
    authorProfileImageUrl = json['authorProfileImageUrl'];
    authorChannelUrl = json['authorChannelUrl'];
    authorChannelId = json['authorChannelId'] != null
        ? AuthorChannelId.fromJson(json['authorChannelId'])
        : null;
    canRate = json['canRate'];
    viewerRating = json['viewerRating'];
    likeCount = json['likeCount'];
    publishedAt = json['publishedAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['textDisplay'] = textDisplay;
    data['textOriginal'] = textOriginal;
    data['authorDisplayName'] = authorDisplayName;
    data['authorProfileImageUrl'] = authorProfileImageUrl;
    data['authorChannelUrl'] = authorChannelUrl;
    if (authorChannelId != null) {
      data['authorChannelId'] = authorChannelId!.toJson();
    }
    data['canRate'] = canRate;
    data['viewerRating'] = viewerRating;
    data['likeCount'] = likeCount;
    data['publishedAt'] = publishedAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class AuthorChannelId {
  String? value;

  AuthorChannelId({value});

  AuthorChannelId.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}

class Replies {
  List<Replies>? comments;

  Replies({comments});

  Replies.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Replies>[];
      json['comments'].forEach((v) {
        comments!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RepliesSnippet {
  String? videoId;
  String? textDisplay;
  String? textOriginal;
  String? parentId;
  String? authorDisplayName;
  String? authorProfileImageUrl;
  String? authorChannelUrl;
  AuthorChannelId? authorChannelId;
  bool? canRate;
  String? viewerRating;
  int? likeCount;
  String? publishedAt;
  String? updatedAt;

  RepliesSnippet(
      {videoId,
        textDisplay,
        textOriginal,
        parentId,
        authorDisplayName,
        authorProfileImageUrl,
        authorChannelUrl,
        authorChannelId,
        canRate,
        viewerRating,
        likeCount,
        publishedAt,
        updatedAt});

  RepliesSnippet.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    textDisplay = json['textDisplay'];
    textOriginal = json['textOriginal'];
    parentId = json['parentId'];
    authorDisplayName = json['authorDisplayName'];
    authorProfileImageUrl = json['authorProfileImageUrl'];
    authorChannelUrl = json['authorChannelUrl'];
    authorChannelId = json['authorChannelId'] != null
        ? AuthorChannelId.fromJson(json['authorChannelId'])
        : null;
    canRate = json['canRate'];
    viewerRating = json['viewerRating'];
    likeCount = json['likeCount'];
    publishedAt = json['publishedAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['textDisplay'] = textDisplay;
    data['textOriginal'] = textOriginal;
    data['parentId'] = parentId;
    data['authorDisplayName'] = authorDisplayName;
    data['authorProfileImageUrl'] = authorProfileImageUrl;
    data['authorChannelUrl'] = authorChannelUrl;
    if (authorChannelId != null) {
      data['authorChannelId'] = authorChannelId!.toJson();
    }
    data['canRate'] = canRate;
    data['viewerRating'] = viewerRating;
    data['likeCount'] = likeCount;
    data['publishedAt'] = publishedAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}