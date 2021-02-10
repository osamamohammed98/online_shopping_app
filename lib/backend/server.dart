import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping_app/util/strings.dart';

final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection(colProductCollectionName);
final FirebaseAuth auth = FirebaseAuth.instance;

final CollectionReference _collectionReferenceUser =
    FirebaseFirestore.instance.collection(colUserCollection);

List<dynamic> imageUrl = [];
List<dynamic> productSize = [];
bool isLoading = true;
Map<String, dynamic> dataObjects = {};
String countInCart = "";

//todo this for products
Future getListImageById(String id) async {
  try {
    DocumentSnapshot snapshot = await _collectionReference.doc(id).get();
    List<dynamic> data = snapshot.data()[docProductImagesUrl];
    List<dynamic> sizes = snapshot.data()[docProductSize];
    Map<String, dynamic> dataObject = snapshot.data();
    dataObjects = dataObject;
    imageUrl = data;
    productSize = sizes;
    isLoading = false;
    return data;
  } catch (e) {
    print(e);
    print(e);
  }
}

Map<String, dynamic> getProductObject() {
  return dataObjects ?? {"k", "n"};
}

List<String> getListImaget() {
  var items = List<String>.from(imageUrl);
  return items ?? ["no image in the list"];
}

List<String> getListSizes() {
  var sizeItems = List<String>.from(productSize);
  print(sizeItems);
  return sizeItems;
}

getUserId() async {
  String id = await auth.currentUser != null ? auth.currentUser.uid : null;
  return id;
}

//todo this for add to cart
Future addToCart({String id , String selectedSize}) async {
  try {
    return _collectionReferenceUser
        .doc(await getUserId())
        .collection(colUserCartCollection)
        .doc(id)
        .set({
      colUserCartSizeCollection: "$selectedSize",
    }).whenComplete(() => isLoading = false);
  } catch (e) {
    print(e);
  }
}

getCountInCartStream() async {
  try {
    QuerySnapshot snapshot = await _collectionReferenceUser
        .doc(await getUserId())
        .collection(colUserCartCollection)
        .get();
    countInCart = "${snapshot.size}";
    isLoading = false;
    return countInCart;
  } catch (e) {
    print(e);
  }
}

getCountInCart() {
  String count = countInCart;
  return count;
}
