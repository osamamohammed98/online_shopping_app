import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProviderFirebase extends ChangeNotifier {
  List<dynamic> imageUrl = [];
  List<dynamic> productSize = [];
  bool isLoading = true;
  Map<String, dynamic> dataObjects = {};
  String countInCart = "";
  List<QueryDocumentSnapshot> savedLists = [];
  List<QueryDocumentSnapshot> cartLists = [];

  String price = "";

  Map<String, dynamic> setProductObject(Map<String, dynamic> dataObjects) {
    this.dataObjects = dataObjects;
    notifyListeners();
  }

  Map<String, dynamic> getProductObject() {
    return dataObjects ?? {"k", "n"};
  }

  List<String> setListImaget(List<dynamic> imageUrl) {
    this.imageUrl = imageUrl;
    notifyListeners();
  }

  List<String> getListImaget() {
    var items = List<String>.from(imageUrl);
    return items ?? ["no image in the list"];
  }

  List<String> setListSizes(List<dynamic> productSize) {
    this.productSize = productSize;
    notifyListeners();
  }

  List<String> getListSizes() {
    var sizeItems = List<String>.from(productSize);
    print(sizeItems);
    return sizeItems;
  }

  setLoading() {
    this.isLoading = !isLoading;
    notifyListeners();
  }

  setSavedListsItem(List<QueryDocumentSnapshot> savedLists) {
    this.savedLists = savedLists;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> getSavedListsItem() {
    return savedLists;
  }

  setItemsCart(List<QueryDocumentSnapshot> cartLists) {
    this.cartLists = cartLists;
    setCartPrice(cartLists);
    notifyListeners();
  }

  List<QueryDocumentSnapshot> getItemsCart() {
    return cartLists;
  }

  setCountInCart(String countInCart) {
    this.countInCart = countInCart;
    notifyListeners();
  }

  getCountInCart() {
    String count = countInCart;
    return count ?? "0";
  }

  void setCartPrice(List<QueryDocumentSnapshot> cartLists) {
    List<int> cart_items = [];
    for (int i = 0; i < cartLists.length; i++) {
      cart_items.add(int.parse(cartLists[i]["price"]));
      cart_items.map<int>((int m) => m).reduce((a, b) => a + b);
    }

    String price = "${cart_items.reduce((value, element) => value + element)}";
    print(price);
    this.price = price;
  }

  String getCartPrice() {
    return price;
  }
}
