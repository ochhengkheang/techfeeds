import 'package:flutter/cupertino.dart';
import 'package:techfeeds/data/network/network_api_service.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/res/app_url.dart';

class ArticleRepository {
  final _apiService = NetworkApiService();

  Future<ArticleModel> getArticle(page, limit) async {
    try {
      var url =
          '${AppUrl.getCategory}?pagination%5Bpage%5D=$page&pagination%5BpageSize%5D=$limit&populate=thumbnail';
      print('url $url');
      dynamic response = await _apiService.getApiResponse(url);
      return response = ArticleModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
