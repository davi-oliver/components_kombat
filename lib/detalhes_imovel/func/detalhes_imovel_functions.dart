import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:componets_kombat/local_storage/local.dart';
import 'package:componets_kombat/requests/services/serices_get.dart';
import 'package:componets_kombat/view_model/view_model_store.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/home_page.dart';

class DetalhesImovelFunctions {
  BuildContext context;
  DetalhesImovelFunctions(this.context);

  Future verificaUltimoImovel(qrcode) async {
    final file = await LocalPathStore().visitasImovelOffline;
    if (await file.exists()) {
      List json = [];

      json.addAll(jsonDecode(await file.readAsString()));
      if (json.length >= 1) {
        var ultimoImovel = json[json.length - 1];
        if (ultimoImovel["qrcode"] != null) {
          log("ja tem qrcode");
          return true;
        } else {
          ultimoImovel["qrcode"] = qrcode;
          json.removeLast();
          json.add(ultimoImovel);
          await file.writeAsString(jsonEncode(json));
        }
      }
      if (json.length == 0) {
        if (json[0]["qrcode"] != null) {
          log("ja tem qrcode");
          return true;
        } else {
          json[0]["qrcode"] = qrcode;
          log("ataulizou o qrcode local");
          await file.writeAsString(jsonEncode(json));
        }
      }
    } else {
      return false;
    }
  }

  Future iniciaVisita() async {
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);

    iniciaVisitaStore.setValorQr(await GlobalsFunctions(context).scanQR());
    if (iniciaVisitaStore.valorQr == "-1") {
      iniciaVisitaStore.setLoad(false);
      // ignore: use_build_context_synchronously
      return await GlobalsAlerts(context).alertErro("Atenção",
          "Não foi possível ler o Qr Code! Por favor tente novamente!");
    }
    bool conexao = await GlobalsFunctions(context).verificaInternet();
    if (conexao) {
      if (await verificaUltimoImovel(iniciaVisitaStore.valorQr)) {
        viewModelStore.qrcodeAux = iniciaVisitaStore.valorQr;

        iniciaVisitaStore.setLoad(false);
        // ignore: use_build_context_synchronously
        // return Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => FormularioCheckPage()));
      }
    }
    // ignore: use_build_context_synchronously
    await ServiceGetRequestApp(context).buscaQrcodeID();
    if (iniciaVisitaStore.valorQrId == 0) {
      iniciaVisitaStore.setLoad(false);
      // ignore: use_build_context_synchronously
      return await GlobalsAlerts(context).alertErro("Atenção",
          "Não foi possível ler o Qr Code! Por favor tente novamente!");
    }
    viewModelStore.qrcodeAux = iniciaVisitaStore.valorQr;

    // ignore: use_build_context_synchronously
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => FormularioCheckPage()));
    iniciaVisitaStore.setLoad(false);
    return;
  }

  Future atualizaUltimoImovel() async {
    final file = await LocalPathStore().visitasImovelOffline;
    if (await file.exists()) {
      var json = jsonDecode(await file.readAsString());
      List list = [];
      list.addAll(json);
      if (list.isNotEmpty) {
        List ultimo = [];
        ultimo.add(list.last);

        log("ultimo item,: ${ultimo[0]}");
        return ultimo[0];
      }
    } else {
      log("nao existe local");
      return null;
    }
    return null;
  }

  Future postImovelRechadoRecusa(idSituacao) async {
    final file = await LocalPathStore().visitasImovelOffline;
    List getUltimo = [];
    String now = DateTime.now().toIso8601String();
    var pegaUltimo = await atualizaUltimoImovel();
    log("ultimo voltou: $pegaUltimo");
    if (pegaUltimo != null) {
      getUltimo.add(await atualizaUltimoImovel());

      getUltimo[0]["situacao_visita_id"] = idSituacao;
      getUltimo[0]["date_time"] = now;

      getUltimo[0]["id_visita"] = "";
      getUltimo[0]["data_visita"] = now;

      log("Ultimo Item adicionando linhas: ${getUltimo[0]}");

      List list = [];
      list.addAll(await file.readAsString().then((value) => jsonDecode(value)));
      list.removeLast();
      list.add(getUltimo[0]);
      log("Lista local atualizada: ${list.last}");
      await file.writeAsString(jsonEncode(list));
      // ignore: use_build_context_synchronously
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeVigPage(
                    rebirth: () {},
                  )));
    } else {
      final _params = {
        "situacao_visita_id": idSituacao,
        "date_time": now,
        "id_visita": "",
        "data_visita": now,
      };
      List list = [];
      list.add(_params);
      await file.writeAsString(jsonEncode(list));
      log("salvou: ${await file.readAsString()}");
      // ignore: use_build_context_synchronously
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeVigPage(
                    rebirth: () {},
                  )));
    }
  }
}
