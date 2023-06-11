import 'package:flutter/material.dart';
import 'package:hionepedia/providers/favorite_provider.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.animalData});

  final dynamic animalData;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    Provider.of<FavoriteProvider>(context, listen: false).getFavoriteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
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
              child: widget.animalData.offline == 'no'
                  ? ModelViewer(
                      src:
                          '${ApiRepository.apiUrl}/model/${widget.animalData.model}',
                      alt: "A 3D model of an animal",
                      ar: true,
                      autoRotate: true,
                      cameraControls: true,
                    )
                  : ModelViewer(
                      src: 'assets/model/${widget.animalData.model}',
                      alt: "A 3D model of an animal",
                      ar: true,
                      autoRotate: true,
                      cameraControls: true,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${widget.animalData.name}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        audioPlayer.setUrl(
                            '${ApiRepository.apiUrl}/sound/${widget.animalData.sound}');
                        audioPlayer.play();
                      },
                      icon: const Icon(Icons.headphones)),
                  IconButton(
                      onPressed: () async {
                        favProvider.toggleFavorite(widget.animalData.animalId);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: favProvider.favoriteItem
                                .containsKey(widget.animalData.animalId)
                            ? Colors.red
                            : Colors.grey,
                      ))
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
                '${widget.animalData.description}',
                textAlign: TextAlign.justify,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
