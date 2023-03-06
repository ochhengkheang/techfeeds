import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:techfeeds/data/response/api_response.dart';
import 'package:techfeeds/models/image_response.dart';
import 'package:techfeeds/repository/article_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final _articleRepository = ArticleRepository();
  ApiResponse<ImageResponse> imageResponse = ApiResponse.loading();

  setImageResponse(ApiResponse<ImageResponse> response) {
    imageResponse = response;
    notifyListeners();
  }

  Future<dynamic> uploadImage(file) async {
    await _articleRepository
        .uploadImage(file)
        .then((image) => {setImageResponse(ApiResponse.complete(image))})
        .onError((error, stackTrace) =>
            {setImageResponse(ApiResponse.error(error.toString()))});
  }
}
