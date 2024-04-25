import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/social_cubit/social_cubit.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News Feed',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            body: ConditionalBuilder(
                condition: SocialCubit.get(context).userData != null,
                builder: (context) {
                  return Column(
                    children: [],
                  );
                },
                fallback: (context) {
                  return const Center(child: CircularProgressIndicator());
                }));
      },
    );
  }
}

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.amber.withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(children: [
          const Icon(
            Icons.info_rounded,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text('please verify your email'),
          ),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser!.sendEmailVerification().then(
                (value) {
                  showSnakBar(context, Colors.amber, 'please check your email');
                },
              );
            },
            child: const Text('send'),
          ),
        ]),
      ),
    );
  }
}
