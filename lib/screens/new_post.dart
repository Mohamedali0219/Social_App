import 'package:flutter/material.dart';
import 'package:social_app/widgets/custom_appbar.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Editi Profile',
      ),
    );
  }
}
