import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nanashi_schedule/models/search_info.dart';
import 'package:nanashi_schedule/models/videos_list.dart';

import 'constants.dart';

class Services{
  //
  //static const CHANNEL_ID = 'UCDh2bWI5EDu7PavqwICkVpA';
  static const _baseUrl = 'youtube.googleapis.com';

  static Future<SearchInfo> searchInfo({String channelId}) async {
    Map<String, String> parameters = {
      'part':'snippet',
      'channelId': channelId,
      'eventType':'upcoming',
      'type':'video',
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/search', parameters
    );
    var response = await http.get(uri, headers: headers);
    print(response.body);
    SearchInfo searchInfo = searchInfoFromJson(response.body);
    return searchInfo;
  }

  static Future<VideosList> getVideosList({String videosId}) async {
    Map<String, String> parameters = {
      'part': 'snippet,liveStreamingDetails',
      'id': videosId,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/videos',
      parameters,
    );
    var response = await http.get(uri, headers: headers);
    print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }

}