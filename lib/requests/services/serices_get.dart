import 'dart:convert';
import 'dart:developer';

import 'package:componets_kombat/detalhes_imovel/detalhes_imovel_page.dart';
import 'package:componets_kombat/detalhes_imovel/lista_imoveis/lista_imoveis_page.dart';
import 'package:componets_kombat/formulario_imovel/store/formulario_imovel_store.dart';
import 'package:componets_kombat/formulario_questoes_visita/func/func.dart';
import 'package:componets_kombat/formulario_questoes_visita/store/forumario_questoes_visita_store.dart';
import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_url.dart';
import 'package:componets_kombat/home/home_page.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:componets_kombat/local_storage/local.dart';
import 'package:componets_kombat/repositores/datasource/get.dart';
import 'package:componets_kombat/repositores/datasource/post.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:componets_kombat/view_model/view_model_store.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceGetRequestApp {
  BuildContext context;
  ServiceGetRequestApp(this.context);
  // FUNÇÃO RESPONSAVEL POR BUSCAR O IMÓVEL PELO ENDEREÇO
  Future getImoveisByEndereco() async {
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    var jsonGet = {};
    // verificar qual modelo de json vai usar
    if (formularioImovelStore.controllComplemento.text.isEmpty) {
      jsonGet = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": formularioImovelStore.controllNum.text,
      };
    } else {
      jsonGet = {
        "logradouro": formularioImovelStore.controllRua.text,
        "numero": formularioImovelStore.controllNum.text,
        "complemento": formularioImovelStore.controllComplemento.text,
      };
    }

    // faz a requisição
    var responsePostByendereco = await PostHttpRequestApp(context)
        .makeJsonRequest(url: urlFindImovelByAddress, params: jsonGet);

    responsePostByendereco.fold((l) async {
      // se o imovel não for encontrado ou requicao voltar erro 404
      if (l.code == 404) {
        formularioImovelStore.jsonErroVisitaImovel = null;

        formularioImovelStore.setJsonImovelErroVisita({'message': l.descricao});
        // return Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => ErroIniciaVisitaPage()));
      }
      if (l.code != 1) {
        return null;
      }
    }, (r) async {
      // ser a response vier mais de um elemento ele vai para a lista de imoveis
      await viewModelStore.setListaImoveisVisita(r);
      // essa verificação é para caso o usuario digite um endereço que não existe imovel cadastrado
      if (viewModelStore.listaImoveisVisita.isEmpty) {
        formularioImovelStore.jsonErroVisitaImovel = null;
        if (viewModelStore.imovelVisita.enderecoId != null) {
          formularioImovelStore.setLoad(false);

          // ignore: use_build_context_synchronously
          return Navigator.push(
              context, MaterialPageRoute(builder: (_) => DetalhesImovelPage()));
        } else {
          formularioImovelStore.setLoad(false);
          // ignore: use_build_context_synchronously
          await GlobalsAlerts(context).alertErro(
              "Atenção Erro ao Inciar a visita ",
              "Busque o imovel e tente novamente");
          // ignore: use_build_context_synchronously
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HomeVigPage(
                        rebirth: () {},
                      )));
        }
      }

      // se a response vier apenas um elemento ele vai para o detalhes do imovel
      if (viewModelStore.listaImoveisVisita.length == 1) {
        viewModelStore.imovelVisita = viewModelStore.listaImoveisVisita.first;
        formularioImovelStore.setLoad(false);

        // ignore: use_build_context_synchronously
        return Navigator.push(
            context, MaterialPageRoute(builder: (_) => DetalhesImovelPage()));
      }

      // se a response vier mais de um elemento ele vai para a lista de imoveis
      if (viewModelStore.listaImoveisVisita.length > 1) {
        formularioImovelStore.setLoad(false);

        // ignore: use_build_context_synchronously
        return Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ListaImoveisPage()));
      }
    });
  }

// FUNÇÃO RESPONSAVEL POR BUSCAR O IMÓVEL PELO QRCODE
  Future getImoveisPeloQrCode() async {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);

    bool error = false;
    bool response = true;

    var resultGetImoveisByQrcode = await GetHttpRequestApp(context)
        .makeGetJsonRequest(
            url: urlQrCodeImovel, params: iniciaVisitaStore.valorQr);

    resultGetImoveisByQrcode.fold((l) {
      GlobalsAlerts(context).alertErro("Erro ao Buscar o Imóvel ", l.descricao);
      error = true;
    }, (r) async {
      log("resultGetImoveisByQrcode: $r");
      if (r["message"] != null) {
        formularioImovelStore.setJsonImovelErroVisita(r["message"]);
        // não encontrou o imovel
        response = false;
      }
      // encontrou o imovel

      viewModelStore.imovelVisita =
          await viewModelStore.setImovelVisitaFromJson(r, 1);
      response = true;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => DetalhesImovelPage()),
          (route) => true);
    });
    log("response: $response  error: $error");
    if (error) {
      iniciaVisitaStore.setLoad(false);
      return -1;
    }

    if (response) {
      // Achou imovel
      return 1;
    }
    // Não achou imovel
    else {
      return 2;
    }
  }

// FUNÇÃO RESPONSAVEL POR VERIFICAR SE TODOS OS DADOS ESTÃO SALVOS LOCALMENTE
  Future verificaTodosDadosSalvosLocal() async {
    final formularioQuestoesVisitaStore =
        Provider.of<FormularioQuestoesVisitaStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    final fileQuestionario = await LocalPathStore().getEpQuestionario;
    final fileBairros = await LocalPathStore().localEpBairro;
    final fileTipoImovel = await LocalPathStore().tipoImovel;
    final fileRuas = await LocalPathStore().localEpRuas;
    final fileLarvicidas = await LocalPathStore().getLarvicida;

    if (!await fileQuestionario.exists()) {
      return false;
    }
    if (!await fileBairros.exists()) {
      return false;
    }
    if (!await fileTipoImovel.exists()) {
      return false;
    }
    if (!await fileRuas.exists()) {
      return false;
    }
    if (!await fileLarvicidas.exists()) {
      return false;
    }
    // questionario
    formularioQuestoesVisitaStore.listaChecksQuestionario.clear();
    formularioQuestoesVisitaStore.listaChecks.clear();
    formularioQuestoesVisitaStore
        .setAddAllListChecks(jsonDecode(await fileQuestionario.readAsString()));
    // tipo imovel
    formularioImovelStore
        .setJsonTipoImovel(jsonDecode(await fileTipoImovel.readAsString()));

    await setDropImovel();
    // bairros
    formularioImovelStore
        .setListAllBairros(jsonDecode(await fileBairros.readAsString()));
    // ruas

    formularioImovelStore
        .setListAddRuas(jsonDecode(await fileRuas.readAsString()));
    // larvicidas
    formularioQuestoesVisitaStore.tipoLarvicida.clear();
    formularioQuestoesVisitaStore
        .setJsonLarvicida(jsonDecode(await fileLarvicidas.readAsString()));

    await FormularioQuestoesVisitaFunctions(context).setDropLarvicida();
    return true;
  }

// FUNÇÃO RESPONSAVEL POR INICIAR O APP E BUSCAR TODOS OS DADOS
  Future iniciaGetsApp() async {
    bool retornoLocal = await verificaTodosDadosSalvosLocal();
    print("retornoLocal: $retornoLocal");
    if (retornoLocal) return true;

    await getTipoImovel();
    await getBairros();
    await getRuas();
    await getQuestionario();
    await getLarvicidas();
    bool retornoLocalAux = await verificaTodosDadosSalvosLocal();
    print("retornoLocalAux: $retornoLocalAux");
    if (!retornoLocalAux) {
      GlobalsAlerts(context).alertErro("Erro ao Buscar os Dados",
          "Não foi possível buscar os dados do servidor, verifique sua conexão com a internet e tente novamente.");
      return false;
    }
    return false;
  }

// FUNÇÃO RESPONSAVEL POR BUSCAR O QRCODE PELO O VALOR DELE
  Future buscaQrcodeID() async {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    var mapResult = await GetHttpRequestApp(context).makeGetJsonRequest(
        url: urlGetQrCodeByValor, params: iniciaVisitaStore.valorQr);

    mapResult.fold((l) async {
      iniciaVisitaStore.setValorQrId('');
      return false;
    }, (right) async {
      iniciaVisitaStore.setValorQrId(right["id"]);

      log("MapGetResultQrCode: $right");
      return true;
    });
  }

// FUNÇÃO RESPONSÁVEL POR BUSCAR OS TIPOS DE IMÓVEIS
  Future getTipoImovel() async {
    final infoImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final fileTipoImovel = await LocalPathStore().tipoImovel;

    var mapResult =
        await GetHttpRequestApp(context).makeGetJsonRequest(url: urlTipoImovel);

    mapResult.fold((l) async {
      await GlobalsAlerts(context)
          .alertErro("Atenção Erro:${l.code}", "${l.descricao}");
      if (await fileTipoImovel.exists()) {
        var _right = await fileTipoImovel.readAsString();
        infoImovelStore.setJsonTipoImovel(jsonDecode(_right));
        log("Tipo Imovel : $_right");
        await setDropImovel();
        return;
      }
    }, (r) async {
      await fileTipoImovel.writeAsString(jsonEncode(r));
      infoImovelStore.setJsonTipoImovel(r);
      await setDropImovel();
    });
  }

// FUNÇÃO RESPONSÁVEL POR SETAR A LISTA DOS VALORES DO DROPDOWN
  setDropImovel() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    final infoImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    int qtde = infoImovelStore.jsonTipoImovel.length;
    int i;
    if (infoImovelStore.jsonTipoImovel != null) {
      items.add(
        DropdownMenuItem(
          value: '',
          child: Text(
            'TIPO DE IMÓVEL',
            style: KThemeModeApp.of(context).bodyLarge,
          ),
        ),
      );
      for (i = 0; i < qtde; i++) {
        items.add(
          DropdownMenuItem(
            value: infoImovelStore.jsonTipoImovel[i]['id'].toString(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  infoImovelStore.jsonTipoImovel[i]['tipo'],
                  style: KThemeModeApp.of(context).bodyLarge,
                ),
              ],
            ),
          ),
        );
      }

      infoImovelStore.setDropList(items);
    }
  }

// FUNÇÃO RESPONSÁVEL POR BUSCAR OS BAIRROS
  Future getBairros() async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    final fileBairro = await LocalPathStore().localEpBairro;

    var mapResult = await GetHttpRequestApp(context)
        .makeGetJsonRequest(url: urlBairros, params: '');
    mapResult.fold((l) async {
      await GlobalsAlerts(context)
          .alertErro("Atenção Erro:${l.code}", "${l.descricao}");
    }, (r) async {
      log("setou local");
      await fileBairro.writeAsString(jsonEncode(r));
      formularioImovelStore.setListAllBairros(r);
    });
  }

// FUNÇÃO RESPONSÁVEL POR BUSCAR AS RUAS
  Future getRuas() async {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final fileRuas = await LocalPathStore().localEpRuas;
    if (formularioImovelStore.listaBairrosOrigin.isNotEmpty &&
        formularioImovelStore.listaRuasOrigin.isNotEmpty) return;
    if (await fileRuas.exists()) {
      var _right = await fileRuas.readAsString();

      formularioImovelStore.setListAddRuas(jsonDecode(_right));
      return;
    }

    var mapRuas =
        await GetHttpRequestApp(context).makeGetJsonRequest(url: urlRuas);
    mapRuas.fold((l) async {
      return await GlobalsAlerts(context)
          .alertErro("Atenção Erro:${l.code}", "${l.descricao}");
    }, (right) async {
      List _rigthBairro = [];
      _rigthBairro.addAll(right);
      if (await fileRuas.exists()) {
        List _right = [];

        _right.addAll(jsonDecode(await fileRuas.readAsString()));
        if (_right.length < _rigthBairro.length) {
          await fileRuas.writeAsString(jsonEncode(right));
          formularioImovelStore.setListAddRuas(right);
        }
        await fileRuas.writeAsString(jsonEncode(right));
        formularioImovelStore.setListAddRuas(right);
      } else {
        log("setou local");
        await fileRuas.writeAsString(jsonEncode(right));
        formularioImovelStore.setListAddRuas(right);
      }
    });
  }

// FUNÇÃO RESPONSÁVEL POR BUSCAR OS QUARTEIRÕES BELO BAIRRO SELECIONADO
  Future<List<DropdownMenuItem<String>>> setDropQuarteirao(
      totalQuarteirao) async {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    log("chegou $totalQuarteirao");
    int i;

    items.add(
      DropdownMenuItem(
        value: '',
        child:
            Text('Quarteirão N°', style: KThemeModeApp.of(context).bodySmall),
      ),
    );

    for (i = 1; i < totalQuarteirao + 1; i++) {
      items.add(
        DropdownMenuItem(
          value: i.toString(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(i.toString(), style: KThemeModeApp.of(context).bodyMedium),
            ],
          ),
        ),
      );
    }

    log("message: ${items.length}");
    return items;
  }

// FUNÇÃO RESPONSAVEL POR BUSCAR OS LARVICIDAS
  Future getLarvicidas() async {
    final formularioQuestoesVisitaStore =
        Provider.of<FormularioQuestoesVisitaStore>(context, listen: false);
    final file = await LocalPathStore().getLarvicida;

    var mapResult = await GetHttpRequestApp(context)
        .makeGetJsonRequest(url: urlGetLarvicidas, params: '');

    mapResult.fold(
      (left) async {
        if (await GlobalsFunctions(context).verificaInternet()) {
          if (await file.exists()) {
            formularioQuestoesVisitaStore.tipoLarvicida.clear();
            formularioQuestoesVisitaStore
                .setJsonLarvicida(jsonDecode(await file.readAsString()));
            await FormularioQuestoesVisitaFunctions(context).setDropLarvicida();

            return;
          }
        }
        GlobalsAlerts(context).alertErro(
            "Atenção Erro : ${left.code.toString()}", left.descricao);
        formularioQuestoesVisitaStore.setJsonLarvicida(null);

        return null;
      },
      (right) async {
        log("MapGetLarvicidas: $right");
        if (formularioQuestoesVisitaStore.tipoLarvicida.isEmpty) {
          formularioQuestoesVisitaStore.setJsonLarvicida(right);
          await file.writeAsString(jsonEncode(right));
          await FormularioQuestoesVisitaFunctions(context).setDropLarvicida();
        } else {
          formularioQuestoesVisitaStore.tipoLarvicida.clear();
          formularioQuestoesVisitaStore.setJsonLarvicida(right);
          await file.writeAsString(jsonEncode(right));
          await FormularioQuestoesVisitaFunctions(context).setDropLarvicida();
        }

        return right;
      },
    );
  }

// FUNÇÃO RESPONSAVEL POR BUSCAR O QUESTIONARIO
  Future getQuestionario() async {
    final formularioQuestoesVisitaStore =
        Provider.of<FormularioQuestoesVisitaStore>(context, listen: false);
    final file = await LocalPathStore().getEpQuestionario;
    if (await file.exists()) {
      formularioQuestoesVisitaStore.listaChecksQuestionario.clear();
      formularioQuestoesVisitaStore.listaChecks.clear();
      formularioQuestoesVisitaStore
          .setAddAllListChecks(jsonDecode(await file.readAsString()));
      return;
    }

    var mapResult = await GetHttpRequestApp(context)
        .makeGetJsonRequest(url: urlQuestions, params: '');

    mapResult.fold(
      (left) async {
        if (await GlobalsFunctions(context).verificaInternet()) {
          if (await file.exists()) {
            formularioQuestoesVisitaStore.listaChecksQuestionario.clear();
            formularioQuestoesVisitaStore.listaChecks.clear();
            formularioQuestoesVisitaStore
                .setAddAllListChecks(jsonDecode(await file.readAsString()));
            return;
          }
        }
        GlobalsAlerts(context).alertErro(
            "Atenção Erro : ${left.code.toString()}", left.descricao);
        formularioQuestoesVisitaStore.setAddAllListChecks(null);

        return null;
      },
      (right) async {
        log("MapGetQuestionario: $right");
        if (formularioQuestoesVisitaStore.listaChecks.isEmpty &&
            formularioQuestoesVisitaStore.listaChecksQuestionario.isEmpty) {
          formularioQuestoesVisitaStore.setAddAllListChecks(right);
          await file.writeAsString(jsonEncode(right));
        } else {
          formularioQuestoesVisitaStore.listaChecksQuestionario.clear();
          formularioQuestoesVisitaStore.listaChecks.clear();
          formularioQuestoesVisitaStore.setAddAllListChecks(right);
          await file.writeAsString(jsonEncode(right));
        }

        return right;
      },
    );
  }
}
