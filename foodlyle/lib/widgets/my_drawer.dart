import 'package:flutter/material.dart';
import 'package:foodlyle/authentication/auth_screen.dart';
import 'package:foodlyle/global/global.dart';
import 'package:foodlyle/mainScreens/earnings_screen.dart';
import 'package:foodlyle/mainScreens/history_screen.dart';
import 'package:foodlyle/mainScreens/home_screen.dart';
import 'package:foodlyle/mainScreens/new_orders_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 25,
              bottom: 10,
            ),
            child: Column(
              children: [
                //header Drawer
                Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(80),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString("photoUrl")!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Train"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: const [
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const HomeScreen(),
                ),
              );
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            thickness: 2,
          ),

          ListTile(
            leading: const Icon(
              Icons.monetization_on,
              color: Colors.black,
            ),
            title: const Text(
              'My Earnings',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const EarningsScreen(),
                ),
              );
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.reorder,
              color: Colors.black,
            ),
            title: const Text(
              'New Orders',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              //
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const NewOrdersScreen()));
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.local_shipping,
              color: Colors.black,
            ),
            title: const Text(
              'History - orders',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const HistoryScreen(),
                ),
              );
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              firebaseAuth.signOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const AuthScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
