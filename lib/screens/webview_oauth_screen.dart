import 'dart:async';
import 'dart:convert';
import 'package:explorak5/api/authentication_api.dart';
import 'package:explorak5/models/user_data.dart';
import 'package:explorak5/screens/courses_screen.dart';
import 'package:explorak5/services/authentication_client.dart';
import 'package:explorak5/helpers/http_constants.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import '../api/user_api.dart';

class WebviewOauthScreen extends StatefulWidget {
  @override
  _WebviewOauthScreenState createState() => _WebviewOauthScreenState();
}

class _WebviewOauthScreenState extends State<WebviewOauthScreen> {
  late StreamController<String> someStreamController;
  late StreamSubscription _onDestroy;
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;
  String code;
  String grantType = "authorization_code";
  String loginUrl;
  final _authenticationAPI = GetIt.instance<AuthenticationAPI>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  static final _userAPI = GetIt.instance<UserAPI>();
  var isConnected = true;
  late FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  void initState() {
    super.initState();
    
    someStreamController = StreamController<String>();
    _onDestroy = StreamController().stream.listen((event) {});
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {});
    _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {});

    flutterWebviewPlugin = FlutterWebviewPlugin();
    // Other initState logic
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    someStreamController.close();
    super.dispose();
  }

    // Add a listener to on url changed
    _onUrlChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (mounted) {
        if (url.contains('code=')) {
          flutterWebviewPlugin.hide();
          flutterWebviewPlugin.stopLoading();
          code = url.substring(url.indexOf("code=") + 5);
          FormData formData = FormData.fromMap({
            "code": code,
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "redirect_uri": REDIRECT_URI,
            "grant_type": grantType
          });
          final response = await _authenticationAPI.getToken(formData);
          if (response.data != null) {
            print(response.data);
            final sessionData = json.decode(response.data);
            final jsonImage =
                await _userAPI.getUserData(sessionData["access_token"]);
            sessionData["user_image"] = jsonImage.data["avatar_url"];
            final userData = UserData.fromJson(sessionData);
            await _authenticationClient.saveSession(userData);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CoursesScreen()),
                (_) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Algo anda mal, intente después",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.of(context).pop();
          }
          flutterWebviewPlugin.close();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: loginUrl,
      appBar: new AppBar(
        title: new Text("Iniciar Sesión"),
        centerTitle: true,
      ),
      clearCookies: true,
    );
  }
}
