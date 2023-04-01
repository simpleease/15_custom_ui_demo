import 'package:flutter/material.dart';
import 'dart:math';
import 'package:date_format/date_format.dart';


void main() {
  print(formatDate(DateTime.now(), [mm, '月', dd, '日', hh, ':', n]));//输出2019年06月30日01:56
  print(formatDate(DateTime.now(), [m, '月第', w, '周']));//输出6月第5周
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  => MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.lightBlue[800],//主题色为蓝色
    ),
    home: MyHomePage(title: 'Custom UI'),
  );

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState()=>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  //使用控制Tabbar切换
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.system_update),text: "组合"),
            Tab(icon: Icon(Icons.cake),text: "自绘")
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView(
            children: <Widget>[
              UpdatedItemWidget(model: UpdatedItemModel(
                  appIcon:"assets/icon.png",
                  appDescription:"Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
                  appName: "Google Maps - Transit & Fond",
                  appSize: "137.2",
                  appVersion: "Version 5.19",
                  appDate: "2019年6月5日"
              ), onPressed: () {},
              )
            ],
          ),
          Center(child: Cake())
        ],
      ),
    );

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class UpdatedItemModel {
  String appIcon;
  String appName;
  String appSize;
  String appDate;
  String appDescription;
  String appVersion;
  UpdatedItemModel({this.appIcon, this.appName, this.appSize, this.appDate, this.appDescription, this.appVersion});

}

class UpdatedItemWidget extends StatelessWidget {
  final UpdatedItemModel model;
  UpdatedItemWidget({Key key,this.model, this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    //组合上下两部分
    return Column(
        children: <Widget>[
          buildTopRow(context),
          buildBottomRow(context)
        ]);
  }

  //创建上半部分
  Widget buildTopRow(BuildContext context) {
    return Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(model.appIcon, width: 80,height:80)
              )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.appName,maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: Color(0xFF8E8D92)),),
                Text("${model.appDate}",maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16, color: Color(0xFF8E8D92)),),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0,0,10,0),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFF1F0F7),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
              child: Text("OPEN", style: TextStyle(color:Color(0xFF007AFE),fontWeight: FontWeight.bold),),
              onPressed: onPressed,
            ),
          )
        ]);

  }
  //创建下半部分
  Widget buildBottomRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15,0,15,0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(model.appDescription, maxLines: null, overflow: TextOverflow.visible,),
              Padding(
                  padding: EdgeInsets.fromLTRB(0,10,0,0),
                  child: Text("${model.appVersion} • ${model.appSize} MB")
              )
            ]
        )
    );
  }
}




class Cake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter(),
    );
  }
}

class WheelPainter extends CustomPainter {
  //设置画笔颜色
  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //饼图尺寸
    double wheelSize = min(size.width, size.height)/2;
    List clrs = [
      Colors.orange, Colors.orange[50], Colors.black38, Colors.black54,  Colors.green[50],
      Colors.red, Colors.red[50], Colors.blue, Colors.blue[50], Colors.pink, Colors.pink[50],
    ];
    int nbElem = clrs.length; //6;
    double radius = (2 * pi) / nbElem;
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);

    double start = 0;
    for(int i = 0; i < nbElem; ++i) {
      canvas.drawArc(boundingRect, start, radius, true, getColoredPaint(clrs[i]));
      start += radius;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

