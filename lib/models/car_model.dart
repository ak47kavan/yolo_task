class CardModel {
  final String cardNumber;
  final String expiry;
  final String cvv;

  CardModel({required this.cardNumber, required this.expiry, required this.cvv});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardNumber: json['cardNumber'],
      expiry: json['expiry'],
      cvv: json['cvv'],
    );
  }
}
