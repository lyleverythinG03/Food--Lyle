import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mainScreens/order_details_screen.dart';
import '../model/items.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {Key? key,
      this.itemCount,
      this.data,
      this.separateQuantityList,
      this.orderID})
      : super(key: key);
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final List<String>? separateQuantityList;
  final String? orderID;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black12,
            Colors.white54,
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
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: itemCount! * 125,
      child: ListView.builder(
        itemCount: itemCount,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Items model =
              Items.fromJson(data![index].data()! as Map<String, dynamic>);
          return placedOrderDesignWidget(
              model, context, separateQuantityList![index], orderID);
        },
      ),
    );
  }
}

Widget placedOrderDesignWidget(
    Items model, BuildContext context, separateQuantityList, String? orderId) {
  return InkWell(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.grey[200],
      child: Row(
        children: [
          Image.network(
            model.thumbnailUrl!,
            width: 120,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          model.title!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Acme",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '€ ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'x ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          separateQuantityList,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 30,
                            fontFamily: "Acme",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    //todo
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => OrderDetailsScreen(
                    orderId: orderId,
                  )));
    },
  );
}
