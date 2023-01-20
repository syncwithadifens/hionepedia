import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hionepedia/services/http_service.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:just_audio/just_audio.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.animalData});
  final dynamic animalData;

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.amber),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: 300,
                child: ModelViewer(
                  src: '${HttpService.apiUrl}/model/${animalData.model}',
                  alt: '${animalData.name}',
                  ar: true,
                  autoRotate: true,
                  cameraControls: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${animalData.name}',
                      style: fontTeks.copyWith(fontSize: 24),
                    ),
                    IconButton(
                        onPressed: () {
                          audioPlayer.setUrl(
                              '${HttpService.apiUrl}/sound/${animalData.sound}');
                          audioPlayer.play();
                        },
                        icon: Image.asset('assets/icons/sound.png'))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text('${animalData.description}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
