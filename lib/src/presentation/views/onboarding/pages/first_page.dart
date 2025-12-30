import 'package:flutter/material.dart';
import 'package:money_scope/src/core/config/generated/assets.gen.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.images.moneyScope.image(),
        Text("Toke Control Of\nYour Finances"),
        Row(children: [
        //  Icon(Icons.financ)
        ],)
      ],
    );
  }
}
