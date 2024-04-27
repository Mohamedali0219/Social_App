import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconoir_ttf/flutter_iconoir_ttf.dart';
import 'package:social_app/cubites/social_cubit/social_cubit.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/model/meesage_model.dart';
import 'package:social_app/model/user_model.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key, required this.model});

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: model.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  title: Row(
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            model.image!,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(model.name!)
                    ],
                  ),
                  titleSpacing: 0,
                ),
                body: ConditionalBuilder(
                    condition: SocialCubit.get(context).messages.isNotEmpty,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ListView.separated(
                                itemBuilder: (context, index) {
                                  var message =
                                      SocialCubit.get(context).messages[index];
                                  if (SocialCubit.get(context).userModel!.uId ==
                                      message.senderId) {
                                    return buildMyMessage(context, message);
                                  }
                                  return buildMessage(context, message);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount:
                                    SocialCubit.get(context).messages.length),
                            const Spacer(),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type your message here',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: MaterialButton(
                                      color: Theme.of(context).primaryColor,
                                      minWidth: 1,
                                      onPressed: () {
                                        SocialCubit.get(context).sendMessage(
                                          receiverId: model.uId!,
                                          dateTime: DateTime.now().toString(),
                                          text: messageController.text,
                                        );
                                        messageController.clear();
                                      },
                                      child: const Icon(
                                        IconoirIcons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    fallback: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }));
          },
        );
      },
    );
  }
}

buildMessage(context, MessageModel message) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(
        message.message!,
        style: const TextStyle(fontSize: 18),
      ),
    ),
  );
}

buildMyMessage(context, MessageModel message) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Text(
        message.message!,
        style: const TextStyle(fontSize: 18),
      ),
    ),
  );
}
