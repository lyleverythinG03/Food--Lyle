import 'package:flutter/material.dart';
import 'package:foodlyle/mainScreens/items_screen.dart';
import 'package:foodlyle/model/items.dart';
import 'package:foodlyle/model/menus.dart';

class ItemsDesignWidget extends StatefulWidget {
  final Items? model;
  final BuildContext? context;
  const ItemsDesignWidget({Key? key, this.model, this.context})
      : super(key: key);

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (c) => ItemsScreen(model: widget.model),
        //   ),
        // );
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(
          5.0,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: "Signatra",
                ),
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontFamily: "Signatra",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
