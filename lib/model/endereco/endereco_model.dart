class Endereco {
  int? id;
  String? logradouro;
  int? numero;
  String? complemento;
  String? bairro;
  String? cep;
  int? cidadeId;
  int? estadoId;

  Endereco(
      {this.id,
      this.logradouro,
      this.numero,
      this.complemento,
      this.bairro,
      this.cep,
      this.cidadeId,
      this.estadoId});

  Endereco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cep = json['cep'];
    cidadeId = json['cidade_id'];
    estadoId = json['estado_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cep'] = this.cep;
    data['cidade_id'] = this.cidadeId;
    data['estado_id'] = this.estadoId;
    return data;
  }
}

class Bairro {
  int? id;
  String? nome;
  int? quarteirao_numero;
  int? totalQuarteirao;
  int? totalImoveis;

  Bairro({
    this.id,
    this.nome,
    this.quarteirao_numero,
    this.totalQuarteirao,
    this.totalImoveis,
  });

  Bairro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    totalQuarteirao = json['total_quarteirao'];
    quarteirao_numero = json['quarteirao_numero'];
    totalImoveis = json['total_imoveis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['total_quarteirao'] = this.totalQuarteirao;
    data['total_imoveis'] = this.totalImoveis;
    return data;
  }
}

class Quarteirao {
  int? id;
  int? bairroId;
  int? quarteiraoNumero;
  int? totalImoveis;

  Quarteirao(
      {this.id, this.bairroId, this.quarteiraoNumero, this.totalImoveis});

  Quarteirao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bairroId = json['bairro_id'];
    quarteiraoNumero = json['quarteirao_numero'];
    totalImoveis = json['total_imoveis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['bairro_id'] = this.bairroId;
    data['quarteirao_numero'] = this.quarteiraoNumero;
    data['total_imoveis'] = this.totalImoveis;
    return data;
  }
}
