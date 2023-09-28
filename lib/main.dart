import 'package:channel_demo/screens/basic_channel_demo.dart';
import 'package:channel_demo/screens/binary_message_demo.dart';
import 'package:channel_demo/screens/event_channel_demo.dart';
import 'package:channel_demo/screens/method_channel_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("Platform Channels"),
      ),
      body: Center(
        child: ListView(
          children:  [
            ListTile(
              title: const Text("Binary Message"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const BinaryMessageDemo()));
              },
            ),
            ListTile(
              title: const Text("MethodChannel"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const MethodChannelDemo()));
              },
            ),
            ListTile(
              title: const Text("EventChannel"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const EventChannelDemo()));
              },
            ),
            ListTile(
              title: const Text("BasicMessageChannel"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const BasicChannelDemo()));
              },
            ),
          ],
        )
      ),
    );
  }
}
