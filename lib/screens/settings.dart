import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconoir_ttf/flutter_iconoir_ttf.dart';
import 'package:social_app/cubites/social_cubit/social_cubit.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/model/user_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel userDate = SocialCubit.get(context).model!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
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
                            image: NetworkImage(userDate.cover!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 74,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                          userDate.image!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                userDate.name!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
              Text(
                userDate.bio!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          'posts',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          'posts',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          'posts',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          'posts',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ]),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text(
                        'Add Photo',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Icon(IconoirIcons.editPencil),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomAppbutton extends StatelessWidget {
  const CustomAppbutton({
    super.key,
    required this.text,
    this.width = double.infinity,
    this.heigth = 50,
  });

  final String text;
  final double width;
  final double heigth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: heigth,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
