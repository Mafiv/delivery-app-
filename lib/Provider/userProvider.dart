import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userId = '';
  String _deliveryPersonId = '';
  String _currentPage = "Home";
  String _AdminPage = "Home";

  UserProvider({String userId = '', String deliveryPersonId = '', String currentPage = ''})
      : _userId = userId,
       _deliveryPersonId = deliveryPersonId;
        
        

  String get currentPage => _currentPage;
  String get AdminPage => _AdminPage;

  String get userId => _userId;
  String get deliveryPersonId => _deliveryPersonId;

  void setAdminPage({required String newAdminPage}) {
    _AdminPage = newAdminPage;
    notifyListeners();
  }

  void setCurrentPage({required String newCurrentPage}) {
    _currentPage = newCurrentPage;
    notifyListeners();
  }


  void setUserName({required String newUserId}) {
    _userId = newUserId;
    notifyListeners();
  }

  void setDeliveryPersonName({required String newDeliveryPersonId}) {
    _deliveryPersonId = newDeliveryPersonId;
    notifyListeners();
  }
}
