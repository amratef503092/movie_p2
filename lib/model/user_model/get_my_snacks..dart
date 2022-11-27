import '../cinema_owner_model/snacks.dart';

class GetMySnacks {
  String UserID;
  String snackId;
  int totalPrice;
  String cinemaId;
  String id;
  String name;
  bool outOfStock;
  String miniShopId;
  String photo;
  int price;
  int quantity;

  GetMySnacks({
    required this.UserID,
    required this.snackId,
    required this.totalPrice,
    required this.cinemaId,
    required this.id,
    required this.name,
    required this.outOfStock,
    required this.miniShopId,
    required this.photo,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserID': this.UserID,
      'snackId': this.snackId,
      'totalPrice': this.totalPrice,
      'cinemaId': this.cinemaId,
      'id': this.id,
      'name': this.name,
      'outOfStock': this.outOfStock,
      'miniShopId': this.miniShopId,
      'photo': this.photo,
      'price': this.price,
      'quantity': this.quantity,
    };
  }

  factory GetMySnacks.fromMap(Map<String, dynamic> map) {
    return GetMySnacks(
      UserID: map['UserID'] as String,
      snackId: map['snackId']  ?? '',
      totalPrice: map['totalPrice'] as int,
      cinemaId: map['cinemaId'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      outOfStock: map['outOfStock'] as bool,
      miniShopId: map['miniShopId'] as String,
      photo: map['photo'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
    );
  }
}
