

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

class LeadsWidget extends StatefulWidget {
  const LeadsWidget({Key? key}) : super(key: key);

  @override
  _LeadsWidgetState createState() => _LeadsWidgetState();
}

class _LeadsWidgetState extends State<LeadsWidget> {
  late String dropDownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List <String> branches=[];
  Map<String,dynamic> branchId={};
  getBranch()async{
    QuerySnapshot snap =await FirebaseFirestore.instance.collection('branch').get();
    for(DocumentSnapshot doc in snap.docs){
      branchId[doc.get('name')]=doc.id;
      branches.add(doc.get('name'));
    }
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBranch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: FlutterFlowDropDown(
                                    initialOption: dropDownValue??'',
                                    options: branches,
                                    onChanged: (val) =>
                                        setState(() => dropDownValue = val),
                                    width: 250,
                                    height: 50,
                                    textStyle: FlutterFlowTheme
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please select...',
                                    fillColor: Colors.white,
                                    elevation: 2,
                                    borderColor: Colors.black,
                                    borderWidth: 0,
                                    borderRadius: 0,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        12, 4, 12, 4),
                                    hidesUnderline: true,
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                  },
                                  text: 'Choose',
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 50,
                                    color: Color(0xFF0F1113),
                                    textStyle: FlutterFlowTheme
                                        .subtitle2
                                        .override(
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
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () {
                                        },
                                        text: 'Upload',
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 50,
                                          color: Color(0xFF0F1113),
                                          textStyle:
                                          FlutterFlowTheme
                                              .subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFF1F4F8),
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.normal,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
