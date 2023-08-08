// import 'dart:html';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';

class AddLeadsWidget extends StatefulWidget {
  const AddLeadsWidget({Key? key}) : super(key: key);

  @override
  _AddLeadsWidgetState createState() => _AddLeadsWidgetState();
}

class _AddLeadsWidgetState extends State<AddLeadsWidget> {
  late TextEditingController branch;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List leadz = [];
  String selectedBranch = '';
  String filename = '';

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final file = result.files.first;
    _openFile(file);
    showUploadMessage(context, 'file uploaded successfully');
  }

  List<List<dynamic>> rowdetail=[];
  void _openFile(PlatformFile file) {
    print(file.name);
    filename = file.name;

    rowdetail =
        const CsvToListConverter().convert(String.fromCharCodes(file.bytes!));

    print(rowdetail.length);
    print(rowdetail);

    print('EXEL EXEL EXEL EXEL EXEL EXEL ');

    int i = 0;

    for (dynamic a in rowdetail) {
      print(a);
      if (a[0] == '' || a[0] == 'CLIENT') {
        continue;
      } else {
        if (a != null && a != '') {
          try {
            leadz.add({
              'name': a[0],
              'mobile': a[1].toString(),
              'email': a[2],
              'converted': false,
            });
          } catch (er) {
            leadz.add({
              'name': a[0],
              'mobile': a[1].toString(),
              'email': '',
              'converted': false,
            });
          }

          i++;
        }
      }
    }
    print(leadz);
    setState(() {});

    // var bytes = file.bytes;
    // excel.setDefaultSheet('sales');
    // for (var table in excel.tables.keys) {
    //   print(table);
    //   print('^^^^^^^^^^^^^^');
    //   print(excel.tables[table].rows);
    //   print('TABLE TABLE TABLE');
    //   for (var row in excel.tables[table].rows) {
    //     print(row);
    //     print('Row Row Row');
    //
    //     rowdetail.add(row);
    //   }
    // }
    // print(rowdetail);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    branch = TextEditingController();
    selectedBranch = currentBranchId;
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Add Leadz',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
              child: Material(
                color: Colors.transparent,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x44111417),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: CustomDropdown.search(
                                          hintText: 'Select branch',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          items: branches,
                                          controller: branch,
                                          // excludeSelected: false,
                                          onChanged: (text) {
                                            setState(() {
                                              selectedBranch =
                                                  branchNameMap[branch.text];
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          pickFile();
                                          print('Button pressed ...');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: 50,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.file_present_sharp),
                                                filename == ''
                                                    ? Text('Pick file')
                                                    : Text(filename),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  print(leadz.length);
                                  print(selectedBranch);

                                  if (selectedBranch != '' &&
                                      leadz.length != 0) {
                                    bool pressed = await alert(
                                        context, 'Do you want to upload');
                                    if (pressed) {
                                      FirebaseFirestore.instance
                                          .collection('leadList')
                                          .doc(selectedBranch)
                                          .update({
                                        'lead': FieldValue.arrayUnion(leadz),
                                      });
                                    }
                                  } else {
                                    selectedBranch == ''
                                        ? showUploadMessage(
                                            context, 'Please select branch')
                                        : showUploadMessage(
                                            context, 'please select file');
                                  }
                                },
                                text: 'Upload',
                                options: FFButtonOptions(
                                  width: 150,
                                  height: 49,
                                  color: Color(0xFF0F1113),
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFF1F4F8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Lead List',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    leadz.length == 0
                        ? Center(
                            child: Text(
                            'no data found....',
                            style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ))
                        : SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              horizontalMargin: 12,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Sl No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                DataColumn(
                                  label: Text("Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Mobile",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                              rows: List.generate(
                                leadz.length,
                                (index) {
                                  final lead = leadz[index];

                                  return DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(Text((index + 1).toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))),
                                      DataCell(Text(lead['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))),
                                      DataCell(Text(
                                          lead['email'].toString() ?? '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))),
                                      DataCell(Text(lead['mobile'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))),
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
                                                    'Do you want to remove');
                                                if (pressed) {
                                                  leadz.removeAt(index);
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      // DataCell(Text(fileInfo.size)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
