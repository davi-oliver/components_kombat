import 'package:componets_kombat/model/endereco/endereco_model.dart';
import 'package:componets_kombat/model/qrcode/qrcode_model.dart';
import 'package:componets_kombat/model/visita/vista_model.dart';

import 'imovel_model.dart';

abstract class IModelImovel {
  int? id;
  int? enderecoId;
  int? qrcodeId;
  int? tipoImovelId;
  int? bairroId;
  int? quarteiraoId;
  int? lado;
  Endereco? endereco;
  Bairro? bairro;
  Quarteirao? quarteirao;
  TipoImovel? tipoImovel;
  Qrcode? qrcode;
  Visita? visita;

  IModelImovel({
    this.id,
    this.enderecoId,
    this.qrcodeId,
    this.tipoImovelId,
    this.bairroId,
    this.quarteiraoId,
    this.lado,
    this.endereco,
    this.bairro,
    this.quarteirao,
    this.tipoImovel,
    this.qrcode,
    this.visita,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['endereco_id'] = this.enderecoId;
    data['qrcode_id'] = this.qrcodeId;
    data['tipo_imovel_id'] = this.tipoImovelId;
    data['bairro_id'] = this.bairroId;
    data['quarteirao_id'] = this.quarteiraoId;
    data['lado'] = this.lado;
    if (this.endereco != null) {
      data['endereco'] = this.endereco!.toJson();
    }
    if (this.bairro != null) {
      data['bairro'] = this.bairro!.toJson();
    }
    if (this.quarteirao != null) {
      data['quarteirao'] = this.quarteirao!.toJson();
    }
    if (this.tipoImovel != null) {
      data['tipo_imovel'] = this.tipoImovel!.toJson();
    }
    if (this.qrcode != null) {
      data['qrcode'] = this.qrcode!.toJson();
    }
    return data;
  }
}
