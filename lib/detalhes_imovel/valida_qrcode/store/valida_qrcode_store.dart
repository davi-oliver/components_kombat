import 'package:mobx/mobx.dart';
part 'valida_qrcode_store.g.dart';

class ValidaQrCodeStore = _ValidaQrCodeStoreBase with _$ValidaQrCodeStore;

abstract class _ValidaQrCodeStoreBase with Store {
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;
}
