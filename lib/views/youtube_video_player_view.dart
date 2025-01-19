import 'package:flutter/material.dart';
import 'package:tentwenty_task/utils/color_palatte.dart';
import 'package:tentwenty_task/widgets/my_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatelessWidget {
  String youtubeVideoKey;
   YoutubePlayerScreen(this.youtubeVideoKey,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: youtubeVideoKey,
      flags:const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.black,
        body: WillPopScope(
          onWillPop: (){
            _controller.dispose();
           return Future.value(true);
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {
                // _controller.addListener(listener);
                },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    _controller.dispose();
                    Navigator.pop(context);
                  }, child: MyText("Done",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.white_F6F6FA,
                  ))
                ],),
            ],
          ),
        ),


      ),
    );
  }
}
