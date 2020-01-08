import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:my_webview_project/home_page.dart';
// import 'package:my_webview_project/MyHomePage.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter WebView',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomePage(),
        // home: MyHomePage(),
        // home: WebViewWebPage(),
        home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewWebPage(title: 'Splash Screen Test'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.amberAccent,
            foregroundColor: Colors.red,
            child: Icon(
              Icons.adb,
              size: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}

class WebViewWebPage extends StatefulWidget {
  WebViewWebPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WebViewWebPageState createState() => _WebViewWebPageState();
}

class _WebViewWebPageState extends State<WebViewWebPage> {
 // URL to load
 var URL = "https://surabayajobfair.com/";

 // Webview progress
 double progress = 0;
 
 Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
         title: Text("Webview App"),
       ),
       body: Container(
           child: Column(
               children: <Widget>[
         (progress != 1.0)
             ? LinearProgressIndicator(
                 value: progress,
                 backgroundColor: Colors.grey[200],
                 valueColor: AlwaysStoppedAnimation<Color>(Colors.purple))
             : null,    // Should be removed while showing
         Expanded(
           child: Container(
             child: InAppWebView(
               initialUrl: URL,
               initialHeaders: {},
               initialOptions: {},
               onWebViewCreated: (InAppWebViewController controller) {
               },
               onLoadStart: (InAppWebViewController controller, String url) {
               },
               onProgressChanged:
                   (InAppWebViewController controller, int progress) {
                 setState(() {
                   this.progress = progress / 100;
                 });
               },
             ),
           ),
         )
       ].where((Object o) => o != null).toList())));  //Remove null widgets
  }
}