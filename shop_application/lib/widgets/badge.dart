import 'package:flutter/material.dart';

class Badge extends StatelessWidget {

  ///This class is used to show a string on top right of a widget, such as the quatinty of products appears on top right of the shopping cart
  /// or the number of notifications on top right of the bell.

  const Badge({
    Key key,
    
    @required this.child,
    
    @required this.value,
    this.color,
  }) : super(key: key);


  ///This widget takes a child to draw a string on top right of this child
  final Widget child;
  
  ///The value need to be drawn
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}