import 'package:flutter/material.dart';
import 'package:recipe_app/src/data/models/recipe_model.dart';

import '../widgets/video_player.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final RecipeModel recipe;

  const DetailScreen({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.title,
          style: Theme.of(context).textTheme.headline6.copyWith(
                letterSpacing: 0.1,
              ),
        ),
        leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: recipe.isFavorite
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/sign_in_background_image.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.96), BlendMode.screen),
            ),
          ),
          child: Column(
            children: [
              VideoPlayer(
                  type: VideoPlayerType.asset,
                  videoUrl: 'assets/videos/video.mp4'),
              SizedBox(height: constraints.maxHeight * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: constraints.maxWidth * 0.02,
                      left: constraints.maxWidth * 0.05,
                      right: constraints.maxWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${Duration(minutes: recipe.readyInMinutes.toInt()).toString()}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Icon(Icons.timer),
                            SizedBox(width: 20),
                            Text(
                              '${recipe.servings} servings',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Icon(Icons.pie_chart),
                          ],
                        ),
                        Text(
                          'Ingredients',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        ...List.generate(
                          recipe.ingredients.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: new BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: constraints.maxHeight * 0.02),
                                Text(
                                  recipe.ingredients[index].name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Steps',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        ...List.generate(
                          recipe.steps.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * 0.01),
                            child: Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text('${index + 1})'),
                                SizedBox(
                                  width: constraints.maxWidth * 0.01,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth -
                                      constraints.maxWidth * 0.14,
                                  child: Text(
                                    recipe.steps[index],
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
