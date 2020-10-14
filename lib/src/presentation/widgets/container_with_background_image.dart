import 'package:flutter/material.dart';

class ContainerWithBackgroundImage extends StatelessWidget {
  final Widget child;
  final ImageProvider<dynamic> image;
  final double height;
  final double width;
  final BoxFit fit;

  const ContainerWithBackgroundImage({
    Key key,
    @required this.image,
    @required this.child,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: fit ?? BoxFit.cover,
          image: image,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), BlendMode.srcATop),
        ),
      ),
      child: child,
    );
  }
}
