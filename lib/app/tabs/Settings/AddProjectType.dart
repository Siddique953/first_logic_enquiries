import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';

class AddProjectTypeWidget extends StatefulWidget {
  const AddProjectTypeWidget({Key? key}) : super(key: key);

  @override
  _AddProjectTypeWidgetState createState() => _AddProjectTypeWidgetState();
}

class _AddProjectTypeWidgetState extends State<AddProjectTypeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool edit = false;
  late TextEditingController name;
  late TextEditingController search;
  late TextEditingController eName;

  String currentId = '';
  String type = '';
  String durationValue = '';

  List selectedIntakes = [];

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    eName = TextEditingController();
    name = TextEditingController();
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            edit
                ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'UPDATE PROJECT TYPE',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              edit = false;
                              setState(() {});
                            },
                            text: 'Clear ',
                            options: FFButtonOptions(
                              width: 90,
                              height: 40,
                              color: Colors.red,
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'ADD PROJECT TYPES',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

            edit
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: 330,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: eName,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'project type',
                                      labelStyle:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      hintText: 'Please Enter Project type',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 11),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                if (eName.text != '') {
                                  bool proceed = await alert(
                                      context, 'You want to Update?');
                                  if (proceed) {
                                    FirebaseFirestore.instance
                                        .collection('projectType')
                                        .doc(currentId)
                                        .update({
                                      'name': eName.text,
                                      'search': setSearchParam(eName.text),
                                      'delete': false
                                    });
                                    showUploadMessage(
                                        context, 'project type Updated...');
                                    setState(() {
                                      edit = false;
                                      eName.text = '';
                                    });
                                  }
                                } else {
                                  showUploadMessage(
                                      context, 'Please Enter Name');
                                }
                              },
                              text: 'Update',
                              options: FFButtonOptions(
                                width: 100,
                                height: 50,
                                color: Colors.teal,
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: 330,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: name,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'project type ',
                                      labelStyle:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Please Enter project type',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                if (name.text != '') {
                                  bool proceed = await alert(context,
                                      'You want to Add This project type?');
                                  if (proceed) {
                                    FirebaseFirestore.instance
                                        .collection('projectType')
                                        .add({
                                      'name': name.text,
                                      'search': setSearchParam(name.text),
                                      'delete': false
                                    });
                                    showUploadMessage(context,
                                        'Project Type Added Successfully...');
                                    setState(() {
                                      edit = false;
                                      name.text = '';
                                    });
                                  }
                                } else {
                                  showUploadMessage(
                                      context, 'Please Enter Name');
                                }
                              },
                              text: 'Add',
                              options: FFButtonOptions(
                                width: 80,
                                height: 50,
                                color: Color(0xff0054FF),
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

            //search&clear section
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Container(
                    width: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x39000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: search,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Please Enter Name',
                                  labelStyle:
                                      FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF7C8791),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                search.clear();
                                setState(() {});
                              },
                              text: 'Clear',
                              options: FFButtonOptions(
                                width: 100,
                                height: 40,
                                color: Color(0xff0054FF),
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                                elevation: 2,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            search.text == ''
                ? Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('projectType')
                            .where('delete', isEqualTo: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var data = snapshot.data!.docs;
                          print(data.length);
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text("Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  DataColumn(
                                    label: Text("Action",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  DataColumn(
                                    label: Text("",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  data.length,
                                  (index) {
                                    String name = data[index]['name'];

                                    return DataRow(
                                      color: index.isOdd
                                          ? MaterialStateProperty.all(Colors
                                              .blueGrey.shade50
                                              .withOpacity(0.7))
                                          : MaterialStateProperty.all(
                                              Colors.blueGrey.shade50),
                                      cells: [
                                        DataCell(Text(
                                          name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(
                                          Row(
                                            children: [
                                              FFButtonWidget(
                                                onPressed: () {
                                                  setState(() {
                                                    edit = true;
                                                    currentId = data[index].id;
                                                    eName.text = name;
                                                  });
                                                },
                                                text: 'Edit',
                                                options: FFButtonOptions(
                                                  width: 70,
                                                  height: 30,
                                                  color: Colors.white,
                                                  textStyle: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius: 8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  bool proceed = await alert(
                                                      context,
                                                      'You want to Delete This project type?');
                                                  if (proceed) {
                                                    data[index]
                                                        .reference
                                                        .update(
                                                            {'delete': true});
                                                    showUploadMessage(context,
                                                        'project type Deleted...');
                                                    setState(() {
                                                      edit = false;
                                                    });
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xFFEE0000),
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('projectType')
                            .where('delete', isEqualTo: false)
                            .where('search',
                                arrayContains: search.text.toUpperCase())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var data = snapshot.data!.docs;
                          print(data.length);
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text("Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  DataColumn(
                                    label: Text("Action",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  DataColumn(
                                    label: Text("",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  data.length,
                                  (index) {
                                    String name = data[index]['name'];

                                    return DataRow(
                                      color: index.isOdd
                                          ? MaterialStateProperty.all(Colors
                                              .blueGrey.shade50
                                              .withOpacity(0.7))
                                          : MaterialStateProperty.all(
                                              Colors.blueGrey.shade50),
                                      cells: [
                                        DataCell(Text(
                                          name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(
                                          Row(
                                            children: [
                                              FFButtonWidget(
                                                onPressed: () {
                                                  setState(() {
                                                    edit = true;
                                                    currentId = data[index].id;
                                                    eName.text = name;
                                                  });
                                                },
                                                text: 'Edit',
                                                options: FFButtonOptions(
                                                  width: 70,
                                                  height: 30,
                                                  color: Colors.white,
                                                  textStyle: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius: 8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  bool proceed = await alert(
                                                      context,
                                                      'You want to Delete This project type?');
                                                  if (proceed) {
                                                    data[index]
                                                        .reference
                                                        .update(
                                                            {'delete': true});
                                                    showUploadMessage(context,
                                                        'project type Deleted...');
                                                    setState(() {
                                                      edit = false;
                                                    });
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xFFEE0000),
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
