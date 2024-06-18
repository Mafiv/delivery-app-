class API {
  
  static const hostConnect = "http://192.168.124.248";

//for customer
  static const orderApi = "$hostConnect/Delivery_app_project/order/Save_orders.php";
  static const showAllOrder = "$hostConnect/Delivery_app_project/order/ShowOrder.php";
  static const saveOrder = "$hostConnect/Delivery_app_project/order/Save_orders.php";
  static const AddToCartApi = "$hostConnect/Delivery_app_project/cart/save_cart.php";
  static const ShowAllCart = "$hostConnect/Delivery_app_project/cart/showAllcarts.php";
  static const DeleteCart = "$hostConnect/Delivery_app_project/cart/deletecart.php";
  static const gotoProfileAPI = "$hostConnect/Delivery_app_project/user/showprofilepage.php";
  static const upDateProfile = "$hostConnect/Delivery_app_project/user/updateprofilePage.php";
  static const ShowBySearch  = "$hostConnect/Delivery_app_project/product/SearchProducts.php";  
  static const validateEmail = "$hostConnect/Delivery_app_project/user/validateEmail.php";
  static const Login = "$hostConnect/Delivery_app_project/user/login.php";
   static const signUp = "$hostConnect/Delivery_app_project/user/signUp.php";
  static const ProductApi = '$hostConnect/Delivery_app_project/product/showproducts.php';


  

  //to the delivary person
  static const showCustomerInfo = '$hostConnect/Delivery_app_project/deliveryPerson/info.php';
  static const AllOrdersForDelivary = '$hostConnect/Delivery_app_project/deliveryPerson/allOrdersList.php';
  static const updateStatusApi = '$hostConnect/Delivery_app_project/deliveryPerson/updateStatus.php';
  static const SaveO = '$hostConnect/Delivery_app_project/deliveryPerson/updateStatus.php';
  static const DeliveryLogin = '$hostConnect/Delivery_app_project/deliveryPerson/delivery_login.php';


  

//for admin
  static const AddDeliveryPerson = "$hostConnect/Delivery_app_project/admin/add/addDeliveryPerson.php";
  static const validateDeliveryPerson = "$hostConnect/Delivery_app_project/admin/validateDeliveryPerson.php";
  static const ShowAllCustomer = "$hostConnect/Delivery_app_project/admin/allCustomers.php";
  static const AddProduct = "$hostConnect/Delivery_app_project/admin/add/AddProduct.php";
  static const Detail = "$hostConnect/Delivery_app_project/admin/detail.php";
  static const Update = "$hostConnect/Delivery_app_project/updateproduct.php";



  

}
