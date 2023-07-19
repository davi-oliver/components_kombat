import 'dart:developer';

import 'package:componets_kombat/formulario_imovel/func/formulario_imovel_functions.dart';
import 'package:componets_kombat/formulario_imovel/store/formulario_imovel_store.dart';
import 'package:componets_kombat/formulario_imovel/sucess/sucess_page.dart';
import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_informations.dart';
import 'package:componets_kombat/globals_url.dart';
import 'package:componets_kombat/home/home_page.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:componets_kombat/repositores/datasource/get.dart';
import 'package:componets_kombat/repositores/datasource/post.dart';
import 'package:componets_kombat/view_model/view_model_store.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesRequestPostApp {
  BuildContext context;
  ServicesRequestPostApp(this.context);

  Future vinculaQrcodeImovel() async {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    var mapResult = await GetHttpRequestApp(context).makeGetJsonRequest(
        url: urlGetQrCodeByValor, params: iniciaVisitaStore.valorQr);

    mapResult.fold((l) async {
      iniciaVisitaStore.setValorQrId(0);
      return false;
    }, (r) async {
      iniciaVisitaStore.setValorQrId(r["id"]);
      var mapResult = await PostHttpRequestApp(context)
          .makeJsonRequest(url: urlVinculaQrCode, params: {
        "imovel_id": "${viewModelStore.imovelVisita.id}",
        "qrcode_id": "${iniciaVisitaStore.valorQrId}"
      });

      mapResult.fold(
        (left) {
          GlobalsAlerts(context).alertErro(
              "Atenção Erro : ${left.code.toString()}", left.descricao);
        },
        (right) async {
          log("MapResultPutQrCode: $right");
          iniciaVisitaStore.setValorQr(right['qrcode']['valor']);
          log("qrcode::: ${iniciaVisitaStore.valorQr}");

          formularioImovelStore.setLoad(false);
          // await GlobalsAlerts(context)
          //     .alertSucessQrCode("Sucesso", "Qr Code Vinculado Com Sucesso!");
        },
      );
    });
  }

  Future imovelFechado() async {
    final globalInfo = Provider.of<GlobalUserInfos>(context, listen: false);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    String now = DateTime.now().toIso8601String();
    bool conexao = await GlobalsFunctions(context).verificaInternet();

    final jsonCreateVisita = {
      "bairro_id": "${formularioImovelStore.bairroIdSel}",
      "imovel_id": "${viewModelStore.imovelVisita.id}",
      "agente_id": "${globalInfo.agenteId}",
      "situacao_visita_id": "6",
      "date_time": now
    };

    // ignore: use_build_context_synchronously
    var responseCadastroImovel = await PostHttpRequestApp(context)
        .makeJsonRequest(url: urlCreateVisita, params: jsonCreateVisita);

    responseCadastroImovel.fold((l) async {
      if (conexao) {
        // se não tiver conexão salva no local storage
        await FormularioImovelFunctions(context).salvaLocalimovelFechado();
        // ignore: use_build_context_synchronously
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HomeVigPage(
                      rebirth: () {},
                    )));
      }
      if (l.code == -2) {
        log("mensagem erro desconhecida: <create visita> ${l.descricao}");
      }
      GlobalsAlerts(context)
          .alertErro("Atenção Erro : ${l.code.toString()}", l.descricao);
      return;
    }, (r) async {
      formularioImovelStore.setLoad(false);
      // await GlobalsAlerts(context).alertSucess("Sucesso", "Imovel fechado!");
      // ignore: use_build_context_synchronously
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => HomeVigPage(
                    rebirth: () {},
                  )),
          (route) => false);
    });
  }

  Future imovelRecusado() async {
    final globalInfo = Provider.of<GlobalUserInfos>(context, listen: false);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    String now = DateTime.now().toIso8601String();
    bool conexao = await GlobalsFunctions(context).verificaInternet();

    final jsonCreateVisita = {
      "bairro_id": "${formularioImovelStore.bairroIdSel}",
      "imovel_id": "${viewModelStore.imovelVisita.id}",
      "agente_id": "${globalInfo.agenteId}",
      "situacao_visita_id": "5",
      "date_time": now
    };

    var responseCadastroImovel = await PostHttpRequestApp(context)
        .makeJsonRequest(url: urlCreateVisita, params: jsonCreateVisita);

    responseCadastroImovel.fold((l) async {
      if (conexao) {
        // se não tiver conexão salva no local storage
        await FormularioImovelFunctions(context).salvaLocalimovelRecusa();
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HomeVigPage(
                      rebirth: () {},
                    )));
      }
      if (l.code == -2) {
        log("mensagem erro desconhecida: <create visita> ${l.descricao}");
      }
      GlobalsAlerts(context)
          .alertErro("Atenção Erro : ${l.code.toString()}", l.descricao);
      return;
    }, (r) async {
      formularioImovelStore.setLoad(false);
      // await GlobalsAlerts(context).alertSucess("Sucesso", "Imovel Recusado!");
      // ignore: use_build_context_synchronously
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => HomeVigPage(
                    rebirth: () {},
                  )),
          (route) => false);
    });
  }

  Future cadastraImovel() async {
    final infoImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    var conexao = await GlobalsFunctions(context).verificaInternet();

    if (infoImovelStore.tipo == '0') {
      infoImovelStore.setLoad(false);

      return GlobalsAlerts(context)
          .alertErro('Atenção', "Selecione o tipo de imovel a ser vinculado.");
    } else if (!(await FormularioImovelFunctions(context).validador())) {
      infoImovelStore.setLoad(false);
      return GlobalsAlerts(context)
          .alertErro("Atenção", "Preencha todos os campos para proseguir");
    }

    // converte o campo para inteiro
    int numero = int.parse(infoImovelStore.controllNum.text);
    int quarteiraoNumero = int.parse(infoImovelStore.quartId);
    int lado = int.parse(infoImovelStore.controllLado.text);

    final _params = {
      "logradouro": infoImovelStore.controllRua.text,
      "numero": "$numero",
      "complemento": infoImovelStore.controllComplemento.text,
      "bairro": infoImovelStore.controllBairro.text,
      "tipo_imovel_id": "${infoImovelStore.tipo}",
      "bairro_id": "${infoImovelStore.bairroIdSel}",
      "quarteirao_id": "$quarteiraoNumero",
      "lado": "$lado",
      // "cidade_id": 5,
      // "estado_id": 4,
    };

    var responseCadastraImovel = await PostHttpRequestApp(context)
        .makeJsonRequest(url: urlCadastrarImovel, params: _params);

    responseCadastraImovel.fold((l) async {
      if (conexao) {
        infoImovelStore.setLoad(false);
        await FormularioImovelFunctions(context).salvaImovelLocal();
        infoImovelStore.setLoad(false);
        // ignore: use_build_context_synchronously
        // return await GlobalsAlerts(context).alertErroConexaoCadastro();
      }
    }, (r) async {
      log("message: ${r["message"]}");
      viewModelStore.setImovelVisitaFromJson(r["imovel"], 0);
      log("imovelId: ${viewModelStore.imovelVisita.id}");
      if (infoImovelStore.tipo == "3" ||
          infoImovelStore.tipo == "8" ||
          infoImovelStore.tipo == "10") {
        log("TerrenoBaldio");
        infoImovelStore.setLoad(false);
        infoImovelStore.setVisibilidadeVisita(true);

        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => InfoSalvaPage()),
            (route) => false);
      }

      infoImovelStore.setLoad(false);

      return Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => InfoSalvaPage()), (route) => false);
    });
  }
}
