import 'package:componets_kombat/detalhes_imovel/detalhes_imovel_page.dart';
import 'package:componets_kombat/formulario_imovel/func/formulario_imovel_functions.dart';
import 'package:componets_kombat/formulario_imovel/store/formulario_imovel_store.dart';
import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/home/home_page.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:componets_kombat/local_visitas/store/local_visitas_store.dart';
import 'package:componets_kombat/login/widget/components.dart';
import 'package:componets_kombat/requests/services/serices_get.dart';
import 'package:componets_kombat/requests/services/services_post.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:componets_kombat/view_model/view_model_store.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InfoSalvaWidget {
  BuildContext context;
  InfoSalvaWidget(this.context);

  gradientButton(icone, String texto, Color corInicio, Color corFim,
      double largura, bool removeRota) {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    return Column(
      children: [
        KitButton(
          widgetCenter: Text(
            texto,
            style: KThemeModeApp.of(context)
                .bodyLarge
                .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
          ),
          iconPrefix: Icon(
            icone,
            color: KThemeModeApp.of(context).primaryBackground,
          ),
          iconSufix: Icon(icone, color: Colors.transparent),
          onTap: () async {
            formularioImovelStore.setLoad(true);

            if (await GlobalsFunctions(context).verificaInternet()) {
              // ignore: use_build_context_synchronously
              if (await FormularioImovelFunctions(context).salvaImovelLocal()) {
                formularioImovelStore.setLoad(false);

                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DetalhesImovelPage()));
                return;
              }
            }
            if (formularioImovelStore.tipo == '3' ||
                formularioImovelStore.tipo == '10' ||
                formularioImovelStore.tipo == '8') {
              // ignore: use_build_context_synchronously
              await ServiceGetRequestApp(context).getImoveisByEndereco();
            } else {
              formularioImovelStore.setLoad(false);
              // ignore: use_build_context_synchronously
              return await GlobalsAlerts(context).alertErro("Atenção",
                  "Este imóvel precisa vincular QR Code! Por favor clique em 'Vincular QR Code' e escaneie o QR Code do imóvel!");
            }
            formularioImovelStore.setLoad(false);
          },
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          iconPrefixPadding: const EdgeInsets.only(left: 15),
          height: 50,
          width: MediaQuery.of(context).size.width * largura,
          decorationButton: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                corInicio,
                corFim,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(3, 3),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: KThemeModeApp.of(context).primary,
          ),
        ),
      ],
    );
  }

  whitebutton(
      icone, String texto, Color corInicio, Color corFim, double largura) {
    // ignore: unused_local_variable
    final iniciaVisitaStoreT =
        Provider.of<IniciaVisitaStore>(context, listen: true);

    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);

    return Column(
      children: [
        KitButton(
          widgetCenter: Text(
            texto,
            style: KThemeModeApp.of(context)
                .bodyLarge
                .copyWith(color: KThemeModeApp.of(context).primaryText),
          ),
          iconPrefix: Icon(
            icone,
            color: KThemeModeApp.of(context).primaryText,
          ),
          iconSufix: Icon(icone, color: Colors.transparent),
          onTap: () async {
            viewModelStore.imovelVisita.qrcode = null;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => HomeVigPage(
                          rebirth: () {},
                        )));
          },
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          iconPrefixPadding: EdgeInsets.only(left: 15),
          height: 50,
          width: MediaQuery.of(context).size.width * largura,
          decorationButton: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                corInicio,
                corFim,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(3, 3),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: KThemeModeApp.of(context).primary,
          ),
        ),
      ],
    );
  }

  gradientButtonQrCode(icone, String texto, Color corInicio, Color corFim,
      double largura, bool removeRota) {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    // ignore: unused_local_variable
    final iniciaVisitaStoreT =
        Provider.of<IniciaVisitaStore>(context, listen: true);

    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    return Column(
      children: [
        KitButton(
          widgetCenter: Text(
            texto,
            style: KThemeModeApp.of(context)
                .bodyLarge
                .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
          ),
          iconPrefix: Icon(
            icone,
            color: KThemeModeApp.of(context).primaryBackground,
          ),
          iconSufix: Icon(icone, color: Colors.transparent),
          onTap: () async {
            formularioImovelStore.setLoad(true);

            // TEM QUE FAZER A LEITURA DO QR CODE
            iniciaVisitaStore
                .setValorQr(await GlobalsFunctions(context).scanQR());
            // VERIFICAR SE VALOR RETORNADO É -1
            if (iniciaVisitaStore.valorQr == "-1") {
              formularioImovelStore.setLoad(false);
              // ignore: use_build_context_synchronously
              return await GlobalsAlerts(context).alertErro("Atenção",
                  "Não foi possível ler o Qr Code! Por favor tente novamente!");
            }
            // ignore: use_build_context_synchronously
            if (await GlobalsFunctions(context).verificaInternet()) {
              // ignore: use_build_context_synchronously
              if (await FormularioImovelFunctions(context)
                  .salvaImovelLocalComQrcode(iniciaVisitaStore.valorQr)) {
                formularioImovelStore.setLoad(false);

                // return await GlobalsAlerts(context).alertSucessQrCodeOffline(
                // "Sucesso", "Qr Code Vinculado Com Sucesso!");
              }
            }

            // ignore: use_build_context_synchronously
            await ServicesRequestPostApp(context).vinculaQrcodeImovel();
          },
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          iconPrefixPadding: const EdgeInsets.only(left: 15),
          height: 50,
          width: MediaQuery.of(context).size.width * largura,
          decorationButton: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                corInicio,
                corFim,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(3, 3),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: KThemeModeApp.of(context).primary,
          ),
        ),
      ],
    );
  }

  Widget _botaoRecusa() {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final localVisitasStore =
        Provider.of<LocalVisitasStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    return KitButton(
      widgetCenter: Text(
        "Recusa",
        style: KThemeModeApp.of(context)
            .bodyLarge
            .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
      ),
      iconPrefix: Icon(
        Icons.block_flipped,
        color: KThemeModeApp.of(context).primaryBackground,
      ),
      iconSufix: const Icon(FontAwesomeIcons.qrcode, color: Colors.transparent),
      onTap: () async {
        // iniciaVisitaStore.setLoad(true);
        formularioImovelStore.setLoad(false);

        if (await GlobalsFunctions(context).verificaInternet())
        // ignore: curly_braces_in_flow_control_structures
        {
          // ignore: use_build_context_synchronously
          await FormularioImovelFunctions(context).salvaLocalimovelRecusa();
        } else {
          localVisitasStore.setAddListaVisitasAgenteLocal(
              viewModelStore.imovelVisita.toJson().toString());

          if (iniciaVisitaStore.visibilidadeBotaoRecusado) {
            iniciaVisitaStore.setVisibilidadeBotaoRecusado(false);
            // ignore: use_build_context_synchronously
            await ServicesRequestPostApp(context).imovelRecusado();
            // iniciaVisitaStore.setLoad(false);
            formularioImovelStore.setLoad(false);
          }
        }
        formularioImovelStore.setLoad(false);

        iniciaVisitaStore.setLoad(false);
      },
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      iconPrefixPadding: const EdgeInsets.only(left: 15),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.7,
      decorationButton: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            KThemeModeApp.of(context).tertiary,
            KThemeModeApp.of(context).accent3
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(3, 3),
            blurRadius: 6,
            spreadRadius: 1,
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  Widget _botaoFechado() {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    final iniciaVisitaStoreT =
        Provider.of<IniciaVisitaStore>(context, listen: true);
    final localVisitasStore =
        Provider.of<LocalVisitasStore>(context, listen: false);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);

    return KitButton(
      widgetCenter: Text(
        "Fechado",
        style: KThemeModeApp.of(context)
            .bodyLarge
            .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
      ),
      iconPrefix: Icon(
        Icons.door_back_door_rounded,
        color: KThemeModeApp.of(context).primaryBackground,
      ),
      iconSufix: const Icon(FontAwesomeIcons.qrcode, color: Colors.transparent),
      onTap: () async {
        formularioImovelStore.setLoad(true);

        if (await GlobalsFunctions(context).verificaInternet()) {
          // ignore: use_build_context_synchronously
          await FormularioImovelFunctions(context).salvaLocalimovelFechado();
        } else {
          localVisitasStore.setAddListaVisitasAgenteLocal(
              viewModelStore.imovelVisita.toJson().toString());
          if (iniciaVisitaStoreT.visibilidadeBotaoFechado) {
            iniciaVisitaStore.setVisibilidadeBotaoFechado(false);
            // ignore: use_build_context_synchronously
            await ServicesRequestPostApp(context).imovelFechado();
            formularioImovelStore.setLoad(false);
          }
        }

        iniciaVisitaStore.setLoad(false);
        formularioImovelStore.setLoad(false);
      },
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      iconPrefixPadding: const EdgeInsets.only(left: 15),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.7,
      decorationButton: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            KThemeModeApp.of(context).tertiary,
            KThemeModeApp.of(context).accent3
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(3, 3),
            blurRadius: 6,
            spreadRadius: 1,
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: KThemeModeApp.of(context).primary,
      ),
    );
  }

  Widget widgetPrincipal() {
    final formularioImovelStoreT =
        Provider.of<FormularioImovelStore>(context, listen: true);
    return Observer(builder: (_) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ListView(children: [
              GlobalsWidgets(context).appBar("Cadastrar Imóvel", false),
              _body(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    _botaoFechado(),
                    const SizedBox(height: 30),
                    _botaoRecusa(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Visibility(
                visible: formularioImovelStoreT.tipoImovelId == 3 ||
                        formularioImovelStoreT.tipoImovelId == 8 ||
                        formularioImovelStoreT.tipoImovelId == 10
                    ? false
                    : true,
                child: gradientButton(
                    FontAwesomeIcons.play,
                    "Iniciar Visita",
                    KThemeModeApp.of(context).secondary,
                    KThemeModeApp.of(context).secondary,
                    0.8,
                    true),
              ),
              const SizedBox(height: 30),

              Visibility(
                visible: formularioImovelStoreT.tipoImovelId == 3 ||
                        formularioImovelStoreT.tipoImovelId == 8 ||
                        formularioImovelStoreT.tipoImovelId == 10
                    ? false
                    : true,
                child: gradientButtonQrCode(
                    FontAwesomeIcons.qrcode,
                    "Vincular QrCode",
                    KThemeModeApp.of(context).primary,
                    KThemeModeApp.of(context).accent1,
                    0.8,
                    true),
              ),

              // SizedBox(height: 30),
              // _botao(),
              const SizedBox(height: 30),
              whitebutton(
                  FontAwesomeIcons.arrowLeft,
                  "Voltar para Home",
                  KThemeModeApp.of(context).accent4,
                  KThemeModeApp.of(context).primaryBtnText,
                  0.8),
              const SizedBox(
                height: 120,
              )
            ]))
          ]);
    });
  }

  Widget _body() {
    return Column(
      children: [
        Text(
          "CADASTRO REALIZADO",
          style: KThemeModeApp.of(context).headlineSmall,
        ),
        const SizedBox(height: 100),
        const Icon(
          FontAwesomeIcons.check,
          size: 100,
          color: Colors.green,
        ),
        const SizedBox(height: 140),
      ],
    );
  }
}
