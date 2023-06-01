import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/providers/AuthService.dart';
import 'package:forum_app/screens/LoginScreen.dart';
import 'package:forum_app/screens/SectionScreen.dart';

import 'package:get/get.dart';

import '../models/UserCubitModel.dart';
import '../models/UserModel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  AuthService authService = AuthService();

  void clearText() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController1.text.isNotEmpty &&
        _passwordController2.text.isNotEmpty) {
      _nameController.clear();
      _emailController.clear();
      _passwordController1.clear();
      _passwordController2.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User RegisterScreen'),
      ),
      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) =>
                            value == '' ? 'Please input username' : null,
                        decoration: const InputDecoration(
                          hintText: 'user name',
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            value == '' ? 'Please input email' : null,
                        decoration: const InputDecoration(
                          hintText: 'email',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController1,
                        obscureText: true,
                        validator: (value) =>
                            value == '' ? 'Please input password' : null,
                        decoration: const InputDecoration(
                          hintText: 'password',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController2,
                        obscureText: true,
                        validator: (value) =>
                            value == '' ? 'Please input password' : null,
                        decoration: const InputDecoration(
                          hintText: 'password',
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_nameController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty &&
                                  _passwordController1.text.isNotEmpty ||
                              _passwordController2.text.isNotEmpty) {
                            var registerResponse = await authService.userAuth(
                                _nameController.text,
                                
                                _emailController.text,_passwordController1.text,);

                            if (registerResponse.runtimeType == String) {
                              if(_passwordController1 == _passwordController2){
                                
                                _showDialog(context, registerResponse);
                              }
                               
                            } else if (registerResponse.runtimeType == User) {
                              User user = registerResponse;
                              context.read<UserCubit>().emit(user);
                              clearText();
                              Get.to(LoginScreen());
                            }

                            

                            // context.read<SectionProvider>().add(
                            //       SectionModel(
                            //         sectionTitle: titleController.text,
                            //       ),
                            //     );
                          }
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (() {
                        Navigator.of(context).pop();
                      }),
                      child: const Text(
                        "Already have an account?",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, registerResponse) {
    return showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 100,
                                    width: 200,
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      registerResponse.toString(),
                                    ),
                                  ),
                                );
                              },
                            );
  }
}
