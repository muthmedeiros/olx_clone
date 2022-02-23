import 'package:mobx/mobx.dart';

part 'create_ad_store.g.dart';

class CreateAdStore = _CreateAdStoreBase with _$CreateAdStore;

abstract class _CreateAdStoreBase with Store {
  ObservableList images = ObservableList();

  @computed
  int get itemCountLimit => images.length < 5 ? images.length + 1 : 5;
}
