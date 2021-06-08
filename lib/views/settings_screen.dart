import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/app_cubit.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/default_form_field.dart';
import 'package:shop_app/src/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        nameController.text = cubit.userModel.data.name;
        emailController.text = cubit.userModel.data.email;
        phoneController.text = cubit.userModel.data.phone;
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is LoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      inputType: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'name can not be empty';
                        }
                        return null;
                      },
                      labelText: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'email can not be empty';
                        }
                        return null;
                      },
                      labelText: 'Email address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      inputType: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'phone can not be empty';
                        }
                        return null;
                      },
                      labelText: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState.validate()) {
                          cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: 'update',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
