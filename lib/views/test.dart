import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class TestPusher extends StatefulWidget {
  const TestPusher({super.key});

  @override
  State<TestPusher> createState() => _TestPusherState();
}

class _TestPusherState extends State<TestPusher> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    ss();
    super.initState();
  }

  void ss() async {
    await pusher.init(
      apiKey: '40178e8c6a9375e09f5c',
      cluster: 'ap1',
    );
    await pusher.connect();
    await pusher.subscribe(channelName: "test", onEvent: onEvent);
  }

  int d = 0;
  void onEvent(dynamic event) {
    setState(() {
      ++d;
    });
    print("onEvent: $event");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                pusher.disconnect();
              },
              child: Text('Disconnebt')),
          Text(d.toString()),
        ],
      )),
    );
  }
}
