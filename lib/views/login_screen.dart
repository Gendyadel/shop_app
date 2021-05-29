import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/default_form_field.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LOGIN',
              style: Theme.of(context).textTheme.headline5,
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
                return null;
              },
              labelText: 'Email address',
              prefix: Icons.email_outlined,
            ),
            SizedBox(height:30.0,),
            defaultFormField(
              controller: passwordController,
              inputType: TextInputType.visiblePassword,
              isPassword: true,
              validator: (String value) {
                if (value.isEmpty) {
                  print('emptyy');
                  return 'Password is too short';
                } else{
                  return null;
                }
              },
              labelText: 'Password',
              prefix: Icons.lock_outline,
              suffixIcon: Icons.visibility_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
