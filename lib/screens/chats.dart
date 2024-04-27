import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/social_cubit/social_cubit.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/screens/chat_details.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SocialCubit.get(context).users.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return chatItem(
                        SocialCubit.get(context).users[index], context);
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    endIndent: 15,
                    indent: 15,
                  ),
                  itemCount: SocialCubit.get(context).users.length,
                );
              },
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        });
  }
}

chatItem(UserModel model, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    child: InkWell(
      onTap: () {
        navigatTo(context, ChatDetails(model: model));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              model.image!,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            model.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
