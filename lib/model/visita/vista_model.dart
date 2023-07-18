class Visita {
  int? id;
  int? cicloBairroId;
  int? imovelId;
  int? agenteId;
  int? situacaoVisitaId;
  String? dateTime;
  Agente? agente;
  SituacaoVisita? situacaoVisita;

  Visita(
      {this.id,
      this.cicloBairroId,
      this.imovelId,
      this.agenteId,
      this.situacaoVisitaId,
      this.dateTime,
      this.agente,
      this.situacaoVisita});

  Visita.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cicloBairroId = json['ciclo_bairro_id'];
    imovelId = json['imovel_id'];
    agenteId = json['agente_id'];
    situacaoVisitaId = json['situacao_visita_id'];
    dateTime = json['date_time'];
    agente =
        json['agente'] != null ? new Agente.fromJson(json['agente']) : null;
    situacaoVisita = json['situacao_visita'] != null
        ? new SituacaoVisita.fromJson(json['situacao_visita'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ciclo_bairro_id'] = this.cicloBairroId;
    data['imovel_id'] = this.imovelId;
    data['agente_id'] = this.agenteId;
    data['situacao_visita_id'] = this.situacaoVisitaId;
    data['date_time'] = this.dateTime;
    if (this.agente != null) {
      data['agente'] = this.agente!.toJson();
    }
    if (this.situacaoVisita != null) {
      data['situacao_visita'] = this.situacaoVisita!.toJson();
    }
    return data;
  }
}

class Agente {
  int? id;
  String? matricula;
  String? nome;
  String? cpf;
  String? email;
  String? telefone;

  Agente(
      {this.id,
      this.matricula,
      this.nome,
      this.cpf,
      this.email,
      this.telefone});

  Agente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matricula = json['matricula'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['matricula'] = this.matricula;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    return data;
  }
}

class SituacaoVisita {
  int? id;
  String? situacao;

  SituacaoVisita({this.id, this.situacao});

  SituacaoVisita.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    situacao = json['situacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['situacao'] = this.situacao;
    return data;
  }
}
