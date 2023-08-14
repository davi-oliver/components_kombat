import 'package:flutter/material.dart';
import 'package:componets_kombat/login/login_view_componet.dart'
    as componets_kombat_ui;

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: componets_kombat_ui.LoginScreenComponets(
        contextPage: context,
        loading: loading,
        controllerLogin: controllerLogin,
        controllerSenha: controllerSenha,
        labelTextCampoLogin: "Login",
        labelTextCampoSenha: "Senha",
        textoBotaoEntrar: "Entrar",
        containCriarLogin: true,
        heightCardLogin: MediaQuery.of(context).size.height * .85,
        onTapEntrar: () async {
          setState(() {
            loading = true;
          });
          await Future.delayed(const Duration(seconds: 3));
          setState(() {
            loading = false;
          });
        },
        tituloTopoLogin: "Login",
      ),
    );
  }
}
