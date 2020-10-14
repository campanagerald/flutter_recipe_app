import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/authentication/authentication_cubit.dart';
import '../../business_logic/cubit/recipes/recipes_cubit.dart';

class HomeTab extends StatefulWidget {
  final Function() avatarOnPressed;

  const HomeTab({
    Key key,
    this.avatarOnPressed,
  }) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final scrollController = ScrollController();
  var _refreshCompleter = Completer<void>();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.bloc<RecipesCubit>().loadMoreRecipes();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Column(
              children: [
                _buildHeader(context),
                SizedBox(height: height * 0.02),
                _buildSearchBar(context),
                SizedBox(height: height * 0.02),
                BlocConsumer<RecipesCubit, RecipesState>(
                  listener: (_, state) {
                    if (state is RecipesLoaded) {
                      if (!state.loadingMore) {
                        _refreshCompleter?.complete();
                        _refreshCompleter = Completer<void>();
                      }
                    }
                  },
                  builder: (_, state) {
                    if (state is RecipesLoading) {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is RecipesLoaded) {
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.bloc<RecipesCubit>().reloadRecipes();
                            return _refreshCompleter.future;
                          },
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: state.recipes.length + 1,
                            itemBuilder: (_, index) {
                              if (index < state.recipes.length) {
                                final recipe = state.recipes[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Container(
                                    height: height * 0.2,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(2,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: SizedBox(
                                            height: height * 0.2,
                                            width: height * 0.25,
                                            child: recipe.imageUrl != null
                                                ? Image.network(
                                                    recipe.imageUrl,
                                                    loadingBuilder: (
                                                      BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent
                                                          loadingProgress,
                                                    ) {
                                                      if (loadingProgress ==
                                                          null)
                                                        return FittedBox(
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: child),
                                                        );

                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text('No image'),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 7, vertical: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  recipe.title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.timer,
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                    SizedBox(width: 5),
                                                    Text(
                                                        '${recipe.readyInMinutes} min'),
                                                    Spacer(),
                                                    Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (state.loadingMore) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    }

                    return SizedBox();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Theme(
            data: Theme.of(context)
                .copyWith(primaryColor: Colors.black.withOpacity(0.5)),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Find recipes',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                prefixIcon:
                    Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
                fillColor: Colors.grey.shade200,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
            color: Theme.of(context).accentColor,
          ),
          splashColor: Colors.transparent,
          onPressed: () {},
        ),
      ],
    );
  }

  Row _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Authenticated authBlocState =
        context.bloc<AuthenticationCubit>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning',
              style: textTheme.headline6.copyWith(color: Colors.black45),
            ),
            Text(
              '${authBlocState.currentUser.firstName} ${authBlocState.currentUser.lastName}',
              style: textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        GestureDetector(
          onTap: widget.avatarOnPressed,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profic_pic.jpg'),
          ),
        )
      ],
    );
  }
}
