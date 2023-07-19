import 'package:componets_kombat/formulario_questoes_visita/store/forumario_questoes_visita_store.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioQuestoesVisitaFunctions {
  BuildContext context;
  FormularioQuestoesVisitaFunctions(this.context);

  Future setDropLarvicida() async {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    final infoImovelStore =
        Provider.of<FormularioQuestoesVisitaStore>(context, listen: false);
    print("jsonLarvicida ${infoImovelStore.jsonLarvicida} ");

    int qtde = infoImovelStore.jsonLarvicida.length;
    int i;
    if (infoImovelStore.jsonLarvicida != null) {
      items.add(
        DropdownMenuItem(
          value: '',
          child: Text('TIPO DE LARVICIDA',
              style: KThemeModeApp.of(context).bodyLarge),
        ),
      );
      for (i = 0; i < qtde; i++) {
        items.add(
          DropdownMenuItem(
            value: infoImovelStore.jsonLarvicida[i]['id'].toString(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(infoImovelStore.jsonLarvicida[i]['nome'],
                    style: KThemeModeApp.of(context).bodySmall),
              ],
            ),
          ),
        );
      }

      infoImovelStore.setTipoLarvicida(items);
    }
  }
}
