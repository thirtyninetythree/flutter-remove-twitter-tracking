import 'package:flutter/material.dart';

import 'package:clipboard_monitor/clipboard_monitor.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _clipboardText = "";
  final controller = TextEditingController();
  bool isTwitterLink = false;

  @override
  void initState() {
    super.initState();
    controller.text = 'Copy some text from here.\n1234 5678';
    ClipboardMonitor.registerCallback(onClipboardText);
  }

  @override
  void dispose() {
    ClipboardMonitor.unregisterCallback(onClipboardText);
    super.dispose();
  }

  void startClipboardMonitor() {
    ClipboardMonitor.registerCallback(onClipboardText);
  }

  void stopClipboardMonitor() {
    ClipboardMonitor.unregisterCallback(onClipboardText);
  }

  void onClipboardText(String text) {
    setState(() {
      _clipboardText = text;
      isTwitterLink =
          text.contains(RegExp("(twitter.com)")) && text.contains("?");
    });
  }

  void stopAllClipboardMonitoring() {
    ClipboardMonitor.unregisterAllCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    int times = 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FICHA: REMOVE TRACKING",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  if (!isTwitterLink) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("This is not a twitter link")));
                    return;
                  }

                  await Clipboard.setData(
                      ClipboardData(text: _clipboardText.split("?")[0]));

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Tracker removed and link copied")));
                },
                child: const Text("REMOVE TRACKER AND COPY LINK")),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
