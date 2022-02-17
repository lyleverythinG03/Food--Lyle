import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodlyle/global/global.dart';
import 'package:foodlyle/model/menus.dart';
import 'package:foodlyle/upload_screen/menus_upload.dart';
import 'package:foodlyle/widgets/info_design_widget.dart';
import 'package:foodlyle/widgets/my_drawer.dart';
import 'package:foodlyle/widgets/progress_bar.dart';
import 'package:foodlyle/widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
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
                  builder: (c) => const MenusUploadScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.post_add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(
                title: 'My menus',
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              builder: (c, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Menus model = Menus.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>,
                          );
                          return InformationDesignWidget(
                            context: context,
                            model: model,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("menus")
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
            ),
          ],
        ),
      ),
    );
  }
}
