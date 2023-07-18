import 'package:componets_kombat/model/agente/agente_model.dart';
import 'package:componets_kombat/model/endereco/endereco_model.dart';

class CicloBairroAgente {
  int? id;
  int? cicloBairroId;
  int? agenteId;
  String? dataAtribuicao;
  CicloBairro? cicloBairro;
  Agente? agente;

  CicloBairroAgente(
      {this.id,
      this.cicloBairroId,
      this.agenteId,
      this.dataAtribuicao,
      this.cicloBairro,
      this.agente});

  CicloBairroAgente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cicloBairroId = json['ciclo_bairro_id'];
    agenteId = json['agente_id'];
    dataAtribuicao = json['data_atribuicao'];
    cicloBairro = json['ciclo_bairro'] != null
        ? new CicloBairro.fromJson(json['ciclo_bairro'])
        : null;
    agente =
        json['agente'] != null ? new Agente.fromJson(json['agente']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ciclo_bairro_id'] = this.cicloBairroId;
    data['agente_id'] = this.agenteId;
    data['data_atribuicao'] = this.dataAtribuicao;
    if (this.cicloBairro != null) {
      data['ciclo_bairro'] = this.cicloBairro!.toJson();
    }
    if (this.agente != null) {
      data['agente'] = this.agente!.toJson();
    }
    return data;
  }
}

class CicloBairro {
  int? id;
  int? bairroId;
  int? cicloId;
  String? totalImoveisVisitados;
  String? totalImoveisFechados;
  int? statusVigilanciaId;
  int? supervisorId;
  String? ultimaAtualizacao;
  Ciclo? ciclo;
  Bairro? bairro;

  CicloBairro(
      {this.id,
      this.bairroId,
      this.cicloId,
      this.totalImoveisVisitados,
      this.totalImoveisFechados,
      this.statusVigilanciaId,
      this.supervisorId,
      this.ultimaAtualizacao,
      this.ciclo,
      this.bairro});

  CicloBairro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bairroId = json['bairro_id'];
    cicloId = json['ciclo_id'];
    totalImoveisVisitados = json['total_imoveis_visitados'];
    totalImoveisFechados = json['total_imoveis_fechados'];
    statusVigilanciaId = json['status_vigilancia_id'];
    supervisorId = json['supervisor_id'];
    ultimaAtualizacao = json['ultima_atualizacao'];
    ciclo = json['ciclo'] != null ? new Ciclo.fromJson(json['ciclo']) : null;
    bairro =
        json['bairro'] != null ? new Bairro.fromJson(json['bairro']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bairro_id'] = this.bairroId;
    data['ciclo_id'] = this.cicloId;
    data['total_imoveis_visitados'] = this.totalImoveisVisitados;
    data['total_imoveis_fechados'] = this.totalImoveisFechados;
    data['status_vigilancia_id'] = this.statusVigilanciaId;
    data['supervisor_id'] = this.supervisorId;
    data['ultima_atualizacao'] = this.ultimaAtualizacao;
    if (this.ciclo != null) {
      data['ciclo'] = this.ciclo!.toJson();
    }
    if (this.bairro != null) {
      data['bairro'] = this.bairro!.toJson();
    }
    return data;
  }
}

class Ciclo {
  int? id;
  int? numero;
  String? inicio;
  String? fim;
  int? gestorId;
  int? calendarioId;
  String? createdAt;
  String? updatedAt;

  Ciclo(
      {this.id,
      this.numero,
      this.inicio,
      this.fim,
      this.gestorId,
      this.calendarioId,
      this.createdAt,
      this.updatedAt});

  Ciclo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numero = json['numero'];
    inicio = json['inicio'];
    fim = json['fim'];
    gestorId = json['gestor_id'];
    calendarioId = json['calendario_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['numero'] = this.numero;
    data['inicio'] = this.inicio;
    data['fim'] = this.fim;
    data['gestor_id'] = this.gestorId;
    data['calendario_id'] = this.calendarioId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
