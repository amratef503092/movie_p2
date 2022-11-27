class TicketsModel{
  String cinemaId;
  String date;
  String hallName;
  String movieID;
  String movieName;
  int price;
  int quantity;
  String ticketId;
  String time;
  int totalPrice;
  String userID;
  String orderStatus;

  TicketsModel({
    required this.cinemaId,
    required this.date,
    required this.hallName,
    required this.movieID,
    required this.movieName,
    required this.price,
    required this.quantity,
    required this.ticketId,
    required this.time,
    required this.totalPrice,
    required this.userID,
    required this.orderStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'cinemaId': this.cinemaId,
      'date': this.date,
      'hallName': this.hallName,
      'movieID': this.movieID,
      'movieName': this.movieName,
      'price': this.price,
      'quantity': this.quantity,
      'ticketId': this.ticketId,
      'time': this.time,
      'totalPrice': this.totalPrice,
      'userID': this.userID,
      'orderStatus': this.orderStatus,
    };
  }

  factory TicketsModel.fromMap(Map<String, dynamic> map) {
    return TicketsModel(
      cinemaId: map['cinemaId'] as String,
      date: map['date'] as String,
      hallName: map['hallName'] as String,
      movieID: map['movieID'] as String,
      movieName: map['movieName'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      ticketId: map['ticketId'] as String,
      time: map['time'] as String,
      totalPrice: map['totalPrice'] as int,
      userID: map['userID'] as String,
      orderStatus: map['orderStatus'] as String,
    );
  }
}
