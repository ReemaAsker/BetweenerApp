import 'package:betweenerapp/assets.dart';
import 'package:betweenerapp/views/login_view.dart';
import 'package:betweenerapp/views/widgets/custom_text_form_field.dart';
import 'package:betweenerapp/views/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/widgets/google_button_widget.dart';
import '../Controller/auth.dart';
import '../Model/user.dart';

class RegisterView extends StatefulWidget {
  static String id = '/registerView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void submitRegister() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };
      register(body).then((user) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', userToJson(user));
        if (mounted) {
          Navigator.pushNamed(context, LoginView.id);
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Hero(
                          tag: 'authImage',
                          child: SvgPicture.asset(AssetsData.authImage))),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      value!.isEmpty ? 'This feild is required' : '';
                    },
                    controller: nameController,
                    hint: 'John Doe',
                    label: 'Name',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      value!.isEmpty ? 'This feild is required' : '';
                    },
                    controller: emailController,
                    hint: 'example@gmail.com',
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      value!.isEmpty ? 'This feild is required' : '';
                    },
                    controller: passwordController,
                    hint: 'Enter password',
                    label: 'password',
                    password: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      value!.isEmpty ? 'This feild is required' : '';
                    },
                    controller: passwordController,
                    hint: 'confirm password',
                    label: 'confirm password',
                    password: true,
                  ),
                  SecondaryButtonWidget(
                      onTap: () {
                        submitRegister();
                      },
                      text: 'REGISTER'),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '-  or  -',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GoogleButtonWidget(onTap: () {}),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
