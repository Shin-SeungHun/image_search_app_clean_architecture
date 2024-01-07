

import '../../core/result.dart';
import '../model/image_item.dart';
import '../repository/image_item_repository.dart';
import '../repository/star_repository.dart';

class SearchImageUseCase {
  final ImageItemRepository _imageItemRepository;
  final StarRepository _starRepository;

  const SearchImageUseCase({
    required ImageItemRepository imageItemRepository,
    required StarRepository starRepository,
  })  : _imageItemRepository = imageItemRepository,
        _starRepository = starRepository;

  Future<Result<List<ImageItem>>> execute(String query) async {
    final result = await _imageItemRepository.getImageItems(query);
    switch (result) {
      case Success<List<ImageItem>>():
        return Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        return Result.success(_starRepository
            .getStars()
            .map((e) => ImageItem(imageUrl: e.imageUrl, tags: e.title, id: e.id))
            .toList());
    }
    return result;
  }
}
