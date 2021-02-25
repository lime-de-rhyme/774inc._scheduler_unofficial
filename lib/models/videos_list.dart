// To parse this JSON data, do
//
//     final videosList = videosListFromJson(jsonString);

import 'dart:convert';

VideosList videosListFromJson(String str) => VideosList.fromJson(json.decode(str));

String videosListToJson(VideosList data) => json.encode(data.toJson());

class VideosList {
  VideosList({
    this.kind,
    this.etag,
    this.videoItems,
    this.pageInfo,
  });

  String kind;
  String etag;
  List<VideoItem> videoItems;
  PageInfo pageInfo;

  factory VideosList.fromJson(Map<String, dynamic> json) => VideosList(
    kind: json["kind"],
    etag: json["etag"],
    videoItems: List<VideoItem>.from(json["items"].map((x) => VideoItem.fromJson(x))),
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "items": List<dynamic>.from(videoItems.map((x) => x.toJson())),
    "pageInfo": pageInfo.toJson(),
  };
}

class VideoItem {
  VideoItem({
    this.kind,
    this.etag,
    this.id,
    this.videosnippet,
    this.liveStreamingDetails,
  });

  String kind;
  String etag;
  String id;
  VideoSnippet videosnippet;
  LiveStreamingDetails liveStreamingDetails;

  factory VideoItem.fromJson(Map<String, dynamic> json) => VideoItem(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"],
    videosnippet: VideoSnippet.fromJson(json["snippet"]),
    liveStreamingDetails: LiveStreamingDetails.fromJson(json["liveStreamingDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id,
    "snippet": videosnippet.toJson(),
    "liveStreamingDetails": liveStreamingDetails.toJson(),
  };
}

class LiveStreamingDetails {
  LiveStreamingDetails({
    this.actualStartTime,
    this.scheduledStartTime,
    this.concurrentViewers,
    this.activeLiveChatId,
  });

  DateTime actualStartTime;
  DateTime scheduledStartTime;
  String concurrentViewers;
  String activeLiveChatId;

  factory LiveStreamingDetails.fromJson(Map<String, dynamic> json) => LiveStreamingDetails(
    //json['token_expiry'] == null ? null : DateTime.parse(json['token_expiry'] as String),
    actualStartTime: json["actualStartTime"] == null ? null : DateTime.parse(json['actualStartTime'] as String),
    scheduledStartTime: json["scheduledStartTime"] == null ? null : DateTime.parse(json['scheduledStartTime'] as String),
    concurrentViewers: json["concurrentViewers"],
    activeLiveChatId: json["activeLiveChatId"],
  );

  Map<String, dynamic> toJson() => {
    "actualStartTime": actualStartTime.toIso8601String(),
    "scheduledStartTime": scheduledStartTime.toIso8601String(),
    "concurrentViewers": concurrentViewers,
    "activeLiveChatId": activeLiveChatId,
  };
}

class VideoSnippet {
  VideoSnippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    //this.tags,
    this.categoryId,
    this.liveBroadcastContent,
    this.localized,
    this.defaultAudioLanguage,
  });

  DateTime publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  //List<String> tags;
  String categoryId;
  String liveBroadcastContent;
  Localized localized;
  String defaultAudioLanguage;

  factory VideoSnippet.fromJson(Map<String, dynamic> json) => VideoSnippet(
    publishedAt: DateTime.parse(json["publishedAt"]),
    channelId: json["channelId"],
    title: json["title"],
    description: json["description"],
    thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    channelTitle: json["channelTitle"],
    //tags: List<String>.from(json["tags"].map((x) => x)),
    categoryId: json["categoryId"],
    liveBroadcastContent: json["liveBroadcastContent"],
    localized: Localized.fromJson(json["localized"]),
    defaultAudioLanguage: json["defaultAudioLanguage"],
  );

  Map<String, dynamic> toJson() => {
    "publishedAt": publishedAt.toIso8601String(),
    "channelId": channelId,
    "title": title,
    "description": description,
    "thumbnails": thumbnails.toJson(),
    "channelTitle": channelTitle,
    //"tags": List<dynamic>.from(tags.map((x) => x)),
    "categoryId": categoryId,
    "liveBroadcastContent": liveBroadcastContent,
    "localized": localized.toJson(),
    "defaultAudioLanguage": defaultAudioLanguage,
  };
}

class Localized {
  Localized({
    this.title,
    this.description,
  });

  String title;
  String description;

  factory Localized.fromJson(Map<String, dynamic> json) => Localized(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
    this.standard,
    this.maxres,
  });

  Default thumbnailsDefault;
  Default medium;
  Default high;
  Default standard;
  Default maxres;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json["default"]),
    medium: Default.fromJson(json["medium"]),
    high: Default.fromJson(json["high"]),
    standard: Default.fromJson(json["standard"]),
    maxres: Default.fromJson(json["maxres"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault.toJson(),
    "medium": medium.toJson(),
    "high": high.toJson(),
    "standard": standard.toJson(),
    "maxres": maxres.toJson(),
  };
}

class Default {
  Default({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

class PageInfo {
  PageInfo({
    this.totalResults,
    this.resultsPerPage,
  });

  int totalResults;
  int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalResults: json["totalResults"],
    resultsPerPage: json["resultsPerPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults,
    "resultsPerPage": resultsPerPage,
  };
}
