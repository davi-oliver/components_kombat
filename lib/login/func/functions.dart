import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_url.dart';
import 'package:componets_kombat/local_storage/local.dart';
import 'package:componets_kombat/repositores/datasource/post.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'package:geolocator/geolocator.dart';

var emailcontroller = MaskedTextController(mask: "000.000.000-00");
final senhacontroller = TextEditingController();

class LoginFunction {
  BuildContext context;

  LoginFunction(this.context);
  void limpaControllers() async {
    await Geolocator.requestPermission();
  }

  Future signInWithEmailAndPassword(email, senha) async {
    Map<String, dynamic> login = {};
    // create replace all for reomove . and -
    var cpfSplit = email.split('.').join('').split('-').join('');

    // var cpfAux = email.toString().replaceAll(RegExp('.\\-'), '');
    print("CPF > $cpfSplit ");
    login["login"] = cpfSplit.toString();
    login["pswd"] = '$senha';
    print('$email ${login["pswd"]}');
    if (await GlobalsFunctions(context).verificaInternet()) {
      return GlobalsAlerts(context).alertErro(
          "Atenção", "Sem conexão com a internet, verifique sua conexão");
    }

    // ignore: use_build_context_synchronously
    var mapResult = await PostHttpRequestApp(
      context,
    ).makeJsonRequest(url: urlLogin, params: login);
    mapResult.fold((l) {
      log("Description: ${l.descricao}");
      log("Code: ${l.code}");
      GlobalsAlerts(context).alertErro("Erro:${l.code}", "${l.descricao}");
      return false;
    }, (r) async {
      print("Pegou login $r");
      if (r['error'] != null) {
        GlobalsAlerts(context).alertErro("Erro", "${r['error']}");
        return false;
      }

      // print('dados de token> ${globalsUserInfo.tokenId} ');
      // await GetAgente(context).getAgente();

      // return Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => HomeVigPage()));
    });

    // print('dados de token> ${globalsUserInfo.tokenId} ');
  }

  Future signInWithEmail() async {
    var bytes = utf8.encode(senhacontroller.text); // data being hashed

    var senha = sha256.convert(bytes);

    return await signInWithEmailAndPassword(emailcontroller.text, senha);
  }

  Future recoverPassword() async {}

  Future setStoredPasswordAgent() async {
    final _file = await LocalPathStore().login;
    if (emailcontroller.text.isNotEmpty && senhacontroller.text.isNotEmpty) {
      final login = {
        "email": "${emailcontroller.text}",
        "senha": "${senhacontroller.text}",
      };
      await _file.writeAsString(jsonEncode(login));
      print("Setou:: ${await _file.readAsString()}");
    }
  }

  Future getStoredLoginAgent() async {
    final _file = await LocalPathStore().login;
    if (await _file.exists()) {
      var _login = jsonDecode(await _file.readAsString());
      emailcontroller.text = _login['email'];
      senhacontroller.text = _login['senha'];
      print(
          "EmailLocal: ${emailcontroller.text}\nSenhaLocal::${senhacontroller.text}");
      return true;
    }
    return false;
  }
}
