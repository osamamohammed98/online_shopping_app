import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping_app/provider/provider_firebase.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:provider/provider.dart';

final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(colProductCollectionName);
final FirebaseAuth auth = FirebaseAuth.instance;

final CollectionReference collectionReferenceUser =
    FirebaseFirestore.instance.collection(colUserCollection);

FirebaseFirestore savedCollection = FirebaseFirestore.instance;

//todo this for products
Future getListImageById(String id, context) async {
  try {
    DocumentSnapshot snapshot = await collectionReference.doc(id).get();
    List<dynamic> data = snapshot.data()[docProductImagesUrl];
    List<dynamic> sizes = snapshot.data()[docProductSize];
    Map<String, dynamic> dataObject = snapshot.data();

    Provider.of<ProviderFirebase>(context, listen: false)
        .setProductObject(dataObject);

    Provider.of<ProviderFirebase>(context, listen: false).setListImaget(data);

    Provider.of<ProviderFirebase>(context, listen: false).setListSizes(sizes);

    Provider.of<ProviderFirebase>(context, listen: false).setLoading();

    return data;
  } catch (e) {
    print(e);
    print(e);
  }
}

String getUserId() {
  String id = auth.currentUser != null ? auth.currentUser.uid : null;
  return id;
}

Future saveCart({String id, String productId, Map<String, dynamic> map}) async {
  try {
    savedCollection
        .collection(savedCollectionName)
        .doc(getUserId())
        .collection("save")
        .add(map);
  } catch (e) {
    print(e);
  }
}

Future getSavedItem(context) async {
  try {
    QuerySnapshot snapshot = await savedCollection
        .collection(savedCollectionName)
        .doc(getUserId())
        .collection("save")
        .get();

    List<QueryDocumentSnapshot> saved = snapshot.docs;
    print("saved${saved[0]["desc"]}");
    Provider.of<ProviderFirebase>(context, listen: false)
        .setSavedListsItem(saved);
  } catch (e) {
    print(e);
  }
}

//todo this for add to cart
Future addToCart(context, {String id, String selectedSize, Map map}) async {
  try {
    return collectionReferenceUser
        .doc(getUserId())
        .collection(colUserCartCollection)
        .add({
      ...map,
      colUserCartSizeCollection: "$selectedSize",
    }).whenComplete(() => Provider.of<ProviderFirebase>(context, listen: false)
            .setLoading());
  } catch (e) {
    print(e);
  }
}

Future getListItemFromCart(context) async {
  try {
    QuerySnapshot snapshot = await collectionReferenceUser
        .doc(await getUserId())
        .collection(colUserCartCollection)
        .get();
    List<QueryDocumentSnapshot> listItemsInCarts = snapshot.docs;
    print("lists ${listItemsInCarts[0]["imagesUrl"]}");
    Provider.of<ProviderFirebase>(context, listen: false)
        .setItemsCart(listItemsInCarts);
  } catch (e) {
    print(e);
  }
}

Future<String> getCountInCartStream(context) async {
  try {
    QuerySnapshot snapshot = await collectionReferenceUser
        .doc(await getUserId())
        .collection(colUserCartCollection)
        .get();
    Provider.of<ProviderFirebase>(context, listen: false)
        .setCountInCart("${snapshot.size}");
    Provider.of<ProviderFirebase>(context, listen: false).setLoading();
    return "${snapshot.size}";
  } catch (e) {
    print(e);
  }
}
