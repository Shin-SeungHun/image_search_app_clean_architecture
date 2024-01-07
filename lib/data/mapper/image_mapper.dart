import 'package:image_search_app_clean_architecture/data/model/image_item.dart';

import '../dto/image_dto.dart';

extension HitsToImageItem on Hits {
  ImageItem toImageItem() {
    return ImageItem(
        id: id as int, imageUrl: previewURL ?? '', tags: tags ?? '');
  }
}
