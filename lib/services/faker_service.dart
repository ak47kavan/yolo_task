import 'package:yolo_task/models/car_model.dart';



class FakerService {
  static Future<CardModel> fetchCardDetails() async {

    await Future.delayed(const Duration(milliseconds: 500)); // simulate latency

    return CardModel(
      cardNumber: "8124421234517891",
      expiry: "01/28",
      cvv: "123",
    );
  }
}
