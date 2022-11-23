class CinemaModel
{
  String id;
  String name;
  String address;
  String description;
  int number_of_halls;
  int number_of_mini_shops;
  String open;
  String close;

  CinemaModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.number_of_halls,
    required this.number_of_mini_shops,
    required this.open,
    required this.close,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'description': this.description,
      'number_of_halls': this.number_of_halls,
      'number_of_mini_shops': this.number_of_mini_shops,
      'open': this.open,
      'close': this.close,
    };
  }

  factory CinemaModel.fromMap(Map<String, dynamic> map) {
    return CinemaModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      description: map['description'] as String,
      number_of_halls: map['number_of_halls'] as int,
      number_of_mini_shops: map['number_of_mini_shops'] as int,
      open: map['open'] as String,
      close: map['close'] as String,
    );
  }
}