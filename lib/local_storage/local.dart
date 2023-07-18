import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalPathStore {
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // ARMAZENAR OS DADOS LOCALMENTE DO AGENTE
  Future<File> get agente async {
    final path = await _localPath;
    return File('$path/agente.text');
  }

  // ARMAZENAR OS DADOS LOCALMENTE DO DA RUA
  Future<File> get localEpRuas async {
    final path = await _localPath;
    return File('$path/localEpRuas.text');
  }
  // ARMAZENAR OS DADOS LOCALMENTE DO BAIRRO

  Future<File> get localEpBairro async {
    final path = await _localPath;
    return File('$path/localEpBairro.text');
  }
  // ARMAZENAR OS DADOS LOCALMENTE DOS QUESTIONARIOS DO EP

  Future<File> get getEpQuestionario async {
    final path = await _localPath;
    return File('$path/get_questionario.text');
  }
  // ARMAZENAR OS DADOS LOCALMENTE DO LOGIN

  Future<File> get login async {
    final path = await _localPath;
    return File('$path/login.text');
  }

  // ARMAZENAR OS DADOS LOCALMENTE DO IMÓVEL
  Future<File> get visitasImovelOffline async {
    final path = await _localPath;
    return File('$path/visitasImovelOffline.text');
  }

  // ARMAZENAR OS DADOS LOCALMENTE DO IMÓVEL
  Future<File> get tipoImovel async {
    final path = await _localPath;
    return File('$path/tipoImovel.text');
  }
  // ARMAZENAR OS DADOS LOCALMENTE DOS QUARTEIROES

  Future<File> get getQuarteiroes async {
    final path = await _localPath;
    return File('$path/getQuarteiroes.text');
  }
  // ARMAZENAR OS DADOS LOCALMENTE DAS LARVICIDAS

  Future<File> get getLarvicida async {
    final path = await _localPath;
    return File('$path/getLarvicida.text');
  }

  // ARMAZENAR OS DADOS LOCALMENTE DO BAIRRO EM QUE O AGENTE SELECIONOU
  Future<File> get getBairroAtual async {
    final path = await _localPath;
    return File('$path/getBairroAtual.text');
  }
  // RESPONSAVEL POR SALVAR O ARQUIVO DE LISTAR IMOVEIS POR BAIRRO

  Future<File> get listarImoveisBairro async {
    final path = await _localPath;
    return File('$path/listarImoveisBairro.text');
  }
}
