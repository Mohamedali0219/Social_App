import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/register_cubit/register_cubit.dart';
import 'package:social_app/cubites/register_cubit/register_state.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/widgets/defult_buttons.dart';
import 'package:social_app/widgets/defult_text_formfield.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocilaRegisterUserSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('your account created successfully'),
                backgroundColor: Colors.green,
              ),
            );
            navigatAndReplace(context, const HomeLayout());
          }
          if (state is SocialRegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 45,
                          ),
                        ),
                        const Text(
                          'Register to Communicate with friends',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defultTextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          hintText: 'Enter your name',
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defultTextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          hintText: 'Enter your phone',
                          prefixIcon: Icons.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Enter your password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon:
                              SocialRegisterCubit.get(context).suffixIcon,
                          obscureText:
                              SocialRegisterCubit.get(context).isPassword,
                          changeSuffixIcon: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocilaRegisterLoadingState,
                            builder: (context) => defultElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialRegisterCubit.get(context)
                                          .registerUser(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'Register',
                                ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
