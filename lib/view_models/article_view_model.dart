import 'package:flutter/cupertino.dart';
import 'package:techfeeds/data/response/api_response.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/repository/article_repository.dart';

class ArticleViewModel extends ChangeNotifier {
  final _articleRepository = ArticleRepository();

  ApiResponse<ArticleModel> apiResponse = ApiResponse.loading();

  setArticleList(ApiResponse<ArticleModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> getArticles(page, limit) async {
    await _articleRepository.getArticle(page, limit).then((articleList) {
      print('success');
      setArticleList(ApiResponse.complete(articleList));
    }).onError((error, stackTrace) {
      print('error ${error.toString()}');
      setArticleList(ApiResponse.error(error.toString()));
    });
  }
}
