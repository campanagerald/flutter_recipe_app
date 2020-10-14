import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return SafeArea(
    //   child: LayoutBuilder(
    //     builder: (context, constraints) => Padding(
    //       padding: EdgeInsets.symmetric(
    //         horizontal: constraints.maxWidth * 0.04,
    //         vertical: constraints.maxHeight * 0.02,
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           _buildSearchBar(context),
    //           ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: recipeList.length,
    //             itemBuilder: (context, index) {
    //               final recipe = recipeList[index];

    //               return Container(
    //                 padding: const EdgeInsets.all(8.0),
    //                 decoration: BoxDecoration(
    //                   border: Border(
    //                     bottom:
    //                         BorderSide(color: Colors.black.withOpacity(0.1)),
    //                   ),
    //                 ),
    //                 child: ListTile(
    //                   title: Text(recipe.title),
    //                   subtitle: Text('208 saves'),
    //                   leading: Container(
    //                     height: constraints.maxWidth * 0.3,
    //                     width: constraints.maxWidth * 0.2,
    //                     decoration: BoxDecoration(
    //                       boxShadow: [
    //                         BoxShadow(
    //                             blurRadius: 4,
    //                             offset: Offset(1, 3),
    //                             color: Colors.black.withOpacity(0.5)),
    //                       ],
    //                     ),
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(10),
    //                       child: Image.network(
    //                         recipe.imageUrl,
    //                         fit: BoxFit.cover,
    //                         loadingBuilder: (BuildContext context, Widget child,
    //                             ImageChunkEvent loadingProgress) {
    //                           if (loadingProgress == null) return child;
    //                           return Center(
    //                             child: CircularProgressIndicator(
    //                               value: loadingProgress.expectedTotalBytes !=
    //                                       null
    //                                   ? loadingProgress.cumulativeBytesLoaded /
    //                                       loadingProgress.expectedTotalBytes
    //                                   : null,
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             },
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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
                hintText: 'Search your favorites',
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
}
