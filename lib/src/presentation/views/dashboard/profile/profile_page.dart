import 'package:flutter/material.dart';
import 'package:money_scope/src/core/config/generated/assets.gen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          spacing: 10,
          children: [

            CircleAvatar(
             backgroundImage: Assets.images.moneyScope.provider() ,
            )

          ],
        ),
      ),
    );
  }
}
