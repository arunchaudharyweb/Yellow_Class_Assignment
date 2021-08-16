import 'package:flutter/material.dart';

class EmptyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.width / 2.5,
          child: Image.asset(
            'assetImages/defaultImage.png',
          ),
        ),
        SizedBox(
          height: 20,
          width: double.infinity,
        ),
        Text(
          'Add your movie\'s collection.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
          ),
        ),
        // SizedBox(
        //   height: 20,
        // )
      ],
    );
  }
}
