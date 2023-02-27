class ArticleModel {
  List<Data>? data;
  Meta? meta;

  ArticleModel({this.data, this.meta});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? title;
  String? slug;
  bool? status;
  String? content;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  Thumbnail? thumbnail;

  Attributes(
      {this.title,
      this.slug,
      this.status,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.thumbnail});

  Attributes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    status = json['status'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    return data;
  }
}

class Thumbnail {
  ThumbnailData? data;
  String? url;

  Thumbnail({this.data, this.url});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new ThumbnailData.fromJson(json['data']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['url'] = this.url;
    return data;
  }
}

class ThumbnailData {
  int? id;

  ThumbnailData({this.id});

  ThumbnailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    return data;
  }
}
