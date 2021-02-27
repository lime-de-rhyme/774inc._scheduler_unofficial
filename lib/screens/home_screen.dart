import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nanashi_schedule/models/search_info.dart';
import 'package:nanashi_schedule/models/videos_list.dart';
import 'package:nanashi_schedule/utils/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  final List list = [
    //Haneru Channel / 因幡はねる 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwngvgRbvQSxZHcosptXrl6PO3djyKHY7ZLIGbQHo=s176-c-k-c0x00ffffff-no-rj", "UC0Owc36U9lOyi9Gx9Ic-4qg"],
    //Ichika Channel / 宗谷 いちか 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnj2XS4F6MS5aaKGDaQ4mcrPlW44lEN-p9oXqj9x=s176-c-k-c0x00ffffff-no-rj", "UC2kyQhzGOB-JPgcQX9OMgEw"],
    //Ran Channel / 日ノ隈らん 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnit824wjmPA7AE7LDtG0EVjmutNl4-sICtStfTh=s176-c-k-c0x00ffffff-no-rj", "UCRvpMpzAXBRKJQuk-8-Sdvg"],
    //Kuku Channel / 風見くく 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwngUM0DtcqRxbIHvfd8t3D-YEFLudJbN29dpdy44=s176-c-k-c0x00ffffff-no-rj", "UCXp7sNC0F_qkjickvlYkg-Q"],
    //Izumi Channel / 柚原いづみ 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnhkL2lOLKPB4cqpPgqjHDV9AVypXtkNt10Eqm0=s176-c-k-c0x00ffffff-no-rj", "UCW8WKciBixmaqaGqrlTITRQ"],
    //Mimi Channel / 白宮みみ 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnh5PNIZ9uxa95u863cHH2MYouiMqeau7SMPMgIM2g=s176-c-k-c0x00ffffff-no-rj", "UCtzCQnCT9E4o6U3mHHSHbQQ"],
    //Natsumi Channel / 羽柴なつみ 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnhnPVaFf9fcrI0-QGkOQ-qSEz2jx0KI8VdkdzGc=s176-c-k-c0x00ffffff-no-rj", "UC_BlXOQe5OcRC7o0GX8kp8A"],
    //Hikari Channel / 飛良ひかり 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnggEiqlVN2rxQJAOdr_FDt5FxmAc_zqTKT-Jo1L=s176-c-k-c0x00ffffff-no-rj", "UCFsWaTQ7kT76jNNGeGIKNSA"],
    //Rui Channel / 瀬島るい 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwniT9Kk84h82ycAnKFqBNqWSb6GYU9msUCuICnU1=s176-c-k-c0x00ffffff-no-rj", "UC_WOBIopwUih0rytRnr_1Ag"],
    //Tirol Channel /月野木ちろる 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnjuOZitdf-fShd8pKRuJphKOBul_WJ9ikhVJC0t=s176-c-k-c0x00ffffff-no-rj", "UCqskJ0nmw-_eweWfsKvbrzQ"],
    //Rukako Channel / 大浦るかこ 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwni5YbJevR91U1BH8ZnAht-KGKlfR9qQ0mq--Ms-=s176-c-k-c0x00ffffff-no-rj", "UC3xG1XWzAKt5dxSxktJvtxg"],
    //Mia Channel / 湖南みあ 【あにまーれ】
    ["https://yt3.ggpht.com/ytc/AAUvwnhx0c80q3E3hw9sh-DaAcCdJzQwoj-RGacvGKCr=s176-c-k-c0x00ffffff-no-rj", "UC4PrHgUcAtOoj_LKmUL-uLQ"],
    //Patra Channel / 周防パトラ 【ハニスト】
    ["https://yt3.ggpht.com/ytc/AAUvwni3K3HvrlssJykNA7cE68zGcO4xZPF5k3XLE9sO=s176-c-k-c0x00ffffff-no-rj", "UCeLzT-7b2PBcunJplmWtoDg"],
    //Mico Channel / 堰代ミコ【ハニスト】
    ["https://yt3.ggpht.com/ytc/AAUvwnj3utKMlGG9fe71Ti1JfPMohMvO_gT_oSCdGC51=s176-c-k-c0x00ffffff-no-rj", "UCDh2bWI5EDu7PavqwICkVpA"],
    //Mary Channel / 西園寺メアリ【ハニスト】
    ["https://yt3.ggpht.com/ytc/AAUvwnhhEokdfq1Mo2x7_TmP2AU-v0nqHFchVBNWqay_=s176-c-k-c0x00ffffff-no-rj", "UCwePpiw1ocZRSNSkpKvVISw"],
    //Charlotte Channel / 島村シャルロット【ハニスト】
    ["https://yt3.ggpht.com/ytc/AAUvwnjfBbGgsin15WvNkf1f1KvMA956OOECN8FswkYU=s176-c-k-c0x00ffffff-no-rj", "UCYTz3uIgwVY3ZU-IQJS8r3A"],
    //Met Channel / 小森めと 【ブイアパ】
    ["https://yt3.ggpht.com/ytc/AAUvwngcfYNy2eRoiQds8qhnxWohjghC3WcxLBtOX5Kg=s176-c-k-c0x00ffffff-no-rj", "UCzUNASdzI4PV5SlqtYwAkKQ"],
    //Wat Channel / 不磨わっと 【ブイアパ】
    ["https://yt3.ggpht.com/ytc/AAUvwnghel9DJYtFb6bSWzpybgFvZVXW5JVewnf7t3X-=s176-c-k-c0x00ffffff-no-rj", "UCV4EoK6BVNl7wxuxpUvvSWA"],
    //花奏 かのん / Kanade Kanon ch
    ["https://yt3.ggpht.com/ytc/AAUvwngyYdZqbOy-sD-6uapvOvPFivU6Aizkkjkz0lWqbg=s176-c-k-c0x00ffffff-no-rj", "UCmqrvfLMws-GLGHQcB5dasg"],
    //Anko Channel / 季咲あんこ 【ブイアパ】
    ["https://yt3.ggpht.com/ytc/AAUvwnguDljqOoJWknfaN1vN3F8NPPPBMydXFK-ljH05=s176-c-k-c0x00ffffff-no-rj", "UChXm-xAYPfygrbyLo2yCASQ"],
    //Uge Channel / 杏戸ゆげ 【ブイアパ】
    ["https://yt3.ggpht.com/ytc/AAUvwnhldEYLmpc864v-XQDKTryZmS33CK_91Wf2Iwb1=s176-c-k-c0x00ffffff-no-rj", "UC3EhsuKdEkI99TWZwZgWutg"],
    //Anna Channel / 虎城アンナ 【シュガリリ】
    ["https://yt3.ggpht.com/ytc/AAUvwng3pwz9U-DRhU-oVEo42HFGbzOElFOMHZ532dlV=s176-c-k-c0x00ffffff-no-rj", "UCvPPBoTOor5gm8zSlE2tg4w"],
    //Chris Channel / 獅子王クリス 【シュガリリ】
    ["https://yt3.ggpht.com/ytc/AAUvwngzuEXJ6hxBH1uZtz_iJv1VRC8mMGlqEOXojp9f=s176-c-k-c0x00ffffff-no-rj", "UC--A2dwZW7-M2kID0N6_lfA"],
    //Rene Channel / 龍ヶ崎リン 【シュガリリ】
    ["https://yt3.ggpht.com/ytc/AAUvwnhPqY2LTUK6Eo6Fl1ZH_kL-Z9QhjDl9a46iwRH-=s176-c-k-c0x00ffffff-no-rj", "UC2hc-00y-MSR6eYA4eQ4tjQ"],
    //奇想天外あにびっと!
    ["https://yt3.ggpht.com/ytc/AAUvwniyHQNKdGAQrIe2RGD5z0JI1v4aVAGxCoFizndW=s176-c-k-c0x00ffffff-no-rj", "UC0xhrAce06OkQfHBqAfLQAQ"],
  ];


  //
  SearchInfo _searchInfo;
  VideosList _videosList;
  Item _item;
  bool _loading;
  String _videosId;
  int day;



  @override
  void initState() {
    super.initState();
    _loading = true;
    _videosList = VideosList();
    _videosList.videoItems = [];
    //_getSearchInfo();
    //var _userRef = Firestore.instance.collection('videos');
  }

  //ここに記述していいかわからないけどserchinfo実行してvideoslist実行してのクラス作る３分ごとくらいに実行する
  //戻り値をどうするか。クラスをこの辺に定義して

  Future<void> _getSearchInfo(List<dynamic> list) async {
    //ここでfor?
    for(int i = 0; i < list.length; i++) {
      _searchInfo = await Services.searchInfo(channelId: list[i][1]);
      for(int itemIndex = 0; itemIndex < _searchInfo.items.length; itemIndex++) {
        _item = _searchInfo.items[itemIndex];
        _videosId = _item.id.videoId;
        VideoItem videoItem = await _loadVideos();
        //firestoreに追加する処理。でもここに書かずにクラスカ的なやつした方がいいんだろうな
        var documentID = _videosId;
        Firestore.instance.collection('videos')
            .document(documentID)
            .snapshots()
            .listen((snapshot) {
          if (!snapshot.exists) {
            //登録されてない新しいドキュメント
            print(list[i][0]);
            debugPrint('iconUrl: '+ list[i][0]);
            debugPrint('channelTitle: '+ videoItem.videosnippet.channelTitle);
            debugPrint('thumbnailUrl: '+ videoItem.videosnippet.thumbnails
                .medium.url);
            debugPrint('title: '+ videoItem.videosnippet.title);
            debugPrint('videoUrl: '+ _videosId);
            debugPrint('channelUrl: '+list[i][1]);

            Firestore.instance.collection('videos')
                .document(documentID)
                .setData(
                {
                  'iconUrl': list[i][0],
                  'channelTitle': videoItem.videosnippet.channelTitle,
                  'scheduledStartTime': videoItem.liveStreamingDetails
                      .scheduledStartTime,
                  'thumbnailUrl': videoItem.videosnippet.thumbnails
                      .medium.url,
                  'title': videoItem.videosnippet.title,
                  'videoUrl': 'https://www.youtube.com/watch?v=' + _videosId,
                  //配信url
                  'channelUrl': 'https://www.youtube.com/channel/' + list[i][1],
                  //配信urlが取得できなかった時のためにそのライバーのチャンネルに飛ぶようにする
                }
            );
          } else {
            //処理
            Firestore.instance.collection('videos')
                .document(documentID)
                .updateData(
                {
                  'iconUrl': list[i][0],
                  'channelTitle': videoItem.videosnippet.channelTitle,
                  'scheduledStartTime': videoItem.liveStreamingDetails
                      .scheduledStartTime,
                  'thumbnailUrl': videoItem.videosnippet.thumbnails
                      .medium.url,
                  'title': videoItem.videosnippet.title,
                  'videoUrl': 'https://www.youtube.com/watch?v=' + _videosId,
                  //配信url
                  'channelUrl': 'https://www.youtube.com/channel/' + list[i][1],
                  //配信urlが取得できなかった時のためにそのライバーのチャンネルに飛ぶようにする
                }
            );
          }
        });
      }
    }
    print('setstate');
    setState(() {
      _loading = true;
    });
  }

  Future<VideoItem> _loadVideos() async {
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
                _getSearchInfo(list);
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
                _headLine(-1),
                StreamBuilder(
                  stream: Firestore.instance.collection('videos')
                      .where('scheduledStartTime', isGreaterThanOrEqualTo: _dateParam(-1))
                      .where('scheduledStartTime', isLessThan: _dateParam(0))
                      .orderBy("scheduledStartTime").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    return _mainView(snapshot);
                }),
                _headLine(0),
                StreamBuilder(
                    stream: Firestore.instance.collection('videos')
                        .where('scheduledStartTime', isGreaterThanOrEqualTo: _dateParam(0))
                        .where('scheduledStartTime', isLessThan: _dateParam(1))
                        .orderBy("scheduledStartTime").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      return _mainView(snapshot);
                    }),
                _headLine(1),
                StreamBuilder(
                    stream: Firestore.instance.collection('videos')
                        .where('scheduledStartTime', isGreaterThanOrEqualTo: _dateParam(1))
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
      await launch(url);
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
                  //snapshot.data.documents[index]['thumbnailUrl']にhqdefaultがあれば
                  Image(
                    image: CachedNetworkImageProvider(
                      _checkUrl(snapshot.data.documents[index]['thumbnailUrl']),
                    ),
                    fit: BoxFit.cover,
                  ),
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

  Widget _headLine(int param){
    final DateTime today = DateTime.now();
    final DateTime date = DateTime(today.year, today.month, today.day+param, 00, 00);
    final List<String> weekDay = ['月','火','水','木','金','土','日'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50.0,
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(1,4,1,4),
      child: Text("${date.month.toString()}/${date.day.toString()} (${weekDay[date.weekday-1]})",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

