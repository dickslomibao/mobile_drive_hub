import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;
import '../constant/url.dart';

class PusherServices {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  Future<void> init({String token = ""}) async {
    try {
      await pusher.init(
        apiKey: pusherKey,
        cluster: 'ap1',
        authEndpoint: "${API_URL}broadcasting/auth",
        onAuthorizer:
            (String channelName, String socketId, dynamic options) async {
          var authUrl = "${API_URL}broadcasting/auth";
          var result = await http.post(
            Uri.parse(authUrl),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer ${token}',
            },
            body: 'socket_id=' + socketId + '&channel_name=' + channelName,
          );
          debugPrint("${result.body}");
          var json = jsonDecode(result.body);

          debugPrint("$json");
          return json;
        },
      );
      await pusher.connect();
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<PusherChannelsFlutter> getPusher() async {
    return pusher;
  }
}

PusherServices pusherServices = PusherServices();
