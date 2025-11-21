import 'package:authorised_image_picker/models/base_image_model.dart';
import 'package:authorised_image_picker/repo/image_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageListNotifier extends AsyncNotifier<List<BaseImageModel>> {
  final _repository = ImageRepository();

  List<BaseImageModel> images = [];

  int currentPage = 1;

  @override
  Future<List<BaseImageModel>> build() async {
    return [...await _repository.loadImages(currentPage) ?? []];
  }

  Future<void> loadImages({required bool isNext}) async {
    final current = state.value ?? [];

    state = const AsyncValue.loading();
    if (isNext) {
      ++currentPage;
    } else {
      currentPage = 1;
      state = AsyncValue.data([]);
    }
    await _repository.loadImages(currentPage).then((list) {
      current.addAll(list ?? []);
      state = AsyncValue.data(current);
    });
  }

  Future<void> pickImage() async {
    final current = state.value ?? [];

    final updated = await _repository.pickImage(current);
    state = AsyncValue.data(updated);
  }
}

final imageListProvider = AsyncNotifierProvider<ImageListNotifier, List<BaseImageModel>>(ImageListNotifier.new);
