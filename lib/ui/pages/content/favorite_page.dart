import 'package:flutter/material.dart';
import 'package:hionepedia/providers/favorite_provider.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/content/detail_page.dart';
import 'package:hionepedia/ui/widgets/error.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return favoriteProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : favoriteProvider.isSuccess
            ? RefreshIndicator(
                onRefresh: () {
                  return favoriteProvider.getFavoriteData(userActive);
                },
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Text(
                        'Favorite',
                        style: titleStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          favoriteProvider.favoriteData!.favorited!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  animalData: favoriteProvider
                                      .favoriteData!.favorited![index],
                                ),
                              )),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: blackColor,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.network(
                                      '${ApiRepository.apiUrl}/img/${favoriteProvider.favoriteData!.favorited![index].thumbnail}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                          'assets/icon/favorite.png',
                                          width: 30,
                                        ),
                                      ))
                                ],
                              )),
                        );
                      },
                    )
                  ],
                ),
              )
            : const IsError();
  }
}
