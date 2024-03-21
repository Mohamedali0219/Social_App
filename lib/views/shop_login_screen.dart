import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/login_cubit/shop_login_cubit.dart';
import 'package:social_app/cubites/login_cubit/shop_login_state.dart';
import 'package:social_app/views/shpo_register_screen.dart';
import 'package:social_app/widgets/defult_buttons.dart';
import 'package:social_app/widgets/defult_text_formfield.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {},
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
                          'Login',
                          style: TextStyle(
                            fontSize: 45,
                          ),
                        ),
                        const Text(
                          'Login to Communicate with friends',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
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
                          suffixIcon: SocialLoginCubit.get(context).suffixIcon,
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          changeSuffixIcon: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              // SocialLoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                            }
                          },
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
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defultElevatedButton(
                                  onPressed: () {
                                    // if (formKey.currentState!.validate()) {
                                    //   SocialLoginCubit.get(context).userLogin(
                                    //     email: emailController.text,
                                    //     password: passwordController.text,
                                    //   );
                                    // }
                                  },
                                  text: 'Login',
                                ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                        Row(
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            deflutTextButton(
                              onPressed: () {
                                navigatTo(context, SocialRegisterScreen());
                              },
                              text: 'Register',
                            )
                          ],
                        ),
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
