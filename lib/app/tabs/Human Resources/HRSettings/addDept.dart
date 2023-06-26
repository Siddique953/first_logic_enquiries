import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';

class HrSettingsPage extends StatefulWidget {
  final TabController _tabController;
  const HrSettingsPage({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<HrSettingsPage> createState() => _HrSettingsPageState();
}

class _HrSettingsPageState extends State<HrSettingsPage> {
  bool edit = false;
  String selectedVal = '';
  String sebDeptId = '';

  //
  late TextEditingController dept;
  List<String> departmentList = [''];
  Map<String, dynamic> departmentIdByName = {};
  Map<String, dynamic> departmentNameById = {};
  late TextEditingController subDept;
  bool subDepartment = false;

  @override
  void initState() {
    super.initState();
    dept = TextEditingController();
    subDept = TextEditingController();
    listenDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                ),
                onPressed: () {
                  // setState(() {
                  widget._tabController.animateTo(5);
                  // });
                },
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        subDepartment
                            ? 'Manage Sub Department'
                            : 'Manage Department',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              edit
                                  ? subDepartment
                                      ? 'Update Sub Department'
                                      : 'Update Department'
                                  : subDepartment
                                      ? 'Add Sub Department'
                                      : 'Add Department',
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(children: [
                              Text('Department'),
                              SizedBox(
                                width: 10,
                              ),
                              CupertinoSwitch(
                                  activeColor: Colors.blue,
                                  trackColor: Colors.blue,
                                  thumbColor: Colors.white,
                                  value: subDepartment,
                                  onChanged: ((s) {
                                    print(subDepartment
                                        ? 'Sub Department'
                                        : 'Department');
                                    dept.clear();
                                    subDept.clear();
                                    edit = false;
                                    subDepartment = !subDepartment;

                                    // if (radioVal == 'Sub Department') {
                                    //   radioVal = 'Department';
                                    // } else {
                                    //   radioVal = 'Sub Department';
                                    // }

                                    setState(() {});
                                  })),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Sub Department '),
                            ]),
                            // Row(
                            //   children: [
                            //     Radio(
                            //         value: 'Department',
                            //         groupValue: radioVal,
                            //         onChanged: (s) {
                            //           radioVal = s;
                            //           setState(() {});
                            //         }),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     Text('Department'),
                            //     SizedBox(
                            //       width: 15,
                            //     ),
                            //     Radio(
                            //         value: 'Sub Department',
                            //         groupValue: radioVal,
                            //         onChanged: (s) {
                            //           radioVal = s;
                            //           setState(() {});
                            //         }),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     Text('Sub Department'),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            subDepartment
                                ? Expanded(
                                    child: Container(
                                      width: 350,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFE6E6E6),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 0, 0),
                                        child: Center(
                                          child: CustomDropdown.search(
                                            hintText: 'Select Department',
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            items: departmentList,
                                            controller: dept,
                                            // excludeSelected: false,
                                            onChanged: (s) {
                                              subDeptDataStream =
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'subDepartments')
                                                      .where('departmentId',
                                                          isEqualTo:
                                                              departmentIdByName[
                                                                  s])
                                                      .where('delete',
                                                          isEqualTo: false)
                                                      .snapshots();

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                      width: 350,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFE6E6E6),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 0, 0),
                                        child: TextFormField(
                                          controller: dept,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Department',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                            hintText:
                                                'Please Enter Department Name',
                                            hintStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(width: 10),
                            subDepartment
                                ? Expanded(
                                    child: Container(
                                      width: 350,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFE6E6E6),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 0, 0),
                                        child: TextFormField(
                                          controller: subDept,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Sub Department',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                            hintText:
                                                'Please Enter Sub Department Name',
                                            hintStyle: FlutterFlowTheme
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  )
                                : Spacer(),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 10, 30, 10),
                              child: InkWell(
                                  onTap: () async {
                                    // Department
                                    // Sub Department
                                    if (!edit) {
                                      if (!subDepartment) {
                                        if (dept.text != '') {
                                          FirebaseFirestore.instance
                                              .collection('departments')
                                              .add({
                                            'name': dept.text,
                                            'delete': false,
                                            'createdDate':
                                                FieldValue.serverTimestamp(),
                                          }).then((value) {
                                            value.update({
                                              'id': value.id,
                                            });

                                            showUploadMessage(context,
                                                '${dept.text} Department Added ');

                                            subDept.text = '';
                                            dept.text = '';
                                            setState(() {});
                                          });
                                        } else {
                                          showUploadMessage(context,
                                              'please insert department name');
                                        }
                                      } else {
                                        if (subDept.text != '' &&
                                            dept.text != '') {
                                          FirebaseFirestore.instance
                                              .collection('subDepartments')
                                              .add({
                                            'name': subDept.text,
                                            'delete': false,
                                            'createdDate':
                                                FieldValue.serverTimestamp(),
                                            'departmentId':
                                                departmentIdByName[dept.text]
                                          }).then((value) {
                                            value.update({
                                              'id': value.id,
                                            });
                                            showUploadMessage(context,
                                                'Sub Department Added Under ${dept.text}');

                                            subDept.text = '';
                                            dept.text = '';
                                          });
                                          setState(() {});
                                        } else {
                                          subDept.text == ''
                                              ? showUploadMessage(context,
                                                  'Please Add Sub Department')
                                              : showUploadMessage(context,
                                                  'Please Choose Department');
                                        }
                                      }
                                    } else {
                                      if (subDepartment == false) {
                                        if (dept.text != '') {
                                          FirebaseFirestore.instance
                                              .collection('departments')
                                              .doc(departmentIdByName[
                                                  selectedVal])
                                              .update({
                                            'name': dept.text,
                                          }).then((value) {
                                            showUploadMessage(context,
                                                '${dept.text} Department Updated ');

                                            subDept.text = '';
                                            dept.text = '';
                                            setState(() {});
                                          });
                                        } else {
                                          showUploadMessage(context,
                                              'please insert department name');
                                        }
                                      } else {
                                        if (subDept.text != '' &&
                                            dept.text != '') {
                                          FirebaseFirestore.instance
                                              .collection('subDepartments')
                                              .doc(sebDeptId)
                                              .update({
                                            'name': subDept.text,
                                            'departmentId':
                                                departmentIdByName[dept.text]
                                          }).then((value) {
                                            showUploadMessage(context,
                                                'Sub Department Added Under ${dept.text}');

                                            subDept.text = '';
                                            dept.text = '';
                                          });
                                          setState(() {});
                                        } else {
                                          subDept.text == ''
                                              ? showUploadMessage(context,
                                                  'Please Add Sub Department')
                                              : showUploadMessage(context,
                                                  'Please Choose Department');
                                        }
                                      }
                                    }
                                    // else {
                                    //   var currentHeadValue;
                                    //   print(currentList);
                                    //   currentList[currentListIndex] =
                                    //       expenseHead.text;
                                    //   print(currentList);
                                    //
                                    //   //get Current head Value
                                    //   DocumentSnapshot doc =
                                    //       await FirebaseFirestore.instance
                                    //           .collection('expenseHead')
                                    //           .doc(currentBranchId)
                                    //           .get();
                                    //   print(currentValue);
                                    //   FirebaseFirestore.instance
                                    //       .collection('expenseHead')
                                    //       .doc(currentBranchId)
                                    //       .update({
                                    //     'expenseHead': currentList,
                                    //     '${expenseHead.text}':
                                    //         doc['$currentValue'],
                                    //     '$currentValue': FieldValue.delete()
                                    //   });
                                    // }

                                    setState(() {
                                      edit = false;

                                      subDept.clear();
                                      dept.clear();
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xff0054FF),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      edit ? 'Update' : 'Add',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                child: !subDepartment
                    ? departmentList.isEmpty || departmentList[0] == ''
                        ? Center(
                            child: Text('No Data'),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: DataTable(
                              // horizontalMargin: 10,
                              // columnSpacing: 20,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Sl.No. ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Department Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                departmentList.length,
                                (index) {
                                  return DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        child: SelectableText(
                                          '${(index + 1).toString()}',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: SelectableText(
                                          departmentList[index],
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(
                                        Row(
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () {
                                                dept.text =
                                                    departmentList[index];
                                                selectedVal =
                                                    departmentList[index];

                                                setState(() {
                                                  edit = true;
                                                  // currentListIndex = index;
                                                  print(edit);
                                                  // print(currentListIndex);
                                                });
                                              },
                                              text: 'Edit',
                                              options: FFButtonOptions(
                                                width: 80,
                                                height: 30,
                                                color: Color(0xff0054FF),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
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
                                            // Generated code for this Button Widget...
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              icon: Icon(
                                                Icons.delete,
                                                color: Color(0xFFEE0000),
                                                size: 25,
                                              ),
                                              onPressed: () async {
                                                bool pressed = await alert(
                                                    context,
                                                    'Do you want Delete');

                                                if (pressed) {
                                                  FirebaseFirestore.instance
                                                      .collection('departments')
                                                      .doc(departmentIdByName[
                                                          departmentList[
                                                              index]])
                                                      .update({
                                                    'delete': true,
                                                  });

                                                  showUploadMessage(context,
                                                      'Department Deleted...');
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                    : StreamBuilder<QuerySnapshot>(
                        stream: subDeptDataStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List data = snapshot.data!.docs;

                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: DataTable(
                              horizontalMargin: 10,
                              columnSpacing: 20,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Sl.No. ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Sub Department",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                data.length,
                                (index) {
                                  return DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        child: SelectableText(
                                          '${(index + 1).toString()}',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: SelectableText(
                                          data[index]['name'],
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(
                                        Row(
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () {
                                                edit = true;

                                                dept.text = departmentNameById[
                                                    data[index]
                                                        ['departmentId']];

                                                subDept.text =
                                                    data[index]['name'];

                                                sebDeptId = data[index]['id'];
                                                setState(() {
                                                  print(
                                                      '[[[[[[[[[[[dept.text]]]]]]]]]]]');
                                                  print(dept.text);
                                                  print(
                                                      '[[[[[[[[[[[[[subDept.text]]]]]]]]]]]]]');
                                                  print(subDept.text);
                                                });
                                              },
                                              text: 'Edit',
                                              options: FFButtonOptions(
                                                width: 80,
                                                height: 30,
                                                color: Color(0xff0054FF),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
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
                                            // Generated code for this Button Widget...
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              icon: Icon(
                                                Icons.delete,
                                                color: Color(0xFFEE0000),
                                                size: 25,
                                              ),
                                              onPressed: () async {
                                                bool pressed = await alert(
                                                    context,
                                                    'Do you want Delete');

                                                if (pressed) {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'subDepartments')
                                                      .doc(data[index]['id'])
                                                      .update({
                                                    'delete': true,
                                                  });

                                                  showUploadMessage(context,
                                                      'Sub Department Deleted...');
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  listenDepartments() {
    FirebaseFirestore.instance
        .collection('departments')
        .where('delete', isEqualTo: false)
        .snapshots()
        .listen((event) {
      departmentList = [];
      for (var doc in event.docs) {
        departmentList.add(doc['name']);
        departmentIdByName[doc['name']] = doc.id;
        departmentNameById[doc.id] = doc['name'];
      }
      if (mounted) {
        setState(() {
          print(departmentNameById);
        });
      }
    });
  }

  Stream<QuerySnapshot> subDeptDataStream = FirebaseFirestore.instance
      .collection('subDepartments')
      .where('delete', isEqualTo: false)
      .snapshots();
}
