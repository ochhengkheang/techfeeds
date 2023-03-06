import 'package:flutter/cupertino.dart';
import 'package:techfeeds/data/network/network_api_service.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/models/article_reponse.dart';
import 'package:techfeeds/models/article_request.dart';
import 'package:techfeeds/models/image_response.dart';
import 'package:techfeeds/res/app_url.dart';

class ArticleRepository {
  final _apiService = NetworkApiService();

  Future<ArticleModel> getArticle(page, limit) async {
    try {
      //doublue populate to fetch both thumbnail and category data and attribute
      //if the url populate only 1, even if the model is right and the code to fetch it is right, the data will show null. Therefore, you need to include category in the url to fetch it
      var url =
          '${AppUrl.getArticle}?pagination%5Bpage%5D=$page&pagination%5BpageSize%5D=$limit&populate=thumbnail&populate=category';
      print('url $url');
      dynamic response = await _apiService.getApiResponse(url);
      return response = ArticleModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  Future postArticle(dataRequest) async {
    try {
      var data = ArticleRequest(data: dataRequest);
      var article = ArticleRequest(data: dataRequest);
      var response =
          await _apiService.postApi(AppUrl.getArticle, article.toJson());
      return response = ArticleResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ImageResponse> uploadImage(file) async {
    try {
      var response = await _apiService.uploadImage(AppUrl.uploadImage, file);
      return response = ImageResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
