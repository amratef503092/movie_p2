class SnacksModel
{
  String cinemaId;
  String id;
  String name;
  bool outOfStock;
  String miniShopId;
  String photo;
  int price;
  int quantity;
  int totalPrice;

  Map<String, dynamic> toMap() {
    return {
      'cinemaId': this.cinemaId,
      'id': this.id,
      'name': this.name,
      'outOfStock': this.outOfStock,
      'miniShopId': this.miniShopId,
      'photo': this.photo,
      'price': this.price,
      'quantity': this.quantity,
      'totalPrice': this.totalPrice,

    };
  }

  factory SnacksModel.fromMap(Map<String, dynamic> map) {
    return SnacksModel(
      cinemaId: map['cinemaId'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      outOfStock: map['outOfStock'] as bool,
      miniShopId: map['miniShopId'] as String,
      photo: map['photo'] as String,
      price: map['price'] as int,
      quantity: map['quantity']  ?? 0,
      totalPrice: map['totalPrice'] ?? 0,
    );
  }

  SnacksModel({
    required this.cinemaId,
    required this.id,
    required this.name,
    required this.outOfStock,
    required this.miniShopId,
    required this.photo,
    required this.price,
    required this.quantity,
    required this.totalPrice
  });
}