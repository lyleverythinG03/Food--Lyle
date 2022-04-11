import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';

separateOrdersItemIDs(orderIDs) {
  List<String> separateItemIdsList = [], defaultItemsList = [];
  int i = 0;
  defaultItemsList = List<String>.from(orderIDs);

  for (i; i < defaultItemsList.length; i++) {
    //5643123: 7
    String item = defaultItemsList[i].toString();
    var pos = item.lastIndexOf(":");
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;
    separateItemIdsList.add(getItemId);
  }
  return separateItemIdsList;
}

separateItemIDs() {
  List<String> separateItemIdsList = [], defaultItemsList = [];
  int i = 0;
  defaultItemsList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemsList.length; i++) {
    //5643123: 7
    String item = defaultItemsList[i].toString();
    var pos = item.lastIndexOf(":");
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;
    separateItemIdsList.add(getItemId);
  }
  return separateItemIdsList;
}

separateOrdersItemQuantities(orderIDs) {
  List<String> separateQuantityList = [];
  List<String> defaultItemsList = [];
  int i = 1;
  defaultItemsList = List<String>.from(orderIDs);

  for (i; i < defaultItemsList.length; i++) {
    //213141:3
    String item = defaultItemsList[i].toString();
    //3
    List<String> listItemCharacters = item.split(":").toList();
    var quantityNum = int.parse(listItemCharacters[1].toString());
    print("\nThis is Quantity Number = " + quantityNum.toString());
    print(separateQuantityList);
    separateQuantityList.add(quantityNum.toString());
  }
  return separateQuantityList;
}

separateItemQuantities() {
  List<int> separateQuantityList = [];
  List<String> defaultItemsList = [];
  int i = 1;
  defaultItemsList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemsList.length; i++) {
    //213141:3
    String item = defaultItemsList[i].toString();
    //3
    List<String> listItemCharacters = item.split(":").toList();
    var quantityNum = int.parse(listItemCharacters[1].toString());
    print("\nThis is Quantity Number = " + quantityNum.toString());
    print(separateQuantityList);
    separateQuantityList.add(quantityNum);
  }
  return separateQuantityList;
}

clearCartNow(context) {
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value) => {
            sharedPreferences!.setStringList("userCart", emptyList!),
          });
}
