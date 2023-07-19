import 'package:componets_kombat/detalhes_imovel/valida_qrcode/store/valida_qrcode_store.dart';
import 'package:componets_kombat/detalhes_imovel/func/valida_qrcode_functions.dart';
import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/login/widget/components.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

class ValidaQrCodeWidgets {
  BuildContext context;
  ValidaQrCodeWidgets(this.context);
  Widget widgetPrincipal() {
    return Column(children: [
      Expanded(
          child: ListView(children: [
        GlobalsWidgets(context).appBar(
          "Vincular Qr Code",
          true,
          false,
        ),
        _qrImagem(), // WIDGET COM IMAGEM DO QR CODE
        _botao(), // BOTÃO DE VALIDAÇÃO DO QR CODE
        const SizedBox(height: 120),
      ])),
    ]);
  }

  Widget _qrImagem() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            "Clique em \"Leitor QR Code\" para informar o código que será vinculado ao imóvel",
            style: KThemeModeApp.of(context).bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Image.asset(
          "assets/images/qr_code.png",
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }

  Widget _botao() {
    final validaQrCodeStore =
        Provider.of<ValidaQrCodeStore>(context, listen: false);

    return Column(
      children: [
        Observer(builder: (_) {
          return KitButton(
            onTap: () async {
              validaQrCodeStore.setLoading(true);
              var valor = await GlobalsFunctions(context).scanQR();
              if (valor != "-1") {
                bool conexao =
                    // ignore: use_build_context_synchronously
                    await GlobalsFunctions(context).verificaInternet();
                if (conexao) {
                  // ignore: use_build_context_synchronously
                  await ValidaQrcodefunctions(context)
                      .atualizaUltimoImovel(valor);
                } else {
                  // ignore: use_build_context_synchronously
                  await GlobalsFunctions(context).validaQrCode(valor);
                }
              }
            },
            mainAxisAlignment: MainAxisAlignment.center,
            widgetCenter: Text(
              "Leitor QR Code",
              style: KThemeModeApp.of(context)
                  .bodyLarge
                  .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
            ),
            iconPrefix: Icon(
              FontAwesomeIcons.qrcode,
              color: KThemeModeApp.of(context).primaryBtnText,
            ),
            iconPrefixPadding: const EdgeInsets.only(right: 20),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            decorationButton: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    KThemeModeApp.of(context).primary,
                    KThemeModeApp.of(context).accent1,
                  ],
                )),
          );
        }),
      ],
    );
  }
}
