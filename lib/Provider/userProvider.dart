import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
   String _userId = '';
  String _deliveryPersonId = '';

  UserProvider({String userId = '', String deliveryPersonId = ''})
      : _userId = userId,
        _deliveryPersonId = deliveryPersonId;

  String get userId => _userId;
  String get deliveryPersonId => _deliveryPersonId;

  void setUserName({required String newUserId}) {
    _userId = newUserId;
    notifyListeners();
  }

  void setDeliveryPersonName({required String newDeliveryPersonId}) {
    _deliveryPersonId = newDeliveryPersonId;
    notifyListeners();
  }
}
