import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeVigStore = _HomeVigStoreBase with _$HomeVigStore;

abstract class _HomeVigStoreBase with Store {
  @observable
  bool load = false; // Controla o carregamento da página

  @action
// ALTERNA O CARREGAMENTO DA PÁGINA
  void setLoading(_value) => load = _value;
}
