import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class audioslider extends StatelessWidget {
  audioslider({super.key,required this.audopplay});
  final int timeprogress = 0;
  final int audioduration = 0;
  final AudioPlayer audopplay;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Slider.adaptive(
        value: (timeprogress / 1000).floorToDouble(),
        max: (audioduration / 1000).floorToDouble(),
        onChanged: (value) {
          seekto(value.toInt());
        },
      ),
    );
  }

  void seekto(int sec) {
    Duration newposition = Duration(seconds: sec);
    audopplay.seek(newposition);
  }
   
}
