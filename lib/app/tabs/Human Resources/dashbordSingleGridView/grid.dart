import 'package:flutter/material.dart';

class SingleGrid extends StatefulWidget {
  final Map content;
  const SingleGrid({Key key, this.content}) : super(key: key);

  @override
  State<SingleGrid> createState() => _SingleGridState();
}

class _SingleGridState extends State<SingleGrid> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (v) {
              hovered = true;
              setState(() {});
            },
            onExit: (v) {
              hovered = false;
              setState(() {});
            },
            child: Container(
              height: hovered ? 110 : 100,
              width: hovered ? 160 : 150,
              decoration: hovered
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, //New
                          blurRadius: 2.0,
                        )
                      ],
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(20),
                    )
                  : BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
              child: Center(
                child: Image.asset(
                  widget.content['image'],
                  // height: 50,
                  // width: 75,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            widget.content['name'],
            style: TextStyle(),
          ))
        ],
      ),
    );
  }
}
