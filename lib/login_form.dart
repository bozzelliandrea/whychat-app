import 'package:chat_app/routes.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your email',
                        ),
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the email';
                          }
                          if (!value.contains("@")) {
                            return 'Enter a valid email';
                          }
                          return null;
                        })),
                Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? "Please enter a valid password"
                          : null,
                      controller: _passwordController,
                      obscureText: true,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Loggin....")),
                        );
                        Navigator.pushNamed(context, routes[RouteName.room]!);
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
              ]))),
    );
  }
}