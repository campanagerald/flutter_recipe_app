import 'package:flutter/material.dart';

class PrimayButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const PrimayButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FlatButton(
      color: theme.accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        text,
        style: theme.textTheme.headline6.copyWith(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
