import 'package:componets_kombat/model/questionario/questionario_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'forumario_questoes_visita_store.g.dart';

class FormularioQuestoesVisitaStore = _FormularioQuestoesVisitaStoreBase
    with _$FormularioQuestoesVisitaStore;

abstract class _FormularioQuestoesVisitaStoreBase with Store {
  @observable
  int sizeList = 0; // Tamanho da lista de checks

  @observable
  bool loading = false;

  @observable
  var jsonLarvicida;

  @action
  void setJsonLarvicida(_value) {
    jsonLarvicida = _value;
  }

  @action
  void setTipoLarvicida(_value) {
    tipoLarvicida.clear();
    tipoLarvicida = _value;
  }

  @action
  void setLoading(_value) {
    loading = _value;
  }

  ObservableList<TextEditingController> listadeControladores =
      ObservableList<TextEditingController>();

  @action
  void setCreateListcontrollers() {
    for (var i = 0; i < listaChecks.length; i++) {
      final textController = TextEditingController();
      textController.clear();
      listadeControladores.add(textController);
    }
  }

  @action
  void setAddListadeControladores(_index, _value) {
    listadeControladores[_index].value = _value;
  }

  @observable
  List<Map<String, dynamic>> questionarioRespList = <Map<String, dynamic>>[];

  ObservableList<int> listaSim =
      ObservableList(); // Lista dos checks marcados como sim

  ObservableList<int> listaNao =
      ObservableList(); // Lista dos checks marcados como não

  ObservableList<int> groupLista =
      ObservableList(); // Lista dos agrupamento de todos checks

  @observable
  var tipo = '';

  @observable
  List<DropdownMenuItem<String>> tipoLarvicida = [];

  @action
  void setTipo(_value) {
    tipo = _value;
  }

//Lista estática dos elementos do checklist (temporária)

  ObservableList<Questao> listaChecks = ObservableList<Questao>();
  ObservableList<Questao> listaChecksQuestionario = ObservableList<Questao>();

  @action
  void limpaTudo() {
    listaSim.clear();
    listaNao.clear();
    groupLista.clear();
    questionarioRespList.clear();
  }

  @action
  void setquestionarioRespList(_value) {
    questionarioRespList.add(_value);
  }

  @action
// ZERA TODOS OS CHECKS E INICIA AS LISTAS COMO NULL
  zeraChecks() {
    listaSim.clear();
    listaNao.clear();
    for (int i = 0; i < sizeList; i++) {
      groupLista.add(-1);
      listaSim.add(0);
      listaNao.add(0);
    }
  }

  @action
  void setAddAllListChecks(_json) {
    for (var i = 0; i < _json.length; i++) {
      if (_json[i]["tipo_questao"] == 1) {
        listaChecksQuestionario.add(Questao.fromJson(_json[i]));
      }
      if (_json[i]["tipo_questao"] == 0) {
        listaChecks.add(Questao.fromJson(_json[i]));
      }
    }
  }

  @action
// SETA O TAMANHO DA LISTA DE CHECKS
  getSizeList() => sizeList = listaChecks.length;

  @action
// ALTERA O VALOR DO ITEM AGRUPADO
  setGroupList(index) {
    groupLista[index] = 1;
    return groupLista[index];
  }

  @action
// SE O CHECK SIM FOR CLICADO ALTERNA ENTRE ATIVO E INATIVO
  changeCheck01(int index) {
    if (listaSim[index] == 0) {
      listaSim[index] = 1;
      listaNao[index] = 0;
    } else {
      listaSim[index] = 0;
      listaNao[index] = 1;
    }
  }

  @action
// SE O CHECK NAO FOR CLICADO ALTERNA ENTRE ATIVO E INATIVO
  changeCheck02(int index) {
    if (listaNao[index] == 0) {
      listaNao[index] = 1;
      listaSim[index] = 0;
    } else {
      listaSim[index] = 1;
      listaNao[index] = 0;
    }
  }
}
