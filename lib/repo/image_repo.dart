import 'package:authorised_image_picker/models/api_image_model.dart';
import 'package:authorised_image_picker/models/base_image_model.dart';
import 'package:authorised_image_picker/servises/api_image_service.dart';
import 'package:authorised_image_picker/servises/api_requester.dart';
import 'package:authorised_image_picker/servises/image_picker_service.dart';

class ImageRepository {
  ImageRepository();

  Future<List<ApiImageModel>?> loadImages(int? page) async {
    return await ApiImageService(ApiBaseRequester.instance).getImagesLIst(page: page).then((response) {
      if (response.isSuccess == true) {
        return response.result;
      } else {
        return null;
      }
    });
  }

  Future<List<BaseImageModel>> pickImage(List<BaseImageModel> current) async {
    final file = await ImagePickerService().pickGalleryImage();

    if (file == null) return current;
    final newImage = BaseImageModel(author: 'Me', downloadUrl: file.path, url: file.path);
    return [newImage, ...current];
  }
}
