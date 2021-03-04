import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nanashi_schedule/models/search_info.dart';
import 'package:nanashi_schedule/models/videos_list.dart';

import 'constants.dart';

class Services{
  //
  //static const CHANNEL_ID = 'UCDh2bWI5EDu7PavqwICkVpA';
  static const _baseUrl = 'youtube.googleapis.com';

  static Future<SearchInfo> searchInfo() async {
    final DateTime today = DateTime.now();
    final DateTime midnight = DateTime(today.year, today.month, today.day-1, today.hour, 00);
    //2021-03-02T00:00:00Z
    final String month = ( today.month < 10 ) ? "0${midnight.month.toString()}-" : "${midnight.month.toString()}-";
    final String day = ( today.day < 10 ) ? "0${midnight.day.toString()}" : "${midnight.day.toString()}";
    final String hour = ( today.hour < 10 ) ? "0${midnight.hour.toString()}" : "${midnight.hour.toString()}";
    final String strToday = "${midnight.year.toString()}-" + month + day + "T" + hour + ":00:00Z";
    print(strToday);
    Map<String, String> parameters = {
      'part':'snippet',
      'eventType': 'none',
      'maxResults': '50',
      'publishedAfter': strToday,
      'q': '774inc',
      'type':'video',
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/search', parameters
    );
    var response = await http.get(uri, headers: headers);
    //print(response.body);
    SearchInfo searchInfo = searchInfoFromJson(response.body);
    return searchInfo;
  }

  static Future<SearchInfo> searchUpcoming() async {
    Map<String, String> parameters = {
      'part':'snippet',
      'eventType': 'upcoming',
      'maxResults': '50',
      'q': '774inc',
      'type':'video',
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/search', parameters
    );
    var response = await http.get(uri, headers: headers);
    //print(response.body);
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
    //print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }

}