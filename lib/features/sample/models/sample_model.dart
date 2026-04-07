class SampleModel {
  SampleMeta? meta;
  List<SampleData>? data;
  SampleModel({this.meta, this.data});
  factory SampleModel.fromJson(Map<String, dynamic> json) => SampleModel(
        meta: json['meta'] != null
            ? SampleMeta.fromJson(json['meta'])
            : null,
        data: json['data'] != null
            ? List<SampleData>.from(
                json['data'].map((x) => SampleData.fromJson(x)),
              )
            : null,
      );
  Map<String, dynamic> toJson() {
    return {
      'meta': meta?.toJson(),
      'data': data?.map((x) => x.toJson()).toList(),
    };}}
// need for paginations
class SampleMeta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;
  SampleMeta({this.page, this.limit, this.total, this.totalPage});
  factory SampleMeta.fromJson(Map<String, dynamic> json) => SampleMeta(
        page: json['page'] as int?,
        limit: json['limit'] as int?,
        total: json['total'] as int?,
        totalPage: json['totalPage'] as int?,
      );
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPage': totalPage,
    };}}
class SampleData {
  String? id;
  String? name;
  String? description;
  double? price;
  int? stock;
  String? status;
  bool? isAvailable;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  SampleData({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.status,
    this.isAvailable,
    this.images,
    this.createdAt,
    this.updatedAt,
  });
  factory SampleData.fromJson(Map<String, dynamic> json) => SampleData(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        stock: json['stock'] as int?,
        isAvailable: json['isAvailable'] as bool?,
        images: json['images'] != null
            ? List<String>.from(json['images'])
            : null,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'status': status,
      'isAvailable': isAvailable,
      'images': images,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
