import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({super.key, 
    required this.title,
    this.backgroundColor = const Color(0xFF0D47A1),
    this.actions = const[],
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      leading: null,
      // flexibleSpace: bottom,
      actions: actions,
      bottom: bottom,
      // bottom: content != null
      //   ? PreferredSize(
      //       preferredSize: const Size.fromHeight(100), 
      //       child: content!)
      //   : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height);
}