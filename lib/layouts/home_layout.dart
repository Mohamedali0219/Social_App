import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconoir_ttf/flutter_iconoir_ttf.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/social_cubit/social_cubit.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/screens/new_post.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigatTo(context, const NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconoirIcons.appNotification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconoirIcons.search),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconoirIcons.home),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconoirIcons.chatPlusIn),
                  label: 'chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconoirIcons.cloudUpload),
                  label: 'post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconoirIcons.mapPinPlus),
                  label: 'users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconoirIcons.settings),
                  label: 'settings',
                ),
              ]),
        );
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
