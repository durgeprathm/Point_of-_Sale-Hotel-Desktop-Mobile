import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CutomSubMenuListItem extends StatefulWidget {
  final int rowid1;
  final String title1;
  Color mcolor1;
  FaIcon micon1;
  int rowid2;
  String title2;
  Color mcolor2;
  FaIcon micon2;
  Function getPosition;

  int rowid3;
  String title3;
  Color mcolor3;
  FaIcon micon3;

  CutomSubMenuListItem(
      this.rowid1, this.title1, this.mcolor1, this.micon1, this.getPosition);

  CutomSubMenuListItem.copywith2(
      this.rowid1,
      this.title1,
      this.mcolor1,
      this.micon1,
      this.rowid2,
      this.title2,
      this.mcolor2,
      this.micon2,
      this.getPosition);

  CutomSubMenuListItem.copywith3(
      this.rowid1,
      this.title1,
      this.mcolor1,
      this.micon1,
      this.rowid2,
      this.title2,
      this.mcolor2,
      this.micon2,
      this.rowid3,
      this.title3,
      this.mcolor3,
      this.micon3,
      this.getPosition);

  @override
  _CutomSubMenuListItemState createState() => _CutomSubMenuListItemState();
}

class _CutomSubMenuListItemState extends State<CutomSubMenuListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenOrien = MediaQuery.of(context).orientation;
    return screenOrien == Orientation.portrait
        ? MobileWidget(widget: widget)
        : TabeletWidget(widget: widget);
  }
}

class MobileWidget extends StatelessWidget {
  const MobileWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CutomSubMenuListItem widget;

  @override
  Widget build(BuildContext context) {
    if (widget.rowid2 == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.getPosition(widget.rowid1);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: widget.mcolor1,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: widget.micon1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.title1,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Expanded(
                  child: Visibility(
                    visible: false,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: widget.mcolor1,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: widget.micon1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.title1,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.getPosition(widget.rowid1);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: widget.mcolor1,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: widget.micon1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.title1,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.getPosition(widget.rowid2);
                    },
                    child: Material(
                      color: widget.mcolor2,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: widget.micon2),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.title2,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
          // children: [
          //   Card(
          //     margin: EdgeInsets.symmetric(
          //       horizontal: 0,
          //       vertical: 4,
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.all(3),
          //       child: ListTile(
          //         title: Text(
          //           widget.title,
          //           style: listTextStyle,
          //         ),
          //         trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          //       ),
          //     ),
          //   ),
          // ],
        ),
      );
    }
  }
}

class TabeletWidget extends StatelessWidget {
  const TabeletWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CutomSubMenuListItem widget;

  @override
  Widget build(BuildContext context) {
    double tabletwidth = MediaQuery.of(context).size.width * (.35);
    double tabletwidth2 = MediaQuery.of(context).size.width * (.70);
    if (widget.rowid2 == null) {
      return Container(
        width: tabletwidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.getPosition(widget.rowid1);
                      },
                      child: Material(
                        color: widget.mcolor1,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(FontAwesomeIcons.calculator,
                                  size: 50.0, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                widget.title1,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (widget.rowid3 == null) {
      return Container(
        width: tabletwidth2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.getPosition(widget.rowid1);
                      },
                      child: Material(
                        color: widget.mcolor1,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: widget.micon1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                widget.title1,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.getPosition(widget.rowid2);
                      },
                      child: Material(
                        color: widget.mcolor2,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: widget.micon2),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                widget.title2,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.getPosition(widget.rowid1);
                    },
                    child: Material(
                      color: widget.mcolor1,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: widget.micon1),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.title1,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.getPosition(widget.rowid2);
                    },
                    child: Material(
                      color: widget.mcolor2,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: widget.micon2),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.title2,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.getPosition(widget.rowid3);
                    },
                    child: Material(
                      color: widget.mcolor3,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: widget.micon3),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.title3,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
