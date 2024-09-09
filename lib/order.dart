class Order {
  String? dishName;
  int? votes;
  int? quantity;

  Order({this.dishName, this.votes, this.quantity});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      dishName: json['dishName'],
      votes: json['votes'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dishName': dishName,
      'votes': votes,
      'quantity': quantity,
    };
  }
}