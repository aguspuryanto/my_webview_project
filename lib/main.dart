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
        home: WebViewWebPage()
    );
  }
}

class WebViewWebPage extends StatefulWidget {
 @override
 _WebViewWebPageState createState() => _WebViewWebPageState();
}
class _WebViewWebPageState extends State<WebViewWebPage> {
 // URL to load
 var URL = "https://surabayajobfair.com/";

 // Webview progress
 double progress = 0;
 
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