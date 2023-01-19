import 'package:flutter/material.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:just_audio/just_audio.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();
    return Scaffold(
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
                src:
                    'http://192.168.10.102:8000/storage/3d-assets/63c68f5e6f113.glb',
                alt: "A 3D model of an astronaut",
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
                    'Astrounot',
                    style: fontTeks,
                  ),
                  IconButton(
                      onPressed: () {
                        audioPlayer.setUrl(
                            'http://192.168.10.102:8000/storage/animal-sound/63c68f5eb1c63.mp3');
                        audioPlayer.play();
                      },
                      icon: Image.asset('assets/icons/sound.png'))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using "Content here, content here", making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for "lorem ipsum" will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'),
            )
          ],
        ),
      ),
    );
  }
}
