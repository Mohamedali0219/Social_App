import 'package:flutter/material.dart';
import 'package:flutter_iconoir_ttf/flutter_iconoir_ttf.dart';

customAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(IconoirIcons.navArrowLeft)),
    titleSpacing: 0.0,
    title: Text(title ?? ''),
    actions: actions,
  );
}
