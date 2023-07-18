import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_url.dart';
import 'package:componets_kombat/home/home_page.dart';
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

  Future signInWithEmailAndPassword(
      String emailcontroller, senhacontroller) async {
    Map<String, dynamic> login = {};
    // create replace all for reomove . and -
    var cpfSplit = emailcontroller.split('.').join('').split('-').join('');

    // var cpfAux = email.toString().replaceAll(RegExp('.\\-'), '');
    print("CPF > $cpfSplit ");
    login["login"] = cpfSplit.toString();
    login["pswd"] = '$senhacontroller';
    print('$emailcontroller ${login["pswd"]}');
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

      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomeVigPage(
                    rebirth: () {},
                  )));
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

// class FunctionsApp {
//   BuildContext context;
//   FunctionsApp(this.context);

//   Future<bool> verificaInternet() async {
//     var result = await GlobalsFunctions(context).verificaInternet();
//     if (!result) {
//       GlobalsAlerts(context).alertErro(
//           "Atenção", "Sem conexão com a internet, verifique sua conexão");
//       return false;
//     }
//     return true;
//   }
  
  
//   Future verificaTodosDadosSalvosLocal() async {
//     // final formularioDadosStore =
//     //     Provider.of<FormularioCheckStore>(context, listen: false);
//     // final infoImovelStore =
//     //     Provider.of<FormularioImovelStore>(context, listen: false);
//     // final formularioImovelStore =
//     //     Provider.of<FormularioImovelStore>(context, listen: false);
//     // final forumarioStore =
//     //     Provider.of<FormularioCheckStore>(context, listen: false);

//     final fileQuestionario = await LocalPathStore().getEpQuestionario;
//     final fileBairros = await LocalPathStore().localEpBairro;
//     final fileTipoImovel = await LocalPathStore().tipoImovel;
//     final fileRuas = await LocalPathStore().localEpRuas;
//     final fileLarvicidas = await LocalPathStore().getLarvicida;

//     if (!await fileQuestionario.exists()) {
//       return false;
//     }
//     if (!await fileBairros.exists()) {
//       return false;
//     }
//     if (!await fileTipoImovel.exists()) {
//       return false;
//     }
//     if (!await fileRuas.exists()) {
//       return false;
//     }
//     if (!await fileLarvicidas.exists()) {
//       return false;
//     }
//     // questionario
//     forumarioStore.listaChecksQuestionario.clear();
//     forumarioStore.listaChecks.clear();
//     forumarioStore
//         .setAddAllListChecks(jsonDecode(await fileQuestionario.readAsString()));
//     // tipo imovel
//     infoImovelStore
//         .setJsonTipoImovel(jsonDecode(await fileTipoImovel.readAsString()));

//     await FormularioImovelFunctions(context).setDropImovel();
//     // bairros
//     formularioImovelStore
//         .setListAllBairros(jsonDecode(await fileBairros.readAsString()));
//     // ruas

//     formularioImovelStore
//         .setListAddRuas(jsonDecode(await fileRuas.readAsString()));
//     // larvicidas
//     formularioDadosStore.tipoLarvicida.clear();
//     formularioDadosStore
//         .setJsonLarvicida(jsonDecode(await fileLarvicidas.readAsString()));

//     await  setDropLarvicida();
//     return true;
//   }

//   Future iniciaGetsApp() async {
//     bool retornoLocal = await verificaTodosDadosSalvosLocal();
//     print("retornoLocal: $retornoLocal");
//     if (retornoLocal) return true;

//     await getTipoImovel();
//     await getBairros();
//     await getRuas();
//     await GetInciaVisitaAgente(context).getQuestionario();
//     await GetInciaVisitaAgente(context).getLarvicidas();
//     bool retornoLocalAux = await verificaTodosDadosSalvosLocal();
//     print("retornoLocalAux: $retornoLocalAux");
//     if (!retornoLocalAux) {
//       GlobalsAlerts(context).alertErro("Erro ao Buscar os Dados",
//           "Não foi possível buscar os dados do servidor, verifique sua conexão com a internet e tente novamente.");
//       return false;
//     }
//     return false;
//   }
  
// // FUNÇÃO RESPONSÁVEL POR VALIDAR OS CAMPOS DO FORMULÁRIO
//   Future<bool> validador() async {
//     final infoImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);

//     if (infoImovelStore.controllBairro.text.isNotEmpty &&
//         infoImovelStore.bairroIdSel != 0 &&
//         infoImovelStore.ruaSel != "" &&
//         // infoImovelStore.controllCep.text.isNotEmpty &&
//         infoImovelStore.controllRua.text.isNotEmpty &&
//         infoImovelStore.controllNum.text.isNotEmpty &&
//         infoImovelStore.quartId != "" &&
//         infoImovelStore.tipo != '') {
//       return true;
//     } else {
//       // print(infoImovelStore.controllBairro.text);
//       // print(infoImovelStore.controllRua.text);
//       // print(infoImovelStore.controllBairro.text);
//       // print(infoImovelStore.controllNum.text);
//       // print(infoImovelStore.tipoImovelId);
//       return false;
//     }
//   }

//   Future getBairros() async {
//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);

//     final fileBairro = await LocalPathStore().localEpBairro;

//     var mapResult = await GetHttpRequestApp(context)
//         .makeGetJsonRequest(url: "bairros", params: '');
//     mapResult.fold((l) async {
//       await GlobalsAlerts(context)
//           .alertErro("Atenção Erro:${l.code}", "${l.descricao}");
//     }, (r) async {
//       log("setou local");
//       await fileBairro.writeAsString(jsonEncode(r));
//       formularioImovelStore.setListAllBairros(r);
//     });
//   }

//   Future getRuas() async {
//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);
//     final fileRuas = await LocalPathStore().localEpRuas;
//     if (formularioImovelStore.listaBairrosOrigin.isNotEmpty &&
//         formularioImovelStore.listaRuasOrigin.isNotEmpty) return;
//     if (await fileRuas.exists()) {
//       var _right = await fileRuas.readAsString();

//       formularioImovelStore.setListAddRuas(jsonDecode(_right));
//       return;
//     }

//     var mapRuas =
//         await GetHttpRequestApp(context).makeGetJsonRequest(url: 'ruas');
//     mapRuas.fold((l) async {
//       return await GlobalsAlerts(context)
//           .alertErro("Atenção Erro:${l.code}", "${l.descricao}");
//     }, (right) async {
//       List _rigthBairro = [];
//       _rigthBairro.addAll(right);
//       if (await fileRuas.exists()) {
//         List _right = [];

//         _right.addAll(jsonDecode(await fileRuas.readAsString()));
//         if (_right.length < _rigthBairro.length) {
//           await fileRuas.writeAsString(jsonEncode(right));
//           formularioImovelStore.setListAddRuas(right);
//         }
//         await fileRuas.writeAsString(jsonEncode(right));
//         formularioImovelStore.setListAddRuas(right);
//       } else {
//         log("setou local");
//         await fileRuas.writeAsString(jsonEncode(right));
//         formularioImovelStore.setListAddRuas(right);
//       }
//     });
//   }

//   Future getTipoImovel() async {
//     final fileTipoImovel = await LocalPathStore().tipoImovel;
//     final infoImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);

//     var mapResult = await GetHttpRequestApp(context)
//         .makeGetJsonRequest(url: 'tipo-imoveis');

//     mapResult.fold((l) async {
//       await GlobalsAlerts(context)
//           .alertErro("Atenção Erro:${l.code}", "${l.descricao}");
//       if (await fileTipoImovel.exists()) {
//         var _right = await fileTipoImovel.readAsString();
//         infoImovelStore.setJsonTipoImovel(jsonDecode(_right));
//         log("Tipo Imovel : $_right");
//         await FormularioImovelFunctions(context).setDropImovel();
//         return;
//       }
//     }, (r) async {
//       await fileTipoImovel.writeAsString(jsonEncode(r));
//       infoImovelStore.setJsonTipoImovel(r);
//       await FormularioImovelFunctions(context).setDropImovel();
//     });
//   }

// // FUNÇÃO RESPONSÁVEL POR SETAR A LISTA DOS VALORES DO DROPDOWN
//   setDropImovel() {
//     List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
//     final infoImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);

//     int qtde = infoImovelStore.jsonTipoImovel.length;
//     int i;
//     if (infoImovelStore.jsonTipoImovel != null) {
//       items.add(
//         DropdownMenuItem(
//           value: '',
//           child: Text(
//             'TIPO DE IMÓVEL',
//             style: KThemeModeApp.of(context).bodyLarge,
//           ),
//         ),
//       );
//       for (i = 0; i < qtde; i++) {
//         items.add(
//           DropdownMenuItem(
//             value: infoImovelStore.jsonTipoImovel[i]['id'].toString(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   infoImovelStore.jsonTipoImovel[i]['tipo'],
//                   style: KThemeModeApp.of(context).bodyLarge,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }

//       infoImovelStore.setDropList(items);
//     }
//   }

//   Future<List<DropdownMenuItem<String>>> setDropQuarteirao(
//       totalQuarteirao) async {
//     List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
//     log("chegou $totalQuarteirao");
//     int i;

//     items.add(
//       DropdownMenuItem(
//         value: '',
//         child:
//             Text('Quarteirão N°', style: KThemeModeApp.of(context).bodySmall),
//       ),
//     );

//     for (i = 1; i < totalQuarteirao + 1; i++) {
//       items.add(
//         DropdownMenuItem(
//           value: i.toString(),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(i.toString(), style: KThemeModeApp.of(context).bodyMedium),
//             ],
//           ),
//         ),
//       );
//     }

//     log("message: ${items.length}");
//     return items;
//   }

//   Future setJsonCadastrarImovel() async {
//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);
//     int numero = int.parse(formularioImovelStore.controllNum.text);
//     int quarteiraoNumero = int.parse(formularioImovelStore.controllQuart.text);
//     int lado = int.parse(formularioImovelStore.controllLado.text);

//     // log("Json: ${_json}");
//     final _envio = {
//       "logradouro": formularioImovelStore.controllRua.text,
//       "numero": numero,
//       "complemento": formularioImovelStore.controllComplemento.text,
//       "bairro": formularioImovelStore.controllBairro.text,
//       "tipo_imovel_id": formularioImovelStore.tipoImovelId,
//       "bairro_id": formularioImovelStore.bairroIdSel,
//       "quarteirao_numero": quarteiraoNumero,
//       "lado": lado,
//       // "cidade_id": 5,
//       // "estado_id": 4,
//     };
//     log("Envio: $_envio");

//     return jsonEncode(_envio);
//   }

//   Future filterSearchResultsBairro(String query) async {
//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);

//     if (query.isNotEmpty) {
//       formularioImovelStore
//           .setaddAllBairrosAutoComplete(await comparaQueryBairro(query));

//       return;
//     } else {
//       formularioImovelStore.setaddAllBairrosAutoComplete(
//           formularioImovelStore.listaBairrosOrigin);
//       return;
//     }
//   }
//   // a função compar query verifica somente os nomes de empreass

//   Future<dynamic> comparaQueryBairro(query) async {
//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);
//     List<GetBairro> listaAuxiliar = [];
//     listaAuxiliar.clear();
//     for (int i = 0;
//         i < formularioImovelStore.listaSearchStringSemAcentos.length;
//         i++) {
//       if (formularioImovelStore.listaSearchStringSemAcentos[i].nome
//               .toString()
//               .contains(query.toString().toUpperCase()) ||
//           query.toString().toUpperCase().similarityTo(
//                   '${formularioImovelStore.listaSearchStringSemAcentos[i].nome}') >
//               0.6) {
//         if (!(listaAuxiliar.contains(
//             formularioImovelStore.listaSearchStringSemAcentos[i].id))) {
//           listaAuxiliar.add(
//             GetBairro(
//                 nome: formularioImovelStore.listaSearchStringSemAcentos[i].nome,
//                 id: formularioImovelStore.listaSearchStringSemAcentos[i].id),
//           );
//         }
//       }
//     }
//     return listaAuxiliar;
//   }

//   Future filterSearchResultsRua(String query) async {
//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);

//     if (query.isNotEmpty) {
//       formularioImovelStore
//           .setAddAllListaRuasMostrar(await comparaQueryRua(query));

//       return;
//     } else {
//       formularioImovelStore
//           .setAddAllListaRuasMostrar(formularioImovelStore.listaRuasOrigin);
//       return;
//     }
//   }
//   // a função compar query verifica somente os nomes de empreass

//   Future<dynamic> comparaQueryRua(query) async {
//     final formularioImovelStore =
//         Provider.of<FormularioImovelStore>(context, listen: false);
//     List<GetRua> listaAuxiliar = [];
//     listaAuxiliar.clear();
//     for (int i = 0;
//         i < formularioImovelStore.listaRuasSearchStringSemAcentos.length;
//         i++) {
//       if (formularioImovelStore.listaRuasSearchStringSemAcentos[i].nome
//               .toString()
//               .contains(query.toString().toUpperCase()) ||
//           query.toString().toUpperCase().similarityTo(
//                   '${formularioImovelStore.listaRuasSearchStringSemAcentos[i].nome}') >
//               0.5) {
//         if (!(listaAuxiliar.contains(
//             formularioImovelStore.listaRuasSearchStringSemAcentos[i].id))) {
//           listaAuxiliar.add(
//             GetRua(
//                 nome: formularioImovelStore
//                     .listaRuasSearchStringSemAcentos[i].nome,
//                 id: formularioImovelStore
//                     .listaRuasSearchStringSemAcentos[i].id),
//           );
//         }
//       }
//     }
//     return listaAuxiliar;
//   }
// }

// mixin ValidaFormImovel {
//   Future<String>? cepValidateLength(value) async {
//     if (value.isEmpty) return "Campo CEP não pode ser vazio";
//     if (!value.contains("3750")) {
//       return "CEP não pode exceder o limite do municipio";
//     }

//     return null.toString();
//   }

//   String? isNotEmpty(String? value, [String? message]) {
//     if (value!.isEmpty) return message ?? "Esse campo é obrigatório";
//     return null;
//   }
// }

 

