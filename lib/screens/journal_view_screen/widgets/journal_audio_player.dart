import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/journal_list_screen/provider/journal_list_provider.dart';
import 'package:mentalhelth/utils/theme/app_decoration.dart';
import 'package:provider/provider.dart';

class JournalAudioPlayer extends StatefulWidget {
  const JournalAudioPlayer({super.key, required this.url});
  final String url;

  @override
  State<JournalAudioPlayer> createState() => _JournalAudioPlayerState();
}

class _JournalAudioPlayerState extends State<JournalAudioPlayer> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  //
  // @override
  // void initState() {
  //   audioPlayer.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       isPlaying = state == PlayerState.playing;
  //     });
  //   });
  //   audioPlayer.onDurationChanged.listen((newDuration) {
  //     setState(() {
  //       duration = newDuration;
  //     });
  //   });
  //   audioPlayer.onPositionChanged.listen((newPosition) {
  //     setState(() {
  //       position = newPosition;
  //     });
  //   });
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: 12,
      ),
      decoration: AppDecoration.fillBlue300.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Consumer<JournalListProvider>(
          builder: (context, journalListProvider, _) {
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                if (isPlaying) {
                  await audioPlayer.pause();
                } else {
                  await audioPlayer.play(UrlSource(widget.url));
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.65,
              child: Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);
                  await audioPlayer.resume();
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
