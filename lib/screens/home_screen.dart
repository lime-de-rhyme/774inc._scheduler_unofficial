import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';
import 'package:share/share.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  //int day;
  String text;

  Future<QuerySnapshot> yesterday;
  Future<QuerySnapshot> today;
  Future<QuerySnapshot> nextDay;
  double headLineHeight = 50.0;

  //childAspectRatioを機種の横幅に応じて変更するようにする


  @override
  void initState() {
    loading();
    super.initState();
  }


  Future<QuerySnapshot> getSnapshot(int param) async {
    if (param == 1){
      QuerySnapshot snapshot = await Firestore.instance.collection('videos')
          .where('scheduledStartTime', isGreaterThanOrEqualTo: _dateParam(streamParam() + param))
          .orderBy("scheduledStartTime").getDocuments();
      print(snapshot.documents.length);
      return snapshot;
    } else {
      QuerySnapshot snapshot = await Firestore.instance.collection('videos')
          .where('scheduledStartTime',
          isGreaterThanOrEqualTo: _dateParam(streamParam() + param))
          .where('scheduledStartTime',
          isLessThan: _dateParam(streamParam() + param + 1))
          .orderBy("scheduledStartTime").getDocuments();
      print(snapshot.documents.length);
      return snapshot;
    }
  }

  loading(){
    yesterday = getSnapshot(-1);
    today = getSnapshot(0);
    nextDay = getSnapshot(1);
    setState(() {});
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
                loading();
              }),
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.blueGrey[800],
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.blueGrey[800],
                  child: Text('Menu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        //fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )
                  ),
                ),

                Card(
                  color: Colors.blueGrey[800],
                  child: ListTile(
                    title: Text('Share on Twitter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Share.share('#774inc. schedule【非公式】 appstoreのページ');
                    },
                  ),
                ),
                Card(
                  color: Colors.blueGrey[800],
                  child: ListTile(
                    title: Text('Contact the developer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text('アプリの改善要望・こんなアプリがあれば等DMにてお待ちしております',
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    onTap: () {
                      _launchURL('https://twitter.com/rokosurokosu', 'https://twitter.com/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          //左右padding
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _headLine(streamParam()-1),
                FutureBuilder<QuerySnapshot>(
                  future: yesterday,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return _mainView(snapshot);
                }),
                _headLine(streamParam()+0),
                FutureBuilder<QuerySnapshot>(
                    future: today,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.data == null) {
                        return empty();
                      } else if(snapshot.data.documents.length == 0){
                        return empty();
                      } else{
                        return _mainView(snapshot);
                      }
                    }),
                _headLine(streamParam()+1),
                FutureBuilder<QuerySnapshot>(
                    future: nextDay,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.data == null) {
                        return empty();
                      } else if(snapshot.data.documents.length == 0){
                        return empty();
                      } else{
                        return _mainView(snapshot);
                      }
                      /*
                      if (snapshot.data.documents.length > 0) {
                        return _mainView(snapshot);
                      } else{
                        return empty();
                      }
                       */
                    }),
              ],
            ),
          ),
        ),
      );
  }

  empty(){
    return Container(
      child: Text("配信待機所はまだありません",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),),
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

  childAspectRatio(){
    final double width = MediaQuery.of(context).size.width;
    print(width);
    if(width == 428){
      return 0.84;
    } else if(width == 414){
      return 0.82;
    } else if(width == 390){
      return 0.79;
    } else if(width == 375){
      return 0.78;
    } else{
      return 0.77;
    }
    //pro max 428/2=208 214:0.84
    //8plus 414:0.82
    //12pro 390/2=189 195:0.79
    //mini  375/2=181.5 187:0.78
  }

  _mainView(var snapshot){
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 2,
        childAspectRatio: childAspectRatio(),
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
}
