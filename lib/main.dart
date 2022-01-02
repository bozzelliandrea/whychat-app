import 'package:chat_app/login_form.dart';
import 'package:chat_app/register_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Chat());
}

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      routes: {
        '/login': (context) => const LoginForm(),
        '/register': (context) => const RegisterForm(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
      ),
      home: const ChatHomePage(title: "WhyChat"),
    );
  }
}

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  void _toRegister() => Navigator.pushNamed(context, '/register');

  void _toLogin() => Navigator.pushNamed(context, '/login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/wallpaper.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('Welcome',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 30.0,
                          )),
                      Text('WhyChat a simple useless app',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic
                          ))
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: _toRegister,
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      fixedSize: const Size(300, 80),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.white))),
                  child: Stack(
                    children: const <Widget>[
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.person_add_alt_1, size: 20)),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.white,
                            fixedSize: const Size(300, 80)),
                        onPressed: _toLogin,
                        child: Stack(
                          children: const <Widget>[
                            Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.login, size: 20)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }
}
