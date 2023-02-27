import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:techfeeds/data/app_exception.dart';
import 'package:techfeeds/models/article.dart';

class NetworkApiService {
  Future<dynamic> getApiResponse(String url) async {
    dynamic responseJson;

    print('url api service $url');
    try {
      var response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);

      //return response = ArticleModel.fromJson(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    print('response in network service $responseJson');
    return responseJson;
  }

  returnResponse(http.Response response) {
    print('status returnResponse ${response.body}');
    switch (response.statusCode) {
      case 200:
        // print(jsonDecode(response.body));
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw FetchDataException('Unexpected Error');
    }
  }
}
