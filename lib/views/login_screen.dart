import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/login/login_cubit.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/default_form_field.dart';
import 'package:shop_app/components/default_text_button.dart';
import 'package:shop_app/components/toast.dart';
import 'package:shop_app/service/storage/cache_helper.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/layout/shop_layout.dart';
import 'package:shop_app/views/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateAndReplace(context, ShopLayout());
              });
            } else {
              showToaster(
                message: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
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
                            login(context, emailController, passwordController);
                          },
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              print('emptyy');
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
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                login(context, emailController,
                                    passwordController);
                              },
                              text: 'login',
                              isUpperCase: true,
                              radius: 8),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have and account?',
                            ),
                            defaultTextButton(
                                onPressed: () {
                                  navigateTo(
                                    context,
                                    RegisterScreen(),
                                  );
                                },
                                text: 'register now'),
                          ],
                        )
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

  dynamic login(BuildContext context, emailController, passwordController) {
    if (formKey.currentState.validate()) {
      LoginCubit.get(context).userLogin(
          email: emailController.text, password: passwordController.text);
    }
  }
}
