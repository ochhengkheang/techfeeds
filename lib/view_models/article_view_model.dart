import 'package:flutter/cupertino.dart';
import 'package:techfeeds/data/response/api_response.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/models/article_reponse.dart';
import 'package:techfeeds/repository/article_repository.dart';

class ArticleViewModel extends ChangeNotifier {
  final _articleRepository = ArticleRepository();

  ApiResponse<ArticleModel> apiResponse = ApiResponse.loading();
  ApiResponse<ArticleResponse> articleResponse = ApiResponse.loading();

  setArticleList(ApiResponse<ArticleModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  setArrticleResponse(ApiResponse<ArticleResponse> response) {
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
        .then((value) => {setArrticleResponse(ApiResponse.complete(value))})
        .onError((error, stackTrace) =>
            {setArrticleResponse(ApiResponse.error(error.toString()))});
    print('Post success');
  }
}
