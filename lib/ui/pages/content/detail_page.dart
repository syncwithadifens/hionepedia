import 'package:flutter/material.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.animalData});

  final dynamic animalData;
  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey),
              child: animalData.offline == 'no'
                  ? ModelViewer(
                      src: '${ApiRepository.apiUrl}/model/${animalData.model}',
                      alt: "A 3D model of an astronaut",
                      ar: true,
                      autoRotate: true,
                      cameraControls: true,
                    )
                  : ModelViewer(
                      src: 'assets/model/${animalData.model}',
                      alt: "A 3D model of an astronaut",
                      ar: true,
                      autoRotate: true,
                      cameraControls: true,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${animalData.name}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {
                        audioPlayer.setUrl(
                            '${ApiRepository.apiUrl}/sound/${animalData.sound}');
                        audioPlayer.play();
                      },
                      icon: const Icon(Icons.headphones))
                ],
              ),
            ),
            const Text(
              'Deskripsi',
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '${animalData.description}',
                textAlign: TextAlign.justify,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
