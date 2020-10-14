import 'package:flutter/material.dart';

class ViewMoreScreenArguments {
  final String appBarTitle;

  ViewMoreScreenArguments({
    this.appBarTitle,
  });
}

class ViewMoreScreen<T> extends StatelessWidget {
  const ViewMoreScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ViewMoreScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.appBarTitle),
      ),
      body: Container(),
    );
  }
}
