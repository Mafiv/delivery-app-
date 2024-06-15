import 'package:flutter/material.dart';

class forDelivaryPerson with ChangeNotifier {
  String deliveryPersonId = '';
  forDelivaryPerson({this.deliveryPersonId = ''});

  void setDeliveryPersonName({required String new_deliveryPerson}) async {
    deliveryPersonId = new_deliveryPerson;
    notifyListeners();
  }
}
