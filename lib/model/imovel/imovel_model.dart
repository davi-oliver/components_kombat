import 'package:componets_kombat/model/endereco/endereco_model.dart';
import 'package:componets_kombat/model/imovel/interface_imovel.dart';
import 'package:componets_kombat/model/qrcode/qrcode_model.dart';
import 'package:componets_kombat/model/visita/vista_model.dart';

class ImovelVisita implements IModelImovel {
  int? insertId;
  @override
  Bairro? bairro;

  @override
  int? bairroId;

  @override
  Endereco? endereco;

  @override
  int? enderecoId;

  @override
  int? id;

  @override
  int? lado;

  @override
  Qrcode? qrcode;

  @override
  int? qrcodeId;

  @override
  Quarteirao? quarteirao;

  @override
  int? quarteiraoId;

  @override
  TipoImovel? tipoImovel;

  @override
  int? tipoImovelId;

  @override
  Map<String, dynamic> toJson() {
    // novo modelo de json para imoveis
    //TODO:
    // fazer funcção que escolhe os tipos de param que VAI PRO TO JSON

    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['endereco_id'] = enderecoId;
    data['qrcode_id'] = qrcodeId;
    data['tipo_imovel_id'] = tipoImovelId;
    data['bairro_id'] = bairroId;
    data['quarteirao_id'] = quarteiraoId;
    data['lado'] = lado;
    if (endereco != null) {
      data['endereco'] = endereco!.toJson();
    }
    if (bairro != null) {
      data['bairro'] = bairro!.toJson();
    }
    if (quarteirao != null) {
      data['quarteirao'] = quarteirao!.toJson();
    }
    if (tipoImovel != null) {
      data['tipo_imovel'] = tipoImovel!.toJson();
    }
    if (qrcode != null) {
      data['qrcode'] = qrcode!.toJson();
    }
    return data;
  }

  @override
  Visita? visita;
  ImovelVisita({
    this.insertId,
    this.bairro,
    this.bairroId,
    this.endereco,
    this.enderecoId,
    this.id,
    this.lado,
    this.qrcode,
    this.qrcodeId,
    this.quarteirao,
    this.quarteiraoId,
    this.tipoImovel,
    this.tipoImovelId,
    this.visita,
  });
}

class TipoImovel {
  int? id;
  String? tipo;

  TipoImovel({this.id, this.tipo});

  TipoImovel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    return data;
  }
}
