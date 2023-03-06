class ArticleRequest {
  DataRequest? data;

  ArticleRequest({this.data});

  ArticleRequest.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataRequest.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataRequest {
  String? title;
  String? slug;
  bool? status;
  String? content;
  String? thumbnail;
  String? category;
  List<String>? tags;

  DataRequest(
      {this.title,
      this.slug,
      this.status,
      this.content,
      this.thumbnail,
      this.category,
      this.tags});

  DataRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    status = json['status'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    category = json['category'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['category'] = this.category;
    data['tags'] = this.tags;
    return data;
  }
}
