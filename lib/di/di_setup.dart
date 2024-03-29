import 'package:get_it/get_it.dart';
import 'package:image_search_app_clean_architecture/domain/repository/image_item_repository.dart';
import 'package:image_search_app_clean_architecture/data/repository/image_item_repository_impl.dart';

import '../data/data_source/image_api.dart';
import '../presentation/main/main_view_model.dart';


final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<ImageApi>(ImageApi());

  getIt.registerSingleton<ImageItemRepository>(
      ImageItemRepositoryImpl(api: getIt<ImageApi>()));
  getIt.registerFactory<MainViewModel>(
      () => MainViewModel(imageItemRepository: getIt<ImageItemRepository>()));
}
