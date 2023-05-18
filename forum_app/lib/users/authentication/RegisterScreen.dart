import 'package:flutter/material.dart';
import 'package:forum_app/users/authentication/LoginScreen.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                        controller: nameController,
                        validator: (value) =>
                            value == '' ? 'Please input username' : null,
                        decoration: const InputDecoration(
                          hintText: 'user name',
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) =>
                            value == '' ? 'Please input email' : null,
                        decoration: const InputDecoration(
                          hintText: 'email',
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText:  true,
                        validator: (value) =>
                            value == '' ? 'Please input password' : null,
                        decoration: const InputDecoration(
                          hintText: 'password',
                        ),
                      ),
                      TextButton(
                        onPressed: (() {
                          // if (titleController.text.isNotEmpty) {
                          //   context.read<SectionProvider>().add(
                          //         SectionModel(
                          //           sectionTitle: titleController.text,
                          //         ),
                          //       );
                          //   Navigator.pop(context);
                          // }
                        }),
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
}
