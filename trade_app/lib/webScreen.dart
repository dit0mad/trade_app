import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/auth.dart';
import 'package:trade_app/welcome_screen.dart';

class WebViewScreen extends StatefulWidget {
  static const String id = 'wb_screen';

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}



String url = 'https://auth.tdameritrade.com/auth?response_type=code&redirect_uri=http%3A%2F%2Flocalhost&client_id=JOTXCGXJMV71GTAWF3EFJR%40AMER.OAUTHAP';



void initState(){

  

}

class _WebViewScreenState extends State<WebViewScreen> {

  //completer holds some value or error and completes it in the future.
  //can temp save it and call completer.complete 
    final  webview = FlutterWebviewPlugin();
    StreamSubscription<String> _onUrlChanged;
    StreamSubscription<WebViewStateChanged> _onStateChanged;

    void dipose(){

      _onStateChanged.cancel();
      _onUrlChanged.cancel();
    }

    void initState(){
      //everytime a widget screen changes, initstate runs
      super.initState();

      

      _onStateChanged = webview.onStateChanged.listen((state){
      print("onStateChanged: ${state.type} ${state.url}");

      });
      _onUrlChanged = webview.onUrlChanged.listen((String ul){

        print(ul);

          if(mounted) {
            setState(() {
              

              if(ul.startsWith('https://localhost/?code=')){

                String grantToken= Uri.decodeComponent(ul.split('code=')[1]);
                Auth(grantToken);
                print(grantToken);
                Provider.of<Auth>(context).postAuthRequest();
                Navigator.of(context).popAndPushNamed(WelcomeScreen.id);
                webview.close();
              }
            });
          }
      });
    }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      withJavascript: true,
      url: url,
      appBar: AppBar(
        title: Text("Login to Ameritrade")
      ),
      );
    
  }
  
}
