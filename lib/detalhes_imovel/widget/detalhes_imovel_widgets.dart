import 'package:componets_kombat/detalhes_imovel/detalhes_imovel_page.dart';
import 'package:componets_kombat/formulario_imovel/formulario_imovel_page.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:componets_kombat/local_visitas/store/local_visitas_store.dart';
import 'package:componets_kombat/login/widget/components.dart';
import 'package:componets_kombat/requests/services/services_post.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:componets_kombat/view_model/view_model_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

class DetalhesImovelWidgets {
  BuildContext context;
  DetalhesImovelWidgets(this.context);

  Widget widgetPrincipal(formState) {
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: true);
    final iniciaVisitaStoreT =
        Provider.of<IniciaVisitaStore>(context, listen: true);
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          GlobalsWidgets(context).appBar("Inicia Visita", true, false),
          imovelDetalhes(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.info, color: KThemeModeApp.of(context).primary),
              const SizedBox(width: 10),
              Text(
                "Qual a situação do imóvel?",
                style: KThemeModeApp.of(context).bodyLarge,
              ),
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
          _botaoFechado(),
          const SizedBox(
            height: 30,
          ),
          viewModelStore.imovelVisita.tipoImovel?.id == 3 ||
                  viewModelStore.imovelVisita.tipoImovel?.id == 8
              ? Container()
              : _botaoRecusa(),
          const SizedBox(
            height: 30,
          ),
          _botaoProximo(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SwitchListTile(
              title: Text("Não encontro o imóvel?",
                  style: KThemeModeApp.of(context).bodyLarge),
              subtitle: Text(
                "Caso não encontre o imóvel, clique aqui para cadastrar imóvel",
                style: KThemeModeApp.of(context).bodyLarge.copyWith(
                    color: KThemeModeApp.of(context).secondaryText,
                    fontSize: 14),
              ),
              value: iniciaVisitaStoreT.visibilidaddeBotaoCadastrarImovel,
              onChanged: (value) {
                iniciaVisitaStore.setVisibilidadeBotaoCadastrarImovel(value);
              },
              activeTrackColor: KThemeModeApp.of(context).primary,
              activeColor: KThemeModeApp.of(context).accent1,
            ),
          ),
          Visibility(
            visible: iniciaVisitaStoreT.visibilidaddeBotaoCadastrarImovel,
            child: _botaoCadastrarImovel(),
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }

  Widget widgetListaImoveisMesmoEndereco() {
    return Observer(builder: (_) {
      return Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          GlobalsWidgets(context).appBar("Inicia Visita", true, false),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.info,
                  color: KThemeModeApp.of(context).primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "Selecione o imóvel em que deseja iniciar a visita",
                    style: KThemeModeApp.of(context).bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          listViewImoveis(),
          const SizedBox(
            height: 150,
          )
        ],
      );
    });
  }

  Widget listViewImoveis() {
    final viewModelStoreT = Provider.of<ViewModelStore>(context, listen: true);
    final viewModelStoreF = Provider.of<ViewModelStore>(context, listen: true);

    return Observer(builder: (_) {
      return ListView.builder(
        itemCount: viewModelStoreT.listaImoveisVisita.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () async {
                  viewModelStoreF.imovelVisita =
                      viewModelStoreT.listaImoveisVisita[index];

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesImovelPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? KThemeModeApp.of(context).accent4
                          : KThemeModeApp.of(context).primaryBackground),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              FontAwesomeIcons.house,
                              size: 15,
                              color: KThemeModeApp.of(context).primary,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.house,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "LOGRADOURO",
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    viewModelStoreT.listaImoveisVisita[index]
                                            .endereco?.logradouro ??
                                        "Não Informado",
                                    style: KThemeModeApp.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          endIndent: 10,
                          indent: 10,
                          color: KThemeModeApp.of(context).accent1,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.listNumeric,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "NÚMERO",
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    viewModelStoreT.listaImoveisVisita[index]
                                            .endereco?.numero
                                            .toString() ??
                                        "Não Informado",
                                    style: KThemeModeApp.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          endIndent: 10,
                          indent: 10,
                          color: KThemeModeApp.of(context).accent1,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city_rounded,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "COMPLEMENTO ",
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    viewModelStoreT.listaImoveisVisita[index]
                                            .endereco?.complemento ??
                                        "Não Possui",
                                    style: KThemeModeApp.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          endIndent: 10,
                          indent: 10,
                          color: KThemeModeApp.of(context).accent1,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city_rounded,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "BAIRRO ",
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    viewModelStoreT.listaImoveisVisita[index]
                                            .endereco?.bairro ??
                                        "Não Possui",
                                    style: KThemeModeApp.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          endIndent: 10,
                          indent: 10,
                          color: KThemeModeApp.of(context).accent1,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.feed,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "SITUAÇÃO VISITA ",
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    viewModelStoreT.listaImoveisVisita[index]
                                            .visita?.situacaoVisita?.situacao ??
                                        "NÃO VISITADO",
                                    style: KThemeModeApp.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          endIndent: 10,
                          indent: 10,
                          color: KThemeModeApp.of(context).accent1,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.qr_code,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "QRCODE",
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    viewModelStoreT.listaImoveisVisita[index]
                                                .qrcode !=
                                            null
                                        ? "Vinculado"
                                        : "Não Vinculado",
                                    style: KThemeModeApp.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget imovelDetalhes() {
    final viewModelStoreT = Provider.of<ViewModelStore>(context, listen: true);

    return Observer(builder: (_) {
      return Column(children: [
        Text(
          "Imóvel Cadastrado",
          style: KThemeModeApp.of(context).bodyLarge,
          textAlign: TextAlign.center,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FontAwesomeIcons.house,
                    size: 15,
                    color: KThemeModeApp.of(context).primary,
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.house,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "LOGRADOURO",
                        style: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          viewModelStoreT.imovelVisita.endereco?.logradouro ??
                              viewModelStoreT.logradoutroAux ??
                              "Não Informado",
                          style: KThemeModeApp.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 5,
                endIndent: 10,
                indent: 10,
                color: KThemeModeApp.of(context).accent1,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.listNumeric,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "NÚMERO",
                        style: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          viewModelStoreT.imovelVisita.endereco?.numero
                                  .toString() ??
                              viewModelStoreT.numeroAux ??
                              "Não Informado",
                          style: KThemeModeApp.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 5,
                endIndent: 10,
                indent: 10,
                color: KThemeModeApp.of(context).accent1,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city_rounded,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "COMPLEMENTO ",
                        style: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          viewModelStoreT.imovelVisita.endereco?.complemento ??
                              viewModelStoreT.complementoAux ??
                              "Não Possui",
                          style: KThemeModeApp.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 5,
                endIndent: 10,
                indent: 10,
                color: KThemeModeApp.of(context).accent1,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city_rounded,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "BAIRRO ",
                        style: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          viewModelStoreT.imovelVisita.endereco?.bairro ??
                              viewModelStoreT.bairroAux ??
                              "Não Possui",
                          style: KThemeModeApp.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 5,
                endIndent: 10,
                indent: 10,
                color: KThemeModeApp.of(context).accent1,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.feed,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "SITUAÇÃO VISITA ",
                        style: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          viewModelStoreT.imovelVisita.visita?.situacaoVisita
                                  ?.situacao ??
                              viewModelStoreT.situacaoVisitaAux ??
                              "NÃO VISITADO",
                          style: KThemeModeApp.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 5,
                endIndent: 10,
                indent: 10,
                color: KThemeModeApp.of(context).accent1,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.home_filled,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "TIPO DE IMÓVEL",
                        style: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          viewModelStoreT.imovelVisita.tipoImovel?.tipo ??
                              viewModelStoreT.tipoimovelAux ??
                              "Não Informado",
                          style: KThemeModeApp.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 5,
                endIndent: 10,
                indent: 10,
                color: KThemeModeApp.of(context).accent1,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.qr_code,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "QRCODE",
                        style: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          viewModelStoreT.imovelVisita.qrcodeId != null
                              ? "Vinculado"
                              : viewModelStoreT.qrcodeAux != null &&
                                      viewModelStoreT.qrcodeAux != "null" &&
                                      viewModelStoreT.qrcodeAux != ""
                                  ? "Vinculado"
                                  : "Não Vinculado",
                          style: KThemeModeApp.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
            ],
          ),
        )
      ]);
    });
  }

  Widget _botaoRecusa() {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);
    final iniciaVisitaStoreT =
        Provider.of<IniciaVisitaStore>(context, listen: true);
    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    final localVisitasStore =
        Provider.of<LocalVisitasStore>(context, listen: false);
    return KitButton(
      widgetCenter: Text(
        "Recusa",
        style: KThemeModeApp.of(context).bodyLarge.copyWith(
              color: KThemeModeApp.of(context).primaryBtnText,
            ),
      ),
      iconPrefix: Icon(
        Icons.block_flipped,
        color: KThemeModeApp.of(context).primaryBtnText,
      ),
      iconSufix: const Icon(FontAwesomeIcons.qrcode, color: Colors.transparent),
      onTap: () async {
        iniciaVisitaStore.setLoad(true);
        localVisitasStore.setAddListaVisitasAgenteLocal(
            viewModelStore.imovelVisita.toJson().toString());

        if (iniciaVisitaStoreT.visibilidadeBotaoRecusado) {
          iniciaVisitaStore.setVisibilidadeBotaoRecusado(false);
          await ServicesRequestPostApp(context).imovelRecusado();
        }
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
            KThemeModeApp.of(context).accent3,
            KThemeModeApp.of(context).tertiary,
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

    return KitButton(
      widgetCenter: Text(
        "Fechado",
        style: KThemeModeApp.of(context).bodyLarge.copyWith(
              color: KThemeModeApp.of(context).primaryBtnText,
            ),
      ),
      iconPrefix: Icon(
        Icons.door_back_door_rounded,
        color: KThemeModeApp.of(context).primaryBtnText,
      ),
      iconSufix: const Icon(FontAwesomeIcons.qrcode, color: Colors.transparent),
      onTap: () async {
        iniciaVisitaStore.setLoad(true);
        localVisitasStore.setAddListaVisitasAgenteLocal(
            viewModelStore.imovelVisita.toJson().toString());
        if (iniciaVisitaStoreT.visibilidadeBotaoFechado) {
          iniciaVisitaStore.setVisibilidadeBotaoFechado(false);
          await ServicesRequestPostApp(context).imovelFechado();
        }
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
            KThemeModeApp.of(context).accent3,
            KThemeModeApp.of(context).tertiary,
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

  Widget _botaoProximo() {
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);

    final viewModelStore = Provider.of<ViewModelStore>(context, listen: false);
    return KitButton(
      widgetCenter: Text(
        "Iniciar Visita",
        style: KThemeModeApp.of(context).bodyLarge.copyWith(
              color: KThemeModeApp.of(context).primaryBtnText,
            ),
      ),
      iconPrefix: const Icon(
        FontAwesomeIcons.qrcode,
        color: Colors.transparent,
      ),
      iconSufix: Icon(Icons.arrow_forward_ios,
          color: KThemeModeApp.of(context).primaryBtnText),
      onTap: () async {
        iniciaVisitaStore.setLoad(true);
        // INICIAR VISITA EM IMOVEI QUE SAO DOS TIPOS ABAIXO NAO PRECISA DE QR CODE

        if (viewModelStore.imovelVisita.tipoImovel?.id == 3 ||
            viewModelStore.imovelVisita.tipoImovel?.id == 10 ||
            viewModelStore.imovelVisita.tipoImovel?.id == 8 ||
            viewModelStore.tipoimovelAux == "Terreno Baldio" ||
            viewModelStore.tipoimovelAux == "Outros" ||
            viewModelStore.tipoimovelAux == "Praça Pública") {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (_) => FormularioCheckPage()));
          return;
        }

        // await GlobalsAlerts(context).alertInfoQrCode("Informação");

        iniciaVisitaStore.setLoad(false);
      },
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      iconPrefixPadding: const EdgeInsets.only(left: 15),
      height: 50,
      width: MediaQuery.of(context).size.width * .7,
      decorationButton: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            KThemeModeApp.of(context).accent2,
            KThemeModeApp.of(context).primary,
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

  Widget _botaoCadastrarImovel() {
    return KitButton(
      widgetCenter: Text(
        "Cadastrar Imovel",
        style: KThemeModeApp.of(context).bodyLarge.copyWith(
              color: KThemeModeApp.of(context).primaryBtnText,
            ),
      ),
      iconPrefix: Icon(
        FontAwesomeIcons.house,
        color: KThemeModeApp.of(context).primaryBtnText,
      ),
      iconSufix: Icon(Icons.arrow_forward_ios,
          color: KThemeModeApp.of(context).primaryBtnText),
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => FormularioImovelPage()));
      },
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      iconPrefixPadding: const EdgeInsets.only(left: 15),
      height: 50,
      width: MediaQuery.of(context).size.width * .7,
      decorationButton: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            KThemeModeApp.of(context).accent2,
            KThemeModeApp.of(context).primary,
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
}
