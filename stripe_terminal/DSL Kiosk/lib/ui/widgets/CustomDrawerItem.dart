import 'package:flutter/material.dart';

import 'CustomeWidgets.dart';
class CustomDrawerItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onTap;

  const CustomDrawerItem({
    Key? key,
    this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(

      trailing:Icon(Icons.navigate_next,color: Colors.white,) ,
      leading: Customewidgets.bgcoloricon2(icon!),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}