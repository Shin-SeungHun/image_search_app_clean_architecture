import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../domain/model/image_item.dart';



part 'main_state.freezed.dart';

part 'main_state.g.dart';

@freezed
sealed class MainState<T> with _$MainState<T> {
  const factory MainState({
    @Default(false) bool isLoading,
    @Default([]) List<ImageItem> imageItems,
  }) = _MainState;

  factory MainState.fromJson(Map<String, Object?> json) =>
      _$MainStateFromJson(json);
}
