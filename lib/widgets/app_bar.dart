import 'package:expence_manager/Components/theme/appbar.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final isDark;

  CustomAppBar({required this.title, required this.onBackPressed, this.isDark});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: isDark
          ? themeAppbar.darkAppbarTheme.iconTheme
          : themeAppbar.lightAppBarTheme.iconTheme,
      titleTextStyle: isDark
          ? themeAppbar.darkAppbarTheme.titleTextStyle
          : themeAppbar.lightAppBarTheme.titleTextStyle,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: onBackPressed,
      ),
      title: Text(title,
          style: isDark
              ? themeAppbar.darkAppbarTheme.titleTextStyle
              : themeAppbar.lightAppBarTheme.titleTextStyle),
      centerTitle: true,
      //  backgroundColor: Colors.white, // You can customize the background color
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
