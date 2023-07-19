import 'dart:convert';

import 'package:flutter/material.dart';

class Questao {
  int? id;
  String? questao;
  TextEditingController? resposta;
  int? idVisitaImovel;

  Questao({
    this.id,
    this.questao,
    this.resposta,
    this.idVisitaImovel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'questao': questao,
      'resposta': resposta,
      'idVisitaImovel': idVisitaImovel,
    };
  }

  factory Questao.fromMap(Map<String, dynamic> map) {
    return Questao(
      id: map['id'] != null ? map['id'] as int : null,
      questao: map['questao'] != null ? map['questao'] as String : null,
      resposta: map['resposta'] != null
          ? map['resposta'] as TextEditingController
          : null,
      idVisitaImovel:
          map['idVisitaImovel'] != null ? map['idVisitaImovel'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Questao.fromJson(source) =>
      Questao.fromMap(source as Map<String, dynamic>);
}

class Questionario {
  int? id;

  String? resposta;
  int? idVisitaImovel;
  Questionario({
    this.id,
    this.resposta,
    this.idVisitaImovel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'resposta': resposta,
      'id_visita_imovel': idVisitaImovel,
    };
  }

  factory Questionario.fromMap(Map<String, dynamic> map) {
    return Questionario(
      id: map['id'] != null ? map['id'] as int : null,
      resposta: map['resposta'] != null ? map['resposta'] as String : null,
      idVisitaImovel: map['id_visita_imovel'] != null
          ? map['id_visita_imovel'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Questionario.fromJson(source) =>
      Questionario.fromMap(source as Map<String, dynamic>);
}
