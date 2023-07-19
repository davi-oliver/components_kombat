// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'formulario_imovel_store.g.dart';

class FormularioImovelStore = _FormularioImovelStore
    with _$FormularioImovelStore;

abstract class _FormularioImovelStore with Store {
  ObservableList<GetBairro> listaBairrosSearch = ObservableList();
  ObservableList<GetBairro> listaBairrosOrigin = ObservableList();
  ObservableList<GetBairro> listaSearchStringSemAcentos = ObservableList();

  ObservableList<GetRua> listaRuasSearch = ObservableList();
  ObservableList<GetRua> listaRuasOrigin = ObservableList();
  ObservableList<GetRua> listaRuasSearchStringSemAcentos = ObservableList();
  ObservableList listaImoveisOffLine = ObservableList();

  @observable
  int bairroIdSel = 0;

  @observable
  var quartId = '';
  @observable
  bool visibilidadeInciarVisita = false;

  @action
  void setListaImoveisOffLine(_value) {
    listaImoveisOffLine.add(_value);
  }

  @action
  void setVisibilidadeVisita(_value) {
    visibilidadeInciarVisita = _value;
  }

  @observable
  bool visibilidadeVincularQrCode = false;
  @action
  void setQuartID(_value) => quartId = _value;

  @observable
  bool visibilidadeListaBairros = false;

  @observable
  bool visibilidadeListaRuas = false;
  @observable
  bool valueApto = false;

  @observable
  bool valueCasa = false;

  @observable
  bool valueKitnet = false;

  @action
  void setValueAptRadio(_value) {
    valueApto = _value;

    if (valueApto) {
      if (controllComplemento.text.isNotEmpty) {
        controllComplemento.clear();
      }
      valueCasa = false;
      valueKitnet = false;
      controllComplemento.text = "Apto";
    }
  }

  @action
  void setValueCasaRadio(_value) {
    valueCasa = _value;

    if (valueCasa) {
      if (controllComplemento.text.isNotEmpty) {
        controllComplemento.clear();
      }
      valueApto = false;
      valueKitnet = false;
      controllComplemento.text = "Casa";
    }
  }

  @action
  void setValueKitnetRadio(_value) {
    valueKitnet = _value;

    if (valueKitnet) {
      if (controllComplemento.text.isNotEmpty) {
        controllComplemento.clear();
      }
      valueApto = false;
      valueCasa = false;
      controllComplemento.text = "Kitnet";
    }
  }

  @action
  void setaddAllBairrosAutoComplete(_value) {
    listaBairrosSearch.clear();

    listaBairrosSearch.addAll(_value);
  }

  @action
  void setListAllBairros(_value) {
    listaBairrosSearch.clear();
    listaBairrosOrigin.clear();
    listaSearchStringSemAcentos.clear();

    _value.forEach((e) async {
      if (!listaBairrosOrigin.contains(e['nome'])) {
        listaBairrosOrigin.add(GetBairro.fromJson(e));
        var _jsonEmpresasNome = GetBairro(
          nome: await removerAcentos(e['nome'].toString().toUpperCase()),
          id: e['id'],
        );
        listaSearchStringSemAcentos.add(_jsonEmpresasNome);
      }
    });

    listaBairrosSearch.addAll(listaBairrosOrigin);
  }

  @action
  void setListAddRuas(_json) {
    listaRuasOrigin.clear();
    listaRuasSearch.clear();
    listaRuasSearchStringSemAcentos.clear();

    _json.forEach((element) async {
      if (!listaRuasOrigin.contains(element['nome'])) {
        listaRuasOrigin.add(GetRua.fromJson(element));
        var _jsonEmpresasNome = GetRua(
          nome: removerAcentos(element['nome'].toString().toUpperCase()),
          id: element['id'],
        );
        listaRuasSearchStringSemAcentos.add(_jsonEmpresasNome);
      }
    });
  }

  @action
  void setAddAllListaRuasMostrar(_value) {
    listaRuasSearch.clear();
    listaRuasSearch.addAll(_value);
  }

  @action
  void setBairroId(_id, nome) {
    bairroIdSel = _id;
    controllBairro.text = nome;

    log("BairroId: $bairroIdSel");
    log("BairroSel: ${controllBairro.text}");
  }

  @action
  void setVisitbilidadeListaBairros(_value) {
    visibilidadeListaBairros = _value;
  }

  @action
  void setVisitbilidadeListaRuas(_value) {
    visibilidadeListaRuas = _value;
  }

  var jsonTipoImovel; // Json com lista dos valores do dropdown

  var jsonExterno; // Json com os dados do imóvel de fechado/recusa e Inicia Visita (Quando usa mesmo qr code)

  var jsonVisitaNovoQr; // Json com os dados do imóvel de Inicia Visita (Quando mudará o Qr code)

  @observable
  var jsonErroVisitaImovel;

  @observable
  var enderecoId;

  @action
  void setEnderecoId(_value) => enderecoId = _value;

  bool externo = false;

  @observable
  String qrCode = ""; // Código QR de fechado/recusa

  @observable
  bool load = false; // Booleano responsável pelo controle do carregamento

  @observable
  int tipoImovelId = 0; // Id usado para o cadastro(push) do tipo imóvel

  // @observable
  // TextEditingController controllCep =
  //     TextEditingController(); // Controlador CEP

  @observable
  TextEditingController controllNum =
      TextEditingController(); // Controlador número

  @observable
  TextEditingController controllComplemento = TextEditingController();

  @observable
  TextEditingController controllBairro =
      TextEditingController(); //Controlador bairro

  @observable
  TextEditingController controllLado =
      TextEditingController(); // Controlador lado

  @observable
  TextEditingController controllQuart =
      TextEditingController(); // Controlador quarteirão

  @observable
  TextEditingController controllRua =
      TextEditingController(); // Controlador rua

  @observable
  var tipo = ''; // Possui o tipo de imóvel escolhido no dropdown

  @observable
  List<DropdownMenuItem<String>> tipoImovelList =
      []; //Lista com os tipos de de imóveis do dropdown

  @observable
  List<DropdownMenuItem<String>> jsonQuart = []; //Lista com os tipos de d

  @action
  void setRua(_value) {
    ruaSel = _value;
    controllRua.text = _value;
    // ruaSel = controllerLogradouroIniciaVisita.text = _value;
    // TODO: Verificar se é necessário
  }

  @observable
  var ruaSel = '';

  @action
  void setJsonImovelErroVisita(_value) => jsonErroVisitaImovel = _value;
  @action
  setExterno(value) => externo = value;

  @action
  setLoad(_value) => load = _value;

  @action
  // FUNÇÃO RESPONSÁVEL POR SETAR DO JSON OS VALORES DO DROPDOWN
  setJsonTipoImovel(value) => jsonTipoImovel = value;

  // @action
  // setJsonVisita(value) => jsonVisita = value;

  @action
  setJsonVisitaNovoQr(value) => jsonVisitaNovoQr = value;

  @action
  // FUNÇÃO RESPONSÁVEL POR PREENCHER RUA E BAIRRO CONFORME O CEP
  cepCampos(String bairro, String rua) {
    controllBairro.text = bairro;
    controllRua.text = rua;
  }

  @action
  // FUNÇÃO RESPONSÁVEL POR ATRIBUIR LISTA DE VALORES DO DROPDOWN
  setDropList(value) {
    tipoImovelList.clear();
    tipoImovelList = value;
  }

  @action
  // FUNÇÃO RESPONSÁVEL POR ATRIBUIR LISTA DE VALORES DO DROPDOWN
  setDropListQuart(value) {
    jsonQuart.clear();
    quartId = '';
    jsonQuart = value;
  }

  @action
  // FUNÇÃO RESPONSÁVEL POR SETAR VALOR ESCOLHIDO NO DROPDOWN
  setTipo(value) => tipo = value;

  @action
  // FUNÇÃO RESPONSÁVEL POR SETAR O JSON COM VALORES DO FORMULÁRIO
  setJsonExterno(value) => jsonExterno = value;

  @action
// FUNÇÃO RESPONSÁVEL POR SETAR CÓDIGO QR USADO EM FECHADO/RECUSA
  setQrCode(value) => qrCode = value;

  String removerAcentos(String str) {
    var comAcento =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }

    return str;
  }
}

class GetBairro {
  int? id;
  String? nome;
  int? totalQuarteirao;
  int? totalImoveis;

  GetBairro({this.id, this.nome, this.totalQuarteirao, this.totalImoveis});

  GetBairro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'].toString().toUpperCase();
    totalQuarteirao = json['total_quarteirao'];
    totalImoveis = json['total_imoveis'];
  }
}

class GetRua {
  int? id;
  String? nome;

  GetRua({
    this.id,
    this.nome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
    };
  }

  factory GetRua.fromMap(Map<String, dynamic> map) {
    return GetRua(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  GetRua.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'].toString().toUpperCase();
  }
}
