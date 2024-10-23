// ignore_for_file: public_member_api_docs, sort_constructors_first

class Product {
  int? id;
  String? title;
  String? brand;
  dynamic? price;
  dynamic? discount;
  String? imageUrl;
  String? category;
  String? description;

  Product({
    this.id,
    this.title,
    this.brand,
    this.price,
    this.discount,
    this.imageUrl,
    this.category,
    this.description,
  });

  Product copyWith({
    int? id,
    String? title,
    String? brand,
    double? price,
    double? discount,
    String? imageUrl,
    String? category,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'brand': brand});
    result.addAll({'price': price});
    result.addAll({'discountPercentage': discount});
    result.addAll({'images': imageUrl});
    result.addAll({'category': category});
    result.addAll({'description': description});
    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      brand: map['brand'] ?? '',
      price: map['price'].cast<double>(),
      discount: map['discountPercentage'].cast<double>(),
      imageUrl: map['images'][0] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      price: json['price'] ?? '',
      discount: json['discountPercentage'] ?? '',
      imageUrl: json['images'][0] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
    );
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.brand == brand &&
        other.price == price &&
        other.discount == discount &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        brand.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        description.hashCode ^
        imageUrl.hashCode;
  }
}
