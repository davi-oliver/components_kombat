// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ViewModelStore on _ViewModelStoreBase, Store {
  late final _$imovelVisitaAtom =
      Atom(name: '_ViewModelStoreBase.imovelVisita', context: context);

  @override
  ImovelVisita get imovelVisita {
    _$imovelVisitaAtom.reportRead();
    return super.imovelVisita;
  }

  @override
  set imovelVisita(ImovelVisita value) {
    _$imovelVisitaAtom.reportWrite(value, super.imovelVisita, () {
      super.imovelVisita = value;
    });
  }

  late final _$logradoutroAuxAtom =
      Atom(name: '_ViewModelStoreBase.logradoutroAux', context: context);

  @override
  String? get logradoutroAux {
    _$logradoutroAuxAtom.reportRead();
    return super.logradoutroAux;
  }

  @override
  set logradoutroAux(String? value) {
    _$logradoutroAuxAtom.reportWrite(value, super.logradoutroAux, () {
      super.logradoutroAux = value;
    });
  }

  late final _$numeroAuxAtom =
      Atom(name: '_ViewModelStoreBase.numeroAux', context: context);

  @override
  String? get numeroAux {
    _$numeroAuxAtom.reportRead();
    return super.numeroAux;
  }

  @override
  set numeroAux(String? value) {
    _$numeroAuxAtom.reportWrite(value, super.numeroAux, () {
      super.numeroAux = value;
    });
  }

  late final _$complementoAuxAtom =
      Atom(name: '_ViewModelStoreBase.complementoAux', context: context);

  @override
  String? get complementoAux {
    _$complementoAuxAtom.reportRead();
    return super.complementoAux;
  }

  @override
  set complementoAux(String? value) {
    _$complementoAuxAtom.reportWrite(value, super.complementoAux, () {
      super.complementoAux = value;
    });
  }

  late final _$bairroAuxAtom =
      Atom(name: '_ViewModelStoreBase.bairroAux', context: context);

  @override
  String? get bairroAux {
    _$bairroAuxAtom.reportRead();
    return super.bairroAux;
  }

  @override
  set bairroAux(String? value) {
    _$bairroAuxAtom.reportWrite(value, super.bairroAux, () {
      super.bairroAux = value;
    });
  }

  late final _$situacaoVisitaAuxAtom =
      Atom(name: '_ViewModelStoreBase.situacaoVisitaAux', context: context);

  @override
  String? get situacaoVisitaAux {
    _$situacaoVisitaAuxAtom.reportRead();
    return super.situacaoVisitaAux;
  }

  @override
  set situacaoVisitaAux(String? value) {
    _$situacaoVisitaAuxAtom.reportWrite(value, super.situacaoVisitaAux, () {
      super.situacaoVisitaAux = value;
    });
  }

  late final _$qrcodeAuxAtom =
      Atom(name: '_ViewModelStoreBase.qrcodeAux', context: context);

  @override
  String? get qrcodeAux {
    _$qrcodeAuxAtom.reportRead();
    return super.qrcodeAux;
  }

  @override
  set qrcodeAux(String? value) {
    _$qrcodeAuxAtom.reportWrite(value, super.qrcodeAux, () {
      super.qrcodeAux = value;
    });
  }

  late final _$tipoimovelAuxAtom =
      Atom(name: '_ViewModelStoreBase.tipoimovelAux', context: context);

  @override
  String? get tipoimovelAux {
    _$tipoimovelAuxAtom.reportRead();
    return super.tipoimovelAux;
  }

  @override
  set tipoimovelAux(String? value) {
    _$tipoimovelAuxAtom.reportWrite(value, super.tipoimovelAux, () {
      super.tipoimovelAux = value;
    });
  }

  late final _$setListaImoveisVisitaAsyncAction = AsyncAction(
      '_ViewModelStoreBase.setListaImoveisVisita',
      context: context);

  @override
  Future<dynamic> setListaImoveisVisita(dynamic lista) {
    return _$setListaImoveisVisitaAsyncAction
        .run(() => super.setListaImoveisVisita(lista));
  }

  late final _$_ViewModelStoreBaseActionController =
      ActionController(name: '_ViewModelStoreBase', context: context);

  @override
  void setAuxDetalhes(
      {dynamic logradouro,
      String? numero,
      dynamic complemento,
      dynamic situacaovisita,
      dynamic tipoimovel,
      dynamic bairro,
      dynamic qrcode}) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setAuxDetalhes');
    try {
      return super.setAuxDetalhes(
          logradouro: logradouro,
          numero: numero,
          complemento: complemento,
          situacaovisita: situacaovisita,
          tipoimovel: tipoimovel,
          bairro: bairro,
          qrcode: qrcode);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListImoveisProducaoLocal(dynamic json) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setListImoveisProducaoLocal');
    try {
      return super.setListImoveisProducaoLocal(json);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListaQuestionarioSemInternet(dynamic lista) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setListaQuestionarioSemInternet');
    try {
      return super.setListaQuestionarioSemInternet(lista);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImovelVisitaFromJson(Map<String, dynamic> json,
      [int switchVisita = 0]) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setImovelVisitaFromJson');
    try {
      return super.setImovelVisitaFromJson(json, switchVisita);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClearImovelVisita() {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setClearImovelVisita');
    try {
      return super.setClearImovelVisita();
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInsertId(dynamic value) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setInsertId');
    try {
      return super.setInsertId(value);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImovelQrCode(Map<String, dynamic> json) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setImovelQrCode');
    try {
      return super.setImovelQrCode(json);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImovelVisita(dynamic value) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setImovelVisita');
    try {
      return super.setImovelVisita(value);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVisitaIdCiclo(int id, int ciclo) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setVisitaIdCiclo');
    try {
      return super.setVisitaIdCiclo(id, ciclo);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddListaLogradouroSearch(dynamic value) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setAddListaLogradouroSearch');
    try {
      return super.setAddListaLogradouroSearch(value);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setaddAllListaLogradouro(dynamic value) {
    final _$actionInfo = _$_ViewModelStoreBaseActionController.startAction(
        name: '_ViewModelStoreBase.setaddAllListaLogradouro');
    try {
      return super.setaddAllListaLogradouro(value);
    } finally {
      _$_ViewModelStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imovelVisita: ${imovelVisita},
logradoutroAux: ${logradoutroAux},
numeroAux: ${numeroAux},
complementoAux: ${complementoAux},
bairroAux: ${bairroAux},
situacaoVisitaAux: ${situacaoVisitaAux},
qrcodeAux: ${qrcodeAux},
tipoimovelAux: ${tipoimovelAux}
    ''';
  }
}
