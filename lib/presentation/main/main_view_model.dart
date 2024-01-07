import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app_clean_architecture/core/result.dart';

import 'package:image_search_app_clean_architecture/domain/repository/image_item_repository.dart';


import '../../domain/model/image_item.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainViewModel extends ChangeNotifier {
  final ImageItemRepository _imageItemRepository;

  MainState _state = const MainState();

  MainState get state => _state;

  final _eventController = StreamController<MainEvent>();

  Stream<MainEvent> get eventStream => _eventController.stream;

  MainViewModel({
    required ImageItemRepository imageItemRepository,
  }) : _imageItemRepository = imageItemRepository;

  Future<void> fetchImages(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _imageItemRepository.getImageItems(query);
    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: result.data,
        );
        notifyListeners();
      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItems: [],
        );
        notifyListeners();
        _eventController.add(const MainEvent.dataLoadingError());
    }
  }
}
