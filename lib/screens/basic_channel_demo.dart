import 'package:channel_demo/channels/basic_channel_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicChannelDemo extends StatefulWidget {
  const BasicChannelDemo({super.key});

  @override
  State<BasicChannelDemo> createState() => _BasicChannelDemoState();
}

class _BasicChannelDemoState extends State<BasicChannelDemo> {
  Future<Uint8List>? imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Channel Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.6,
                child: FutureBuilder<Uint8List>(
                  future: imageData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return const Placeholder();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          (snapshot.error as PlatformException).message!,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.fill,
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: imageData != null
                  ? null
                  : () {
                      setState(() {
                        imageData = BasicChannelImage.getImage();
                      });
                    },
              child: const Text('Get Image'),
            )
          ],
        ),
      ),
    );
  }
}
