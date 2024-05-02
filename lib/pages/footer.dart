import 'package:flutter/material.dart';

class BottomFooter extends StatelessWidget {
  const BottomFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            "Black & Black",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
