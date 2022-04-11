import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodlyle/global/global.dart';
import 'package:foodlyle/model/items.dart';
import 'package:foodlyle/splashScreen/splash_screen.dart';
import 'package:foodlyle/widgets/simple_app_bar.dart';

class ItemDetailScreen extends StatefulWidget {
  final Items? model;
  const ItemDetailScreen({Key? key, this.model}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  deleteItem(String itemID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(
          sharedPreferences!.getString("uid"),
        )
        .collection("menus")
        .doc(widget.model!.menuID)
        .collection("items")
        .doc(itemID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection("items").doc(itemID).delete();
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
      Fluttertoast.showToast(msg: "Item deleted Successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: sharedPreferences!.getString("name")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.model!.thumbnailUrl!),
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: NumberInputPrefabbed.roundedButtons(
            //     controller: counterTextEditingController,
            //     incDecBgColor: Colors.amber,
            //     min: 1,
            //     max: 9,
            //     initialValue: 1,
            //     buttonArrangement: ButtonArrangement.incRightDecLeft,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.model!.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.model!.longDescription!,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.model!.price.toString() + "€ ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  //todo - Delete Item using individual itemId
                  deleteItem(widget.model!.itemID!);
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan,
                        Colors.amber,
                      ],
                      begin: FractionalOffset(
                        0.0,
                        0.0,
                      ),
                      end: FractionalOffset(
                        1.0,
                        0.0,
                      ),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: const Center(
                    child: Text(
                      'Delete Item',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
