import 'dart:developer';

import 'package:componets_kombat/formulario_imovel/store/formulario_imovel_store.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:componets_kombat/repositores/datasource/get.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../detalhes_imovel/valida_qrcode/store/valida_qrcode_store.dart';

class GlobalsFunctions {
  BuildContext context;
  GlobalsFunctions(this.context);
// VERIFICA CONEXÃO COM A INTERNET
  Future<bool> verificaInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // nao tem conexao
      return true;
    } else {
      // tem conexao
      return false;
    }
  }

  // SECANEIA QR CODE
  Future<String> scanQR() async {
    String codigo;
    try {
      codigo = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);

      // print("Valor lido = $codigo");

      return codigo;
    } catch (_) {
      return "-1";
    }
  }

  Future<void> limpaCampos() async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    // final iniciaVisitaStore =
    //     Provider.of<IniciaVisitaStore>(context, listen: false);
    // iniciaVisitaStore.setValorQr("");
    formularioImovelStore.listaBairrosSearch.clear();
    formularioImovelStore.listaRuasSearch.clear();
    formularioImovelStore.bairroIdSel = 0;
    formularioImovelStore.quartId = "";
    formularioImovelStore.jsonQuart.clear();
    formularioImovelStore.ruaSel = "";
    formularioImovelStore.setVisitbilidadeListaBairros(false);
    formularioImovelStore.setVisitbilidadeListaRuas(false);
    formularioImovelStore.listaRuasSearch
        .addAll(formularioImovelStore.listaRuasOrigin);
    formularioImovelStore.listaBairrosSearch
        .addAll(formularioImovelStore.listaBairrosOrigin);

    formularioImovelStore.controllBairro.clear();
    // controllCep.clear();
    formularioImovelStore.controllLado.clear();
    formularioImovelStore.controllNum.clear();
    formularioImovelStore.controllQuart.clear();
    formularioImovelStore.controllRua.clear();
    formularioImovelStore.tipo = "";
    formularioImovelStore.tipoImovelId = 0;
    formularioImovelStore.setLoad(false);
//  OS CAMPOS DO FORMULÁRIO
    // ALOCA OS VALORES AO DROPDOWN
  }

//   Future<bool> getQrCodeValidos(_responseQrCode) async {
//     // se ambos forem (Yes)
//     return _responseQrCode["qrcode"]["valor"] == "Y";
//   }

//   Future verificaQrCodeExistente([bool entraVisita = false]) async {
//     final iniciaVisitaStore =
//         Provider.of<IniciaVisitaStore>(context, listen: false);

//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);

//     iniciaVisitaStore.setValorQr(await scanQR());
//     if (iniciaVisitaStore.valorQr == "-1" && iniciaVisitaStore.valorQr == '') {
//       iniciaVisitaStore.setLoad(false);
//       // return GlobalsAlerts(context).alertErro(
//           // "Atenção", "Não foi possivel scanear o qrcode. Tente novamente.");
//     }

//     // CHAMA LEITURA DE QR CODE E ATRIBUI O SEU VALOR

//     print("Externo >>> ${formularioImovelStore.externo}");

//     await GetQrCode(context)
//         .getShowQrcodeValidation(iniciaVisitaStore.valorQr, entraVisita);
//   }

// CONSULTA BANCO DE IMÓVEIS COM O VALOR DO QR CODE
  Future<dynamic> validaQrCode(String valorQr,
      [bool inciaVisita = true]) async {
    final validaQrCodeStore =
        Provider.of<ValidaQrCodeStore>(context, listen: false);
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    var mapResult = await GetHttpRequestApp(context)
        .makeGetJsonRequest(url: "qr-codes", params: valorQr);

    mapResult.fold(
      (left) {
        validaQrCodeStore.setLoading(false);
        // GlobalsAlerts(context).alertErro(
        // "Atenção Erro : ${left.code.toString()}", left.descricao);
      },
      (right) async {
        log("MapGetResultQrCode: $right");
        iniciaVisitaStore.setValorQrId(right["id"]);
        if (right["active"] == "N") {
          // await GlobalsAlerts(context).alertErroQr(
          //     "Atenção",
          //     "O QR Code lido não está cadastrado a este imovel.\nDeseja vincular?",
          //     // "Vincular",
          // inciaVisita: inciaVisita);
        } else if (right["active"] == "Y") {
          validaQrCodeStore.setLoading(false);

          // await GlobalsAlerts(context).alertErro("Atenção",
          // "O Qr Code lido já está vinculado a um imovel. Por favor, escaneie outro Qr Code que não estja sendo usado.");
        }

        return right;
      },
    );
  }

  Future<String> removerAcentos(String str) async {
    var comAcento =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }

    return str;
  }

  Future getQrCodeImovel(valorQr) async {
    var mapResult = await GetHttpRequestApp(context).makeGetJsonRequest(
        url: "http://dev.vps-kinghost.net:3000/imovel/show/qrcode_validation",
        params: valorQr);

    mapResult.fold(
      (left) {
        GlobalsAlerts(context).alertErro(
            "Atenção Erro : ${left.code.toString()}", left.descricao);
      },
      (right) {
        log("MapGetResultQrCode: $mapResult");
        return mapResult;
      },
    );
  }
}
