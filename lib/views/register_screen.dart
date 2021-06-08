import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/register/register_cubit.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/default_form_field.dart';
import 'package:shop_app/components/toast.dart';
import 'package:shop_app/service/storage/cache_helper.dart';
import 'package:shop_app/src/constants.dart';

import 'layout/shop_layout.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              print(state.registerModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data.token,
              ).then((value) {
                token = state.registerModel.data.token;
                navigateAndReplace(context, ShopLayout());
              });
            } else {
              showToaster(
                message: state.registerModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

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
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          inputType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                          labelText: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                          labelText: 'Email address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          onFieldSubmitted: (_) {
                            //login(context, emailController, passwordController);
                          },
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          labelText: 'Password',
                          prefix: Icons.lock_outline,
                          suffixIcon: cubit.suffix,
                          suffixPressed: () {
                            print('suffixPressed');
                            cubit.changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone';
                            }
                          },
                          labelText: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                register(
                                  context: context,
                                  emailController: emailController,
                                  nameController: nameController,
                                  passwordController: passwordController,
                                  phoneController: phoneController,
                                );
                              },
                              text: 'register',
                              isUpperCase: true,
                              radius: 8),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
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

  dynamic register(
      {BuildContext context,
      emailController,
      passwordController,
      nameController,
      phoneController}) {
    if (formKey.currentState.validate()) {
      RegisterCubit.get(context).userRegister(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          phone: phoneController.text);
    }
  }
}
