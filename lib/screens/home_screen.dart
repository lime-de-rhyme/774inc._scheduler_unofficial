import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nanashi_schedule/models/search_info.dart';
import 'package:nanashi_schedule/models/videos_list.dart';
import 'package:nanashi_schedule/utils/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  final Map<String, String> liversList = {
    //Haneru Channel / 因幡はねる 【あにまーれ】
      "UC0Owc36U9lOyi9Gx9Ic-4qg":
      "https://yt3.ggpht.com/ytc/AAUvwngvgRbvQSxZHcosptXrl6PO3djyKHY7ZLIGbQHo=s176-c-k-c0x00ffffff-no-rj",
    //Ichika Channel / 宗谷 いちか 【あにまーれ】
      "UC2kyQhzGOB-JPgcQX9OMgEw":
      "https://yt3.ggpht.com/ytc/AAUvwnj2XS4F6MS5aaKGDaQ4mcrPlW44lEN-p9oXqj9x=s176-c-k-c0x00ffffff-no-rj",
    //Ran Channel / 日ノ隈らん 【あにまーれ】
      "UCRvpMpzAXBRKJQuk-8-Sdvg":
      "https://yt3.ggpht.com/ytc/AAUvwnit824wjmPA7AE7LDtG0EVjmutNl4-sICtStfTh=s176-c-k-c0x00ffffff-no-rj",
    //Kuku Channel / 風見くく 【あにまーれ】
      "UCXp7sNC0F_qkjickvlYkg-Q":
      "https://yt3.ggpht.com/ytc/AAUvwngUM0DtcqRxbIHvfd8t3D-YEFLudJbN29dpdy44=s176-c-k-c0x00ffffff-no-rj",
    //Izumi Channel / 柚原いづみ 【あにまーれ】
      "UCW8WKciBixmaqaGqrlTITRQ":
      "https://yt3.ggpht.com/ytc/AAUvwnhkL2lOLKPB4cqpPgqjHDV9AVypXtkNt10Eqm0=s176-c-k-c0x00ffffff-no-rj",
    //Mimi Channel / 白宮みみ 【あにまーれ】
      "UCtzCQnCT9E4o6U3mHHSHbQQ":
      "https://yt3.ggpht.com/ytc/AAUvwnh5PNIZ9uxa95u863cHH2MYouiMqeau7SMPMgIM2g=s176-c-k-c0x00ffffff-no-rj",
    //Natsumi Channel / 羽柴なつみ 【あにまーれ】
      "UC_BlXOQe5OcRC7o0GX8kp8A":
      "https://yt3.ggpht.com/ytc/AAUvwnhnPVaFf9fcrI0-QGkOQ-qSEz2jx0KI8VdkdzGc=s176-c-k-c0x00ffffff-no-rj",
    //Hikari Channel / 飛良ひかり 【あにまーれ】
      "UCFsWaTQ7kT76jNNGeGIKNSA":
      "https://yt3.ggpht.com/ytc/AAUvwnggEiqlVN2rxQJAOdr_FDt5FxmAc_zqTKT-Jo1L=s176-c-k-c0x00ffffff-no-rj",
    //Rui Channel / 瀬島るい 【あにまーれ】
      "UC_WOBIopwUih0rytRnr_1Ag":
      "https://yt3.ggpht.com/ytc/AAUvwniT9Kk84h82ycAnKFqBNqWSb6GYU9msUCuICnU1=s176-c-k-c0x00ffffff-no-rj",
    //Tirol Channel /月野木ちろる 【あにまーれ】
      "UCqskJ0nmw-_eweWfsKvbrzQ":
      "https://yt3.ggpht.com/ytc/AAUvwnjuOZitdf-fShd8pKRuJphKOBul_WJ9ikhVJC0t=s176-c-k-c0x00ffffff-no-rj",
    //Rukako Channel / 大浦るかこ 【あにまーれ】
      "UC3xG1XWzAKt5dxSxktJvtxg":
      "https://yt3.ggpht.com/ytc/AAUvwni5YbJevR91U1BH8ZnAht-KGKlfR9qQ0mq--Ms-=s176-c-k-c0x00ffffff-no-rj",
    //Mia Channel / 湖南みあ 【あにまーれ】
      "UC4PrHgUcAtOoj_LKmUL-uLQ":
      "https://yt3.ggpht.com/ytc/AAUvwnhx0c80q3E3hw9sh-DaAcCdJzQwoj-RGacvGKCr=s176-c-k-c0x00ffffff-no-rj",
    //Patra Channel / 周防パトラ 【ハニスト】
      "UCeLzT-7b2PBcunJplmWtoDg":
      "https://yt3.ggpht.com/ytc/AAUvwni3K3HvrlssJykNA7cE68zGcO4xZPF5k3XLE9sO=s176-c-k-c0x00ffffff-no-rj",
    //Mico Channel / 堰代ミコ【ハニスト】
      "UCDh2bWI5EDu7PavqwICkVpA":
      "https://yt3.ggpht.com/ytc/AAUvwnj3utKMlGG9fe71Ti1JfPMohMvO_gT_oSCdGC51=s176-c-k-c0x00ffffff-no-rj",
    //Mary Channel / 西園寺メアリ【ハニスト】
      "UCwePpiw1ocZRSNSkpKvVISw":
      "https://yt3.ggpht.com/ytc/AAUvwnhhEokdfq1Mo2x7_TmP2AU-v0nqHFchVBNWqay_=s176-c-k-c0x00ffffff-no-rj",
    //Charlotte Channel / 島村シャルロット【ハニスト】
      "UCYTz3uIgwVY3ZU-IQJS8r3A":
      "https://yt3.ggpht.com/ytc/AAUvwnjfBbGgsin15WvNkf1f1KvMA956OOECN8FswkYU=s176-c-k-c0x00ffffff-no-rj",
    //Met Channel / 小森めと 【ブイアパ】
      "UCzUNASdzI4PV5SlqtYwAkKQ":
      "https://yt3.ggpht.com/ytc/AAUvwngcfYNy2eRoiQds8qhnxWohjghC3WcxLBtOX5Kg=s176-c-k-c0x00ffffff-no-rj",
    //Wat Channel / 不磨わっと 【ブイアパ】
      "UCV4EoK6BVNl7wxuxpUvvSWA":
      "https://yt3.ggpht.com/ytc/AAUvwnghel9DJYtFb6bSWzpybgFvZVXW5JVewnf7t3X-=s176-c-k-c0x00ffffff-no-rj",
    //花奏 かのん / Kanade Kanon ch
      "UCmqrvfLMws-GLGHQcB5dasg":
      "https://yt3.ggpht.com/ytc/AAUvwngyYdZqbOy-sD-6uapvOvPFivU6Aizkkjkz0lWqbg=s176-c-k-c0x00ffffff-no-rj",
    //Anko Channel / 季咲あんこ 【ブイアパ】
      "UChXm-xAYPfygrbyLo2yCASQ":
      "https://yt3.ggpht.com/ytc/AAUvwnguDljqOoJWknfaN1vN3F8NPPPBMydXFK-ljH05=s176-c-k-c0x00ffffff-no-rj",
    //Uge Channel / 杏戸ゆげ 【ブイアパ】
      "UC3EhsuKdEkI99TWZwZgWutg":
      "https://yt3.ggpht.com/ytc/AAUvwnhldEYLmpc864v-XQDKTryZmS33CK_91Wf2Iwb1=s176-c-k-c0x00ffffff-no-rj",
    //Anna Channel / 虎城アンナ 【シュガリリ】
      "UCvPPBoTOor5gm8zSlE2tg4w":
      "https://yt3.ggpht.com/ytc/AAUvwng3pwz9U-DRhU-oVEo42HFGbzOElFOMHZ532dlV=s176-c-k-c0x00ffffff-no-rj",
    //Chris Channel / 獅子王クリス 【シュガリリ】
      "UC--A2dwZW7-M2kID0N6_lfA":
      "https://yt3.ggpht.com/ytc/AAUvwngzuEXJ6hxBH1uZtz_iJv1VRC8mMGlqEOXojp9f=s176-c-k-c0x00ffffff-no-rj",
    //Rene Channel / 龍ヶ崎リン 【シュガリリ】
      "UC2hc-00y-MSR6eYA4eQ4tjQ":
      "https://yt3.ggpht.com/ytc/AAUvwnhPqY2LTUK6Eo6Fl1ZH_kL-Z9QhjDl9a46iwRH-=s176-c-k-c0x00ffffff-no-rj",
    //奇想天外あにびっと!
      "UC0xhrAce06OkQfHBqAfLQAQ":
      "https://yt3.ggpht.com/ytc/AAUvwniyHQNKdGAQrIe2RGD5z0JI1v4aVAGxCoFizndW=s176-c-k-c0x00ffffff-no-rj",
  };


  //
  SearchInfo _searchInfo;
  VideosList _videosList;
  Item _item;
  bool _loading;
  int day;
  String text;
  /*
  final controller1 = ScrollController();
  final controller2 = ScrollController();
  final controller3 = ScrollController();
  var height;
  int yesterdayLength;
  int oldLive = -1;
  int whichDay;
   */
  double headLineHeight = 50.0;


  @override
  void initState() {
    _loading = true;
    _videosList = VideosList();
    _videosList.videoItems = [];
    _getSearchInfo(liversList);
    super.initState();
  }


  Future<void> _getSearchInfo(Map<String, String> liversList) async {
    _searchInfo = await Services.searchInfo();
    SearchInfo _searchUpcoming = await Services.searchUpcoming();
    for(Item item in _searchUpcoming.items){
      _searchInfo.items.add(item);
    }

    for(int itemIndex = 0; itemIndex < _searchInfo.items.length; itemIndex++) {
      _item = _searchInfo.items[itemIndex];
      String _videosId = _item.id.videoId;
      String _channelIcon = liversList[_item.snippet.channelId];
      if(_channelIcon == null){
        print('continue');
        continue;
      }
      VideoItem videoItem = await _loadVideos(_videosId);
      //firestoreに追加する処理。でもここに書かずにクラスカ的なやつした方がいいんだろうな
      debugPrint('title: '+ videoItem.videosnippet.title);
      print('videoStatus: '+ videoItem.videosnippet.liveBroadcastContent);
      debugPrint('iconUrl: '+ _channelIcon);
      debugPrint('videoUrl: '+ _videosId);
      String documentID = _videosId;
      debugPrint('documentID: '+ documentID);
      //_firestore(videoItem, _channelIcon, _item);
      Firestore.instance.collection('videos')
          .document(documentID)
          .snapshots()
          .listen((snapshot) {
        if (!snapshot.exists) {
          Firestore.instance.collection('videos')
              .document(documentID)
              .setData(
              {
                'iconUrl': _channelIcon,
                'channelTitle': videoItem.videosnippet.channelTitle,
                'scheduledStartTime': videoItem.liveStreamingDetails
                    .scheduledStartTime,
                'thumbnailUrl': videoItem.videosnippet.thumbnails
                    .medium.url,
                'title': videoItem.videosnippet.title,
                'videoStatus': videoItem.videosnippet.liveBroadcastContent,
                //配信url
                'videoUrl': 'https://www.youtube.com/watch?v=' + _videosId,
                //配信urlが取得できなかった時のためにそのライバーのチャンネルに飛ぶようにする
                'channelUrl': 'https://www.youtube.com/channel/' + _item.snippet.channelId,
              }
          );
        } else {
          //処理
          Firestore.instance.collection('videos')
              .document(documentID)
              .updateData(
              {
                'iconUrl': _channelIcon,
                'channelTitle': videoItem.videosnippet.channelTitle,
                'scheduledStartTime': videoItem.liveStreamingDetails
                    .scheduledStartTime,
                'thumbnailUrl': videoItem.videosnippet.thumbnails
                    .medium.url,
                'title': videoItem.videosnippet.title,
                'videoStatus': videoItem.videosnippet.liveBroadcastContent,
                //配信url
                'videoUrl': 'https://www.youtube.com/watch?v=' + _videosId,
                //配信urlが取得できなかった時のためにそのライバーのチャンネルに飛ぶようにする
                'channelUrl': 'https://www.youtube.com/channel/' + _item.snippet.channelId,
              }
          );
        }
      });
    }
    print('setState');
    setState(() {
      _loading = true;
    });
  }

  Future<VideoItem> _loadVideos(String _videosId) async {
    VideosList _videosList = await Services.getVideosList(
      videosId: _videosId,
    );
    setState(() {});
    return _videosList.videoItems[0];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('774inc. schedule【非公式】'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => setState(() {
                _getSearchInfo(liversList);
              }),
            ),
          ],
        ),
        body: Container(
          //左右padding
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _headLine(streamParam()-1),
                StreamBuilder(
                  stream: Firestore.instance.collection('videos')
                      .where('scheduledStartTime', isGreaterThanOrEqualTo: _dateParam(streamParam()-1))
                      .where('scheduledStartTime', isLessThan: _dateParam(streamParam()+0))
                      .orderBy("scheduledStartTime").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return _mainView(snapshot);
                }),
                _headLine(streamParam()+0),
                StreamBuilder(
                    stream: Firestore.instance.collection('videos')
                        .where('scheduledStartTime', isGreaterThanOrEqualTo: _dateParam(streamParam()+0))
                        .where('scheduledStartTime', isLessThan: _dateParam(streamParam()+1))
                        .orderBy("scheduledStartTime").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      return _mainView(snapshot);
                    }),
                _headLine(streamParam()+1),
                StreamBuilder(
                    stream: Firestore.instance.collection('videos')
                        .where('scheduledStartTime', isGreaterThanOrEqualTo: _dateParam(streamParam()+1))
                        .orderBy("scheduledStartTime").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      return _mainView(snapshot);
                    }),
              ],
            ),
          ),
        ),
      );
  }

  streamParam(){
    var today = DateTime.now();
    if(today.hour >= 4){
      int key = 1;
      return key;
    } else{
      int key = 0;
      return key;
    }
  }

  _buildInfoView(video){
    //_loading
        //? CircularProgressIndicator():
    return
        Container(

          color: Colors.blueGrey[800],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(video['iconUrl'],),
                radius: 27,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    video['channelTitle'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
  }

  /// 第2引数のURLを開く。開けないURLだった場合は第2引数のURLを開く
  Future _launchURL(String url, String secondUrl) async {
    if (await canLaunch(url)) {
      await launch(url,
        forceSafariVC: false,
        forceWebView: false,
        universalLinksOnly: true,
      );
    } else if (secondUrl != null && await canLaunch(secondUrl)) {
      await launch(secondUrl);
    } else {
      // 任意のエラー処理
    }
  }

  /// Turn datetime into String
  _intoString(Timestamp scheduleTime){
    initializeDateFormatting("ja_JP");
    DateTime toDatetime = scheduleTime.toDate();
    //datetimeを任意のフォーマットに整形する
    var formatter = new DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");
    //(DateFormat('MM/dd/yyyy HH:mm')).format(toDatetime)
    var formatted = formatter.format(toDatetime); // DateからString
    List splited = formatted.split(' ');
    String toText = '公開時間：${splited[1]}';
    //String toText = '公開時間：${toDatetime.hour}:${toDatetime.minute}';
    return Text(toText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
    );
  }

  _dateParam(int param){
    var today = DateTime.now();
    var threshold   = DateTime(today.year, today.month, today.day+param, 00, 00);
    return threshold;
  }

  _checkUrl(String url){
    url = url.replaceAll(RegExp('hqdefault'), 'mqdefault');
    return url;
  }

  _mainView(var snapshot){
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 2,
        childAspectRatio: 0.83,
      ),
      itemCount: snapshot.data.documents.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                _launchURL(snapshot.data.documents[index]['videoUrl'], snapshot.data.documents[index]['channelUrl']);
              },
              child: Column(
                children: <Widget>[
                  _buildInfoView(snapshot.data.documents[index]),
                  //公開時間
                  _intoString(snapshot.data.documents[index]['scheduledStartTime']),
                  //サムネ
                  _displayLive(snapshot.data.documents[index]['videoStatus'], snapshot.data.documents[index]['thumbnailUrl'] ),
                  //動画タイトル
                  Text(snapshot.data.documents[index]['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),//ここは２行で表示してはみ出るところは非表示にする。あとでやる
                ],
              )),
        );
      },
    );
  }

  _displayLive(String status, String thumbnail ){
    if( status == "live" ){
      //liveマークを表示する
      return Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(
              _checkUrl(thumbnail),
            ),
            fit: BoxFit.cover,
          ),
          Positioned(
              right: 5.0,
              bottom: 5.0,
              child: Container(
                color: Colors.redAccent[400],
                child: Text('LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
          ),
        ],
      );
    }
    else{
      //
      return Image(
        image: CachedNetworkImageProvider(
          _checkUrl(thumbnail),
        ),
        fit: BoxFit.cover,
      );
    }
  }

  Widget _headLine(int param){
    final DateTime today = DateTime.now();
    final List<String> weekDay = ['月','火','水','木','金','土','日'];
    DateTime date = DateTime(today.year, today.month, today.day+param, 00, 00);
    if(param==2){
      text = "${date.month.toString()}/${date.day.toString()} 〜";
    } else {
      text = "${date.month.toString()}/${date.day
          .toString()} (${weekDay[date.weekday - 1]})";
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      height: headLineHeight,
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(1,4,1,4),
      child: Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }


  /*
  void jumpToItem(int oldLive, int whichDay) {
    if(whichDay == 1) {
      rotateController(whichDay).jumpTo(height * (oldLive / 2).ceil());
    } else{
      rotateController(whichDay).jumpTo(height * (oldLive / 2).ceil());
    }
  }

  oldestLive(int index, String liveStatus, int controllerParam){
    if(liveStatus == 'live'){
      if(oldLive == -1){
        oldLive = index;
        whichDay = controllerParam;
      }
    }
    //ここに昨日か今日のどちらにliveがあったのか判断する処理をしたい
  }

  rotateController(int param){
    if(param == 1){
      return controller1;
    } else if(param == 2){
      return controller2;
    } else{
      return controller3;
    }
  }
   */
}


/*
  indexでjumptoする
  １番古いlive中の配信のindexを記録する
  controllerを二つ用意して
  昨日の配信にlive中がなければ今日のcontrollerを発動する
  日付ヘッダー+上下のパディング+((一つのアイテムの高さ+下の隙間)*(アイテムの数/2).繰り上げ)
  昨日の配信にliveがなければ上のやつに+日付の上の大きめの隙間+日付ヘッダー+その下のパディング+また上の計算式
  これはoffsetを求めているはず。あとはjumpto
  日付ヘッダー：50+padding10*2,
  要素の高さ：context.size.height+下パディング4,
  昨日のアイテムの数：(snapshot.data.documents.length/2).繰り上げ,
  live中の配信があったら変数にindexを格納それ以降liveがあっても更新しないように
  int oldLive = -1;
  if(snapshot.data.documents[index]['videoStatus'] == 'live'){
    oldLive = oldLive == -1 ? index: oldLive;
  }
  (yesterdayLength/2).ceil()//縦のアイテムの数
  height//1つの要素の高さ
  //昨日のstreamBuilderの全長
  double yesterdayHeight = height * (yesterdayLength/2).ceil() + headLineHeight*2
  //paddingは一旦無視する
  //live中の配信があるところの高さ
  double todayHeight = height * (oldLive/2).ceil()
  //いざジャンプ！！！
  controller.jumpTo(yesterdayHeight + todayHeight);
  もしかしてcontrollerごとに決まっているせつ
  controller:controllerを改造する
  //昨日か今日のどちらのコントローラを使うかを決める処理が必要


*/