import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:techfeeds/data/app_exception.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/models/image_response.dart';

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

  Future postApi(url, object) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            url)); //fix value, change to url for dynamic 'https://cms.istad.co/api/e-commerce-products'
    request.body = json.encode(object);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future putApi(url, object) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse(url)); //fix value, change to url for dynamic
    request.body = json.encode(object);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteApi(url, object) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('DELETE', Uri.parse(url));
    request.body = json.encode(object);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future uploadImage(url, file) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('files', file));
    print('image data URL $url');
    var response = await request.send();
    print('image data response $response');
    var res = await response.stream.bytesToString();
    final decoded = json.decode(res);
    var imageList = List<ImageResponse>.from(
        decoded.map((image) => ImageResponse.fromJson(image)));
    print('image data ${imageList[0].toJson()}');
    return imageList[0].toJson();
  }

  returnResponse(http.Response response) {
    print('status returnResponse ${response.body}');
    switch (response.statusCode) {
      case 200:
        print(jsonDecode(response.body));
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
