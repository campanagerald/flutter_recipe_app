import 'package:flutter/material.dart';

class ViewMoreBar extends StatelessWidget {
  final Function() viewMoreOnTap;
  final String title;

  const ViewMoreBar({
    Key key,
    @required this.viewMoreOnTap,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: viewMoreOnTap,
          child: Row(
            children: [
              Text('View More'),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        )
      ],
    );
  }
}
