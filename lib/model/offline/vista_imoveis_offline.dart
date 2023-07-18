// ignore_for_file: public_member_api_docs, sort_constructors_first

class VisitaOffline {
  int? bairroId;
  String? agenteId;
  String? bairro;
  String? logradouro;
  String? complemento;
  int? numero;
  int? lado;
  int? quarteiraoId;
  int? tipoImovelId;
  // dados de qrcode

  String? qrcode;
  int? qrcodeId;
  String? valor;
  // dados de visita

  VisitaImovelOffline? visitaImovelOffline;
  VisitaOffline({
    this.bairroId,
    this.agenteId,
    this.bairro,
    this.logradouro,
    this.complemento,
    this.numero,
    this.lado,
    this.quarteiraoId,
    this.tipoImovelId,
    this.qrcode,
    this.qrcodeId,
    this.valor,
  });

  factory VisitaOffline.fromJson(Map<String, dynamic> map) {
    List<QuestaoOffline> questoesList = [];
    if (map['questoes'] != null) {
      map['questoes'].forEach((v) {
        questoesList.add(QuestaoOffline.fromJson(v));
      });
    }
    return VisitaOffline(
      bairroId: map['bairro_id'] != null ? map['bairro_id'] as int : null,
      agenteId: map['agente_id'] != null ? map['agente_id'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      logradouro:
          map['logradouro'] != null ? map['logradouro'] as String : null,
      complemento:
          map['complemento'] != null ? map['complemento'] as String : null,
      numero: map['numero'] != null ? map['numero'] as int : null,
      lado: map['lado'] != null ? map['lado'] as int : null,
      quarteiraoId:
          map['quarteirao_id'] != null ? map['quarteirao_id'] as int : null,
      tipoImovelId:
          map['tipo_imovel_id'] != null ? map['tipo_imovel_id'] as int : null,
      qrcode: map['qrcode'] != null ? map['qrcode'] as String : null,
      qrcodeId: map['qrcodeId'] != null ? map['qrcodeId'] as int : null,
      valor: map['valor'] != null ? map['valor'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bairro_id'] = this.bairroId;
    data['agente_id'] = this.agenteId;

    return data;
  }
}

class VisitaImovelOffline {
  int? imovelId;
  int? situacaoVisitaId;
  int? larvicidaId;
  String? dataVisita;
  String? dateTime;
  int? idVisitaImovel;
  List<QuestaoOffline>? questoes;
  VisitaImovelOffline({
    this.imovelId,
    this.situacaoVisitaId,
    this.larvicidaId,
    this.dataVisita,
    this.dateTime,
    this.idVisitaImovel,
    this.questoes,
  });

  factory VisitaImovelOffline.fromJson(Map<String, dynamic> map) {
    List<QuestaoOffline> questoesList = [];
    if (map['questoes'] != null) {
      map['questoes'].forEach((v) {
        questoesList.add(QuestaoOffline.fromJson(v));
      });
    }
    return VisitaImovelOffline(
      imovelId: map['imovel_id'] != null ? map['imovel_id'] as int : null,
      situacaoVisitaId: map['situacao_visita_id'] != null
          ? map['situacao_visita_id'] as int
          : null,
      larvicidaId:
          map['larvicida_id'] != null ? map['larvicida_id'] as int : null,
      dataVisita:
          map['data_visita'] != null ? map['data_visita'] as String : null,
      dateTime: map['date_time'] != null ? map['date_time'] as String : null,
      idVisitaImovel: map['id_visita_imovel'] != null
          ? map['id_visita_imovel'] as int
          : null,
      questoes: questoesList,
    );
  }
}

class QuestaoOffline {
  int id;
  int idVisitaImovel;
  String resposta;

  QuestaoOffline({
    required this.id,
    required this.idVisitaImovel,
    required this.resposta,
  });

  factory QuestaoOffline.fromJson(Map<String, dynamic> json) {
    return QuestaoOffline(
      id: json['id'],
      idVisitaImovel: json['id_visita_imovel'],
      resposta: json['resposta'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['id_visita_imovel'] = this.idVisitaImovel;
    data['resposta'] = this.resposta;
    return data;
  }
}

class Root {
  String logradouro;
  int numero;
  String complemento;
  String bairro;
  int tipoImovelId;
  int bairroId;
  int quarteiraoNumero;
  int lado;
  String qrcode;
  int qrcodeId;
  String valor;
  VisitaOffline visitas;

  Root({
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.tipoImovelId,
    required this.bairroId,
    required this.quarteiraoNumero,
    required this.lado,
    required this.qrcode,
    required this.qrcodeId,
    required this.valor,
    required this.visitas,
  });

  factory Root.fromJson(Map<String, dynamic> json) {
    return Root(
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      tipoImovelId: json['tipo_imovel_id'],
      bairroId: json['bairro_id'],
      quarteiraoNumero: json['quarteirao_numero'],
      lado: json['lado'],
      qrcode: json['qrcode'],
      qrcodeId: json['qrcode_id'],
      valor: json['valor'],
      visitas: VisitaOffline.fromJson(json['visitas']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['tipo_imovel_id'] = this.tipoImovelId;
    data['bairro_id'] = this.bairroId;
    data['quarteirao_numero'] = this.quarteiraoNumero;
    data['lado'] = this.lado;
    data['qrcode'] = this.qrcode;
    data['qrcode_id'] = this.qrcodeId;
    data['valor'] = this.valor;
    data['visitas'] = this.visitas.toJson();
    return data;
  }
}
