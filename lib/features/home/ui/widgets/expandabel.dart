
import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final String title;

  ExpandableWidget({Key? key, required this.title}) : super(key: key);

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                height: isExpanded ? 230 : 70,
                width: isExpanded ? 385 : 390,
                decoration: BoxDecoration(
                  color: Color(0xff6F12E8),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff6F12E8).withOpacity(0.5),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tap to Expand it',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 27,
                        ),
                      ],
                    ),
                    if (isExpanded) ...[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class MyCustomWidget1 extends StatefulWidget {
//   @override
//   _MyCustomWidget1State createState() => _MyCustomWidget1State();
// }
//
// class _ExpandableWidgetState extends State<MyCustomWidget1> {
//   bool isTapped = true;
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 300,
//             ),
//             InkWell(
//               highlightColor: Colors.transparent,
//               splashColor: Colors.transparent,
//               onTap: () {
//                 setState(() {
//                   isTapped = !isTapped;
//                 });
//               },
//               onHighlightChanged: (value) {
//                 setState(() {
//                   isExpanded = value;
//                 });
//               },
//               child: AnimatedContainer(
//                 duration: Duration(seconds: 1),
//                 curve: Curves.fastLinearToSlowEaseIn,
//                 height: isTapped
//                     ? isExpanded
//                         ? 65
//                         : 70
//                     : isExpanded
//                         ? 225
//                         : 230,
//                 width: isExpanded ? 385 : 390,
//                 decoration: BoxDecoration(
//                   color: Color(0xff6F12E8),
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xff6F12E8).withOpacity(0.5),
//                       blurRadius: 20,
//                       offset: Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 padding: EdgeInsets.all(20),
//                 child: isTapped
//                     ? Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Tap to Expand it',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                               Icon(
//                                 isTapped
//                                     ? Icons.keyboard_arrow_down
//                                     : Icons.keyboard_arrow_up,
//                                 color: Colors.white,
//                                 size: 27,
//                               ),
//                             ],
//                           ),
//                         ],
//                       )
//                     : Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Tap to Expand it',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                               Icon(
//                                 isTapped
//                                     ? Icons.keyboard_arrow_down
//                                     : Icons.keyboard_arrow_up,
//                                 color: Colors.white,
//                                 size: 27,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             isTapped
//                                 ? ''
//                                 : 'Widgets that have global keys reparent '
//                                     'their subtrees when they are moved from one '
//                                     'location in the tree to another location in '
//                                     'the tree. In order to reparent its subtree, '
//                                     'a widget must arrive at its new location in '
//                                     'the tree in the same animation frame in '
//                                     'which it was removed from its old location '
//                                     'the tree.',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 17,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
