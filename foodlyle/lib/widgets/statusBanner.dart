import 'package:flutter/material.dart';

import '../mainScreens/home_screen.dart';

class StatusBanner extends StatelessWidget {
  final bool? status;
  final String? orderStatus;
  const StatusBanner({Key? key, this.status, this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;
    status! ? iconData = Icons.done : Icons.cancel;
    status! ? message = 'Successful' : 'Unsuccessful';
    return SafeArea(
      child: Container(
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
        height: 40,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const HomeScreen()));
              },
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                orderStatus == "ended"
                    ? "Parcel Delivered $message"
                    : "Order Placed $message",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: Icon(iconData, color: Colors.white, size: 14),
            ),
          ],
        ),
      ),
    );
  }
}
