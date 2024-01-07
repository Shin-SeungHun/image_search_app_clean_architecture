
import '../../domain/model/image_item.dart';
import '../dto/image_dto.dart';

extension HitsToImageItem on Hits {
  ImageItem toImageItem() {
    return ImageItem(
        id: id as int, imageUrl: previewURL ?? '', tags: tags ?? '');
  }
}
