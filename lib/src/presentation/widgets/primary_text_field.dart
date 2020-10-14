import 'package:flutter/material.dart';

final kPrimaryTextFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: BorderSide(color: Colors.white),
);

class PrimaryTextField extends StatefulWidget {
  final Function(String) onChanged;
  final String errorText;
  final bool obscureText;
  final bool toogleObscureText;

  PrimaryTextField({
    Key key,
    @required this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.toogleObscureText,
  }) : super(key: key);

  @override
  _PrimaryTextFieldState createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      decoration: _inputDecoration(textTheme),
      onChanged: widget.onChanged,
      obscureText:
          widget.toogleObscureText == true ? isObscureText : widget.obscureText,
    );
  }

  InputDecoration _inputDecoration(TextTheme textTheme) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      border: kPrimaryTextFieldBorder,
      enabledBorder: kPrimaryTextFieldBorder,
      focusedBorder: kPrimaryTextFieldBorder,
      errorBorder: kPrimaryTextFieldBorder,
      focusedErrorBorder: kPrimaryTextFieldBorder,
      errorStyle: textTheme.caption.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      errorText: widget.errorText,
      suffixIcon: widget.toogleObscureText == true
          ? IconButton(
              icon: Icon(
                isObscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
            )
          : null,
    );
  }
}
