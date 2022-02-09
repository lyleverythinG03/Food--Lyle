import 'package:flutter/material.dart';
import 'package:foodlyle/global/global.dart';
import 'package:foodlyle/model/menus.dart';
import 'package:foodlyle/upload_screen/items_upload_screen.dart';
import 'package:foodlyle/widgets/my_drawer.dart';
import 'package:foodlyle/widgets/text_widget_header.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  const ItemsScreen({Key? key, this.model}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "Lobster",
          ),
        ),
        flexibleSpace: Container(
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
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ItemsUploadScreen(model: widget.model),
                ),
              );
            },
            icon: const Icon(
              Icons.library_add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
                title: "My " + widget.model!.menuTitle.toString() + "'s Items"),
          ),
        ],
      ),
    );
  }
}
