import 'package:flutter/material.dart';
import 'package:hionepedia/providers/favorite_provider.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:hionepedia/ui/pages/detail_page.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    Provider.of<FavoriteProvider>(context, listen: false).getFavoriteData();
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
            ? ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text(
                      'Favorite',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favoriteProvider.favoriteData!.favorited!.length,
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.amber),
                            child: Image.network(
                                '${ApiRepository.apiUrl}/img/${favoriteProvider.favoriteData!.favorited![index].thumbnail}')),
                      );
                    },
                  )
                ],
              )
            : const Center(
                child: Text(
                  'Oopsie.. \nServer sedang bermasalah',
                  style: TextStyle(fontSize: 18),
                ),
              );
  }
}
