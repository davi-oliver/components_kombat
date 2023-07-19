import 'dart:convert';
import 'dart:developer';

import 'package:componets_kombat/formulario_imovel/sucess/sucess_page.dart';
import 'package:componets_kombat/globals_informations.dart';
import 'package:componets_kombat/home/home_page.dart';
import 'package:componets_kombat/local_storage/local.dart';
import 'package:componets_kombat/view_model/view_model_store.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:string_similarity/string_similarity.dart';
import '../store/formulario_imovel_store.dart';

class FormularioImovelFunctions {
  FormularioImovelFunctions(this.context);
  BuildContext context;

  Future setMockDetalhesImovel(lado, bool qrcode) async {
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    viewModelStore.setAuxDetalhes(
        bairro: formularioImovelStore.controllBairro.text,
        complemento: formularioImovelStore.controllComplemento.text,
        logradouro: formularioImovelStore.controllRua.text,
        numero: formularioImovelStore.controllNum.text,
        tipoimovel: formularioImovelStore.tipo == "1"
            ? "Residencial"
            : formularioImovelStore.tipo == "2"
                ? "Comercial"
                : formularioImovelStore.tipo == "3"
                    ? "Terreno Baldio"
                    : formularioImovelStore.tipo == "8"
                        ? "Outros"
                        : formularioImovelStore.tipo == "9"
                            ? "Ponto Estratégico"
                            : formularioImovelStore.tipo == "10"
                                ? "Praça Pública"
                                : "Não Informado",
        qrcode: qrcode ? "1234" : "null",
        situacaovisita: "Não visitado");
  }

  Future cadastraImovelSemInternet(context) async {
    return Navigator.push(
        context, MaterialPageRoute(builder: (_) => const InfoSalvaPage()));
  }

  Future salvaImovelLocalComQrcode(String qrcodeValor) async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final gblobalUserInfos =
        Provider.of<GlobalUserInfos>(context, listen: false);
    final fileVisitaImovelOffline = await LocalPathStore().visitasImovelOffline;
    // await fileVisitaImovelOffline.delete();
    // return;
    // ignore: avoid_log
    log("AAA O QRCODEEEEE");

    if (await fileVisitaImovelOffline.exists()) {
      List list = [];
      list.addAll(
          await jsonDecode(await fileVisitaImovelOffline.readAsString()));
      // ignore: avoid_log
      log("listas de visitas no local: ${list.length}");
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
        "qrcode": qrcodeValor,
      };
      // ignore: avoid_log
      log("json: $json");
      var element = list[list.length - 1];
      if (element["logradouro"] == formularioImovelStore.controllRua.text &&
          element["numero"] == numero &&
          element["complemento"] ==
              formularioImovelStore.controllComplemento.text) {
        log("imovel ja cadastrado");
        await setMockDetalhesImovel(lado, true);

        return true;
      } else {
        log("imovel não cadastrado");
        list.add(json);
        await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
        log("imovelSalvoLocal[localexiste]: ${await fileVisitaImovelOffline.readAsString()}");
        await setMockDetalhesImovel(lado, true);
      }
      return true;
    } else {
      List list = [];
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
        "qrcode": qrcodeValor,
      };
      log("json first item: $json");
      list.add(json);
      await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
      log("imovelSalvoLocal[localexiste]: ${await fileVisitaImovelOffline.readAsString()}");
      await setMockDetalhesImovel(lado, true);
      return true;
    }
  }

  Future salvaImovelLocal() async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final gblobalUserInfos =
        Provider.of<GlobalUserInfos>(context, listen: false);
    final fileVisitaImovelOffline = await LocalPathStore().visitasImovelOffline;
    // await fileVisitaImovelOffline.delete();
    // return;

    if (await fileVisitaImovelOffline.exists()) {
      List list = [];
      list.addAll(
          await jsonDecode(await fileVisitaImovelOffline.readAsString()));

      log("listas de visitas no local: ${list.length}");
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
      };
      log("json: $json");
      var element = list[list.length - 1];
      if (element["logradouro"] == formularioImovelStore.controllRua.text &&
          element["numero"] == numero &&
          element["complemento"] ==
              formularioImovelStore.controllComplemento.text) {
        log("imovel ja cadastrado");
        await setMockDetalhesImovel(lado, false);

        return true;
      } else {
        log("imovel não cadastrado");
        list.add(json);
        await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
        log("imovelSalvoLocal[localexiste]: ${await fileVisitaImovelOffline.readAsString()}");
        await setMockDetalhesImovel(lado, false);
      }

      return true;
    } else {
      List list = [];
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
      };
      log("json first item: $json");

      list.add(json);
      await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
      log("imovelSalvoLocal: ${await fileVisitaImovelOffline.readAsString()}");
      await setMockDetalhesImovel(lado, false);
      return true;
    }
  }

  Future salvaLocalimovelRecusa() async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final gblobalUserInfos =
        Provider.of<GlobalUserInfos>(context, listen: false);
    final fileVisitaImovelOffline = await LocalPathStore().visitasImovelOffline;
    // await fileVisitaImovelOffline.delete();
    // return;
    log("RECUSAAAA");

    String now = DateTime.now().toIso8601String();

    if (await fileVisitaImovelOffline.exists()) {
      List list = [];
      list.addAll(
          await jsonDecode(await fileVisitaImovelOffline.readAsString()));
      log("listas de visitas no local: ${list.length}");
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
        "situacao_visita_id": "5",
        "date_time": now,
      };
      log("json: $json");

      list.add(json);
      await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
      log("imovelSalvoLocal[localexiste]: ${await fileVisitaImovelOffline.readAsString()}");
    } else {
      List list = [];
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
        "situacao_visita_id": "5",
        "date_time": now,
      };
      log("json first item: $json");

      list.add(json);
      await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
      log("imovelSalvoLocal: ${await fileVisitaImovelOffline.readAsString()}");
    }
    // ignore: use_build_context_synchronously
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => HomeVigPage(
                  rebirth: () {},
                )));
  }

  Future salvaLocalimovelFechado() async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final gblobalUserInfos =
        Provider.of<GlobalUserInfos>(context, listen: false);
    final fileVisitaImovelOffline = await LocalPathStore().visitasImovelOffline;
    log("FECHADOOOO");
    // await fileVisitaImovelOffline.delete();
    // return;

    String now = DateTime.now().toIso8601String();

    if (await fileVisitaImovelOffline.exists()) {
      List list = [];
      list.addAll(
          await jsonDecode(await fileVisitaImovelOffline.readAsString()));
      log("listas de visitas no local: ${list.length}");
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
        "situacao_visita_id": "6",
        "date_time": now,
      };
      log("json: $json");

      list.add(json);
      await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
      log("imovelSalvoLocal[localexiste]: ${await fileVisitaImovelOffline.readAsString()}");
    } else {
      List list = [];
      int numero = int.parse(formularioImovelStore.controllNum.text);
      int quarteiraoNumero = int.parse(formularioImovelStore.quartId);
      int lado = int.parse(formularioImovelStore.controllLado.text);
      final json = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": numero,
        "complemento": formularioImovelStore.controllComplemento.text,
        "bairro": formularioImovelStore.controllBairro.text,
        "tipo_imovel_id": formularioImovelStore.tipo,
        "bairro_id": formularioImovelStore.bairroIdSel,
        "quarteirao_id": quarteiraoNumero,
        "lado": lado,
        "agente_id": gblobalUserInfos.agenteId,
        "situacao_visita_id": "6",
        "date_time": now,
      };
      log("json first item: $json");

      list.add(json);
      await fileVisitaImovelOffline.writeAsString(jsonEncode(list));
      log("imovelSalvoLocal: ${await fileVisitaImovelOffline.readAsString()}");
    }
    // ignore: use_build_context_synchronously
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => HomeVigPage(
                  rebirth: () {},
                )));
  }

// FUNÇÃO RESPONSÁVEL POR VALIDAR OS CAMPOS DO FORMULÁRIO
  Future<bool> validador() async {
    final infoImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    if (infoImovelStore.controllBairro.text.isNotEmpty &&
        infoImovelStore.bairroIdSel != 0 &&
        infoImovelStore.ruaSel != "" &&
        // infoImovelStore.controllCep.text.isNotEmpty &&
        infoImovelStore.controllRua.text.isNotEmpty &&
        infoImovelStore.controllNum.text.isNotEmpty &&
        infoImovelStore.quartId != "" &&
        infoImovelStore.tipo != '') {
      return true;
    } else {
      // log(infoImovelStore.controllBairro.text);
      // log(infoImovelStore.controllRua.text);
      // log(infoImovelStore.controllBairro.text);
      // log(infoImovelStore.controllNum.text);
      // log(infoImovelStore.tipoImovelId);
      return false;
    }
  }

  Future setJsonCadastrarImovel() async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    int numero = int.parse(formularioImovelStore.controllNum.text);
    int quarteiraoNumero = int.parse(formularioImovelStore.controllQuart.text);
    int lado = int.parse(formularioImovelStore.controllLado.text);

    // log("Json: ${_json}");
    final envio = {
      "logradouro": formularioImovelStore.controllRua.text,
      "numero": numero,
      "complemento": formularioImovelStore.controllComplemento.text,
      "bairro": formularioImovelStore.controllBairro.text,
      "tipo_imovel_id": formularioImovelStore.tipoImovelId,
      "bairro_id": formularioImovelStore.bairroIdSel,
      "quarteirao_numero": quarteiraoNumero,
      "lado": lado,
      // "cidade_id": 5,
      // "estado_id": 4,
    };
    log("Envio: $envio");

    return jsonEncode(envio);
  }

  Future filterSearchResultsBairro(String query) async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    if (query.isNotEmpty) {
      formularioImovelStore
          .setaddAllBairrosAutoComplete(await comparaQueryBairro(query));

      return;
    } else {
      formularioImovelStore.setaddAllBairrosAutoComplete(
          formularioImovelStore.listaBairrosOrigin);
      return;
    }
  }
  // a função compar query verifica somente os nomes de empreass

  Future<dynamic> comparaQueryBairro(query) async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    List<GetBairro> listaAuxiliar = [];
    listaAuxiliar.clear();
    for (int i = 0;
        i < formularioImovelStore.listaSearchStringSemAcentos.length;
        i++) {
      if (formularioImovelStore.listaSearchStringSemAcentos[i].nome
              .toString()
              .contains(query.toString().toUpperCase()) ||
          query.toString().toUpperCase().similarityTo(
                  '${formularioImovelStore.listaSearchStringSemAcentos[i].nome}') >
              0.6) {
        if (!(listaAuxiliar.contains(
            // ignore: iterable_contains_unrelated_type
            formularioImovelStore.listaSearchStringSemAcentos[i].id))) {
          listaAuxiliar.add(
            GetBairro(
                nome: formularioImovelStore.listaSearchStringSemAcentos[i].nome,
                id: formularioImovelStore.listaSearchStringSemAcentos[i].id),
          );
        }
      }
    }
    return listaAuxiliar;
  }

  Future filterSearchResultsRua(String query) async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    if (query.isNotEmpty) {
      formularioImovelStore
          .setAddAllListaRuasMostrar(await comparaQueryRua(query));

      return;
    } else {
      formularioImovelStore
          .setAddAllListaRuasMostrar(formularioImovelStore.listaRuasOrigin);
      return;
    }
  }
  // a função compar query verifica somente os nomes de empreass

  Future<dynamic> comparaQueryRua(query) async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    List<GetRua> listaAuxiliar = [];
    listaAuxiliar.clear();
    for (int i = 0;
        i < formularioImovelStore.listaRuasSearchStringSemAcentos.length;
        i++) {
      if (formularioImovelStore.listaRuasSearchStringSemAcentos[i].nome
              .toString()
              .contains(query.toString().toUpperCase()) ||
          query.toString().toUpperCase().similarityTo(
                  '${formularioImovelStore.listaRuasSearchStringSemAcentos[i].nome}') >
              0.5) {
        if (!(listaAuxiliar.contains(
            // ignore: iterable_contains_unrelated_type
            formularioImovelStore.listaRuasSearchStringSemAcentos[i].id))) {
          listaAuxiliar.add(
            GetRua(
                nome: formularioImovelStore
                    .listaRuasSearchStringSemAcentos[i].nome,
                id: formularioImovelStore
                    .listaRuasSearchStringSemAcentos[i].id),
          );
        }
      }
    }
    return listaAuxiliar;
  }
}

mixin ValidaFormImovel {
  Future<String>? cepValidateLength(value) async {
    if (value.isEmpty) return "Campo CEP não pode ser vazio";
    if (!value.contains("3750")) {
      return "CEP não pode exceder o limite do municipio";
    }

    return null.toString();
  }

  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? "Esse campo é obrigatório";
    return null;
  }
}
