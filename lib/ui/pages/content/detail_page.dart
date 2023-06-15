import 'package:flutter/material.dart';
import 'package:hionepedia/providers/favorite_provider.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hive/hive.dart';
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
  String userActive = '';

  @override
  void initState() {
    final myBox = Hive.box('userBox');
    userActive = myBox.get('userActive')[0];
    Provider.of<FavoriteProvider>(context, listen: false)
        .getFavoriteData(userActive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    final audioPlayer = AudioPlayer();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[50],
                    boxShadow: [
                      BoxShadow(
                        color: blackColor,
                        offset: const Offset(5, 5),
                        blurRadius: 20,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 20,
                      )
                    ]),
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
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                        icon: Image.asset('assets/icon/sound.png')),
                    IconButton(
                        onPressed: () async {
                          favProvider.toggleFavorite(
                              userActive, widget.animalData.animalId);
                        },
                        icon: favProvider.favoriteItem
                                .containsKey(widget.animalData.animalId)
                            ? Image.asset('assets/icon/favorite.png')
                            : const Icon(
                                Icons.favorite,
                                color: Colors.grey,
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
      ),
    );
  }
}
