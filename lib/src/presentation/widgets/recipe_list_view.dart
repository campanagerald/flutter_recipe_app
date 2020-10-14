import 'package:flutter/material.dart';

import '../../data/models/recipe_model.dart';
import '../screens/detail_screen.dart';

class RecipeHorizontalListView extends StatelessWidget {
  final double itemWidth;
  final double imageAspectRatio;
  final double containerHeight;

  final List<RecipeModel> recipeList;

  const RecipeHorizontalListView({
    Key key,
    @required this.itemWidth,
    @required this.imageAspectRatio,
    @required this.containerHeight,
    @required this.recipeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      child: recipeList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recipeList.length,
              itemBuilder: (context, index) {
                final recipe = recipeList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, DetailScreen.routeName,
                        arguments: recipe),
                    child: Column(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: imageAspectRatio,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                recipe.imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: itemWidth,
                          child: Text(
                            recipe.title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
