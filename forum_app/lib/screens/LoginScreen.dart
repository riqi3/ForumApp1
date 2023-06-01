import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/screens/RegisterScreen.dart';

import 'package:forum_app/screens/SectionScreen.dart';

import 'package:get/get.dart';

import '../models/UserCubitModel.dart';
import '../models/UserModel.dart';
import '../providers/AuthService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum FormType { login, register }

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();

  String _username = '';
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;

  _LoginPageState() {
    _nameController.addListener(_usernameListen);
    _emailController.addListener(_emailListen);
    _passwordController.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailController.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailController.text;
    }
  }

  void _usernameListen() {
    if (_nameController.text.isEmpty) {
      _username = "";
    } else {
      _username = _nameController.text;
    }
  }

  void _passwordListen() {
    if (_passwordController.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordController.text;
    }
  }

  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  void clearText() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User LoginScreen'),
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
                        controller: _passwordController,
                        // obscureText: true,
                        validator: (value) =>
                            value == '' ? 'Please input password' : null,
                        decoration: const InputDecoration(
                          hintText: 'password',
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var loginResponse = await authService.userAuth(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text);

                          if (loginResponse.runtimeType == String) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 100,
                                    width: 200,
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      loginResponse.toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (loginResponse.runtimeType == User) {
                            User user = loginResponse;
                            context.read<UserCubit>().emit(user);
                            clearText();
                            Get.to(SectionScreen());
                          }

                        },
                        child: const Text(
                          "Login",
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
                      onPressed: () {
                        Get.to(RegisterScreen());
                      },
                      child: const Text(
                        "Sign Up",
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

  void _loginPressed() async {
    print('The user wants to login with $_email and $_password');
  }

  // void _createAccountPressed () async {
  //   print('The user wants to create an accoutn with $_email and $_password');
  //   GraphQLClient _client = graphQLConfiguration.clientToQuery();
  //   QueryResult result = await _client.mutate(
  //     MutationOptions(
  //       document: addMutation.register('$_email','','$_password'),
  //     ),
  //   );
  //   if (result.data["success"]!=null){
  //     print('The user was created succesfully!');
  //   }else{
  //     print('There was an error!');
  //     print(result.data["register"]["errors"]["email"][0]["message"]);
  //   }
  // }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}
