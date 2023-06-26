import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../pages/home_page/home.dart';

class AddIntakeWidget extends StatefulWidget {
  const AddIntakeWidget({Key? key}) : super(key: key);

  @override
  _AddIntakeWidgetState createState() => _AddIntakeWidgetState();
}

class _AddIntakeWidgetState extends State<AddIntakeWidget> {
  bool? switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate1 = DateTime.now();
  DateTime? selectedDate2;

  bool loaded = false;

  getIntakes() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('intakes')
        .where('intake', isEqualTo: selectedDate2)
        .get();

    if (snap.docs.isEmpty) {
      bool pressed = await alert(context, 'Do you want to Add InTake...?');

      if (pressed) {
        FirebaseFirestore.instance.collection('intakes').add({
          'intake': selectedDate2,
          'userId': currentUserUid,
          'userEmail': currentUserEmail,
          'created_date': DateTime.now(),
          'available': true,
        });
        setState(() {
          selectedDate2 = null;
        });
        showUploadMessage(context, 'New Intake Created...');
      }
    } else {
      showUploadMessage(context, 'Intake Already Added...');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        height: 100,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      showMonthPicker(
                                        context: context,
                                        firstDate: DateTime(
                                            DateTime.now().year - 1, 5),
                                        lastDate: DateTime(
                                            DateTime.now().year + 4, 12),
                                        initialDate: selectedDate1,
                                      ).then((date) {
                                        if (date != null) {
                                          setState(() {
                                            selectedDate2 = date;
                                          });
                                        }
                                      });
                                    },
                                    text: selectedDate2 == null
                                        ? 'Choose'
                                        : dateTimeFormat('yMMM', selectedDate2!),
                                    options: FFButtonOptions(
                                      width: 150,
                                      height: 40,
                                      color: Color(0xff0054FF),
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      if (selectedDate2 != null) {
                                        getIntakes();
                                      } else {
                                        showUploadMessage(
                                            context, 'Please Choose Intake');
                                      }
                                    },
                                    text: 'Add',
                                    icon: Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 40,
                                      color: Color(0xff231F20),
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Available Intakes',
                style: FlutterFlowTheme.subtitle1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF090F13),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('intakes')
                    .where('available', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List data = snapshot.data!.docs;
                  data.sort((a, b) {
                    return a["intake"].compareTo(b["intake"]);
                  });

                  return Wrap(
                    children: List.generate(data.length, (index) {
                      if (loaded == false) {
                        loaded = true;
                        switchListTileValue = data[index]['available'];
                      }
                      return Intakes(
                        date: data[index]['intake'].toDate(),
                        available: data[index]['available'],
                        id: data[index].id,
                      );
                    }),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Past Intakes',
                style: FlutterFlowTheme.subtitle1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF090F13),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('intakes')
                    .where('available', isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List data = snapshot.data!.docs;
                  data.sort((a, b) {
                    return a["intake"].compareTo(b["intake"]);
                  });
                  return Wrap(
                    children: List.generate(data.length, (index) {
                      if (loaded == false) {
                        loaded = true;
                        switchListTileValue = data[index]['available'];
                      }
                      return Intakes(
                        date: data[index]['intake'].toDate(),
                        available: data[index]['available'],
                        id: data[index].id,
                      );
                    }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class Intakes extends StatefulWidget {
  final DateTime date;
  final bool available;
  final String id;
  const Intakes({Key? key, required this.date, required this.available, required this.id})
      : super(key: key);

  @override
  State<Intakes> createState() => _IntakesState();
}

class _IntakesState extends State<Intakes> {
  bool available = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    available = widget.available;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x2E000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFFDBE2E7),
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.calendarCheck,
                          color: Colors.black,
                          size: 22,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          dateTimeFormat('yMMM', widget.date),
                          style: FlutterFlowTheme.subtitle1.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SwitchListTile(
                        value: available,
                        onChanged: (newValue) {
                          FirebaseFirestore.instance
                              .collection('intakes')
                              .doc(widget.id)
                              .update({
                            'available': newValue,
                          });
                          setState(() {
                            available = newValue;
                          });
                        },
                        tileColor: Color(0xFFF5F5F5),
                        activeColor: Color(0xFF37BB8D),
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
