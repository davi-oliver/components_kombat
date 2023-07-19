import 'dart:convert';

import 'package:componets_kombat/local_storage/local.dart';
import 'package:flutter/material.dart';

class ValidaQrcodefunctions {
  BuildContext context;
  ValidaQrcodefunctions(this.context);

  Future atualizaUltimoImovel(valorQrcode) async {
    final file = await LocalPathStore().visitasImovelOffline;
    if (await file.exists()) {
      var json = jsonDecode(await file.readAsString());
      List list = [];
      list.addAll(json);
      if (list.isNotEmpty) {
        List ultimo = [];
        ultimo.add(list.last);

        print("ultimo item,: ${ultimo[0]}");
        ultimo[0]["qrcode"] = valorQrcode;
        list.removeLast();
        list.add(ultimo[0]);
        print("ultimo atualizado: ${list.last}");
        // return Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => FormularioCheckPage()));
      }
    }
  }
}
