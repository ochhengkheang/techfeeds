import 'package:flutter/cupertino.dart';
import 'package:techfeeds/data/response/api_response.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/models/article_reponse.dart';
import 'package:techfeeds/repository/article_repository.dart';

class ArticleViewModel extends ChangeNotifier {
  final _articleRepository = ArticleRepository();

  ApiResponse<ArticleModel> apiResponse = ApiResponse.loading();
  ApiResponse<ArticleResponse> articleResponse = ApiResponse.loading();
  ApiResponse<ArticleResponse> articlePutReponse = ApiResponse.loading();

  setArticleList(ApiResponse<ArticleModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  setArticleResponse(ApiResponse<ArticleResponse> response) {
    articleResponse = response;
    notifyListeners();
  }

  setPutResponse(ApiResponse<ArticleResponse> response) {
    articleResponse = response;
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

  Future postArticle(dataRequest) async {
    await _articleRepository
        .postArticle(dataRequest)
        .then((value) => {setArticleResponse(ApiResponse.complete(value))})
        .onError((error, stackTrace) =>
            {setArticleResponse(ApiResponse.error(error.toString()))});
    print('Post success');
  }

  Future putArticle(dataRequest, id) async {
    await _articleRepository
        .putArticle(dataRequest, id)
        .then((value) => {setPutResponse(ApiResponse.complete(value))})
        .onError((error, stackTrace) =>
            {setPutResponse(ApiResponse.error(error.toString()))});
    print('Put success');
  }
}
