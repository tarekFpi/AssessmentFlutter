
import 'dart:isolate';
import 'dart:ui';

import 'package:assessment/core/features/theme/color_scheme.dart';
import 'package:assessment/core/features/utils/hexcolor.dart';
import 'package:assessment/core/features/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class VideoDownloadScreen extends StatefulWidget {
  const VideoDownloadScreen({super.key});

  @override
  State<VideoDownloadScreen> createState() => _VideoDownloadScreenState();
}

class _VideoDownloadScreenState extends State<VideoDownloadScreen> {


  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 's52MdD-lUbs',

    flags: YoutubePlayerFlags(
      autoPlay: true,
    ),
  );

  ReceivePort _receivePort = ReceivePort();
  int progress = 0;

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    sendPort!.send([id, status, progress]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });


    FlutterDownloader.registerCallback(downloadingCallback);
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return SafeArea(child: Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 2,
        title: Text("Video Show", style: textTheme.bodySmall?.copyWith(
            color: lightColorScheme.onTertiaryContainer,
            fontSize: 18,
            fontWeight: FontWeight.w500),),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Card(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  liveUIColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              //foregroundColor: colorScheme.onPrimary,
              backgroundColor: HexColor('#855EA9'),

            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            onPressed: () async{

              final status = await Permission.storage.request();

              if (status.isGranted){

                var externalDi = await getExternalStorageDirectory();

                final id = await FlutterDownloader.enqueue(
                  url:
                  "https://videocdn.bodybuilding.com/video/mp4/62000/62792m.mp4",
                  savedDir: externalDi!.path,
                  fileName: "download",
                  showNotification: true,
                  openFileFromNotification: true,
                );
              }else {

                Toast.errorToast("Permission deined");
              }
            },
            child: Text('Download Mp4', style: textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: lightColorScheme!.onPrimary)),
          ),
        ),
      ),
    ),
    );
  }
}



