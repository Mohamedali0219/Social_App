import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconoir_ttf/flutter_iconoir_ttf.dart';
import 'package:social_app/cubites/social_cubit/social_cubit.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/widgets/custom_appbar.dart';
import 'package:social_app/widgets/defult_text_formfield.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final bioController = TextEditingController();
    final phoneController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userDate = SocialCubit.get(context).userModel!;
        var profileImage = SocialCubit.get(context).profileImage;
        var corverImage = SocialCubit.get(context).coverImage;

        nameController.text = userDate.name!;
        bioController.text = userDate.bio!;
        phoneController.text = userDate.phone!;
        return Scaffold(
          appBar:
              customAppBar(context: context, title: 'Editi Profile', actions: [
            IconButton(
              onPressed: () {
                SocialCubit.get(context).updateUser(
                  name: nameController.text,
                  bio: bioController.text,
                  phone: phoneController.text,
                );
              },
              icon: Row(
                children: [
                  Text('Edit',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingState)
                  const LinearProgressIndicator(),
                SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: corverImage == null
                                      ? NetworkImage(userDate.cover!)
                                      : FileImage(corverImage) as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const Icon(IconoirIcons.camera)),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 74,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(
                                      userDate.image!,
                                    )
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(IconoirIcons.camera)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                defultTextFormField(
                  controller: nameController,
                  hintText: 'Name',
                  prefixIcon: IconoirIcons.user,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                defultTextFormField(
                    controller: bioController,
                    hintText: 'Bio',
                    prefixIcon: IconoirIcons.infoCircle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your bio';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                defultTextFormField(
                    controller: phoneController,
                    hintText: 'phone',
                    prefixIcon: IconoirIcons.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your phone';
                      }
                      return null;
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
