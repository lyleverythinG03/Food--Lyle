import 'package:flutter/material.dart';
import 'package:foodlyle/mainScreens/items_screen.dart';
import 'package:foodlyle/model/menus.dart';

class InformationDesignWidget extends StatefulWidget {
  final Menus? model;
  final BuildContext? context;
  const InformationDesignWidget({Key? key, this.model, this.context})
      : super(key: key);

  @override
  _InformationDesignWidgetState createState() =>
      _InformationDesignWidgetState();
}

class _InformationDesignWidgetState extends State<InformationDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ItemsScreen(model: widget.model),
          ),
        );
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
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: "Signatra",
                ),
              ),
              Text(
                widget.model!.menuInfo!,
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
