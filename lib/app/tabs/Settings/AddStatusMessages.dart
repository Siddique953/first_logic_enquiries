

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../flutter_flow/upload_media.dart';

class CreateStatusWidget extends StatefulWidget {
  const CreateStatusWidget({Key? key}) : super(key: key);

  @override
  _CreateStatusWidgetState createState() => _CreateStatusWidgetState();
}

class _CreateStatusWidgetState extends State<CreateStatusWidget> {
  late TextEditingController status;
  late TextEditingController eStatus;
  late String type;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    status = TextEditingController();
    eStatus = TextEditingController();
  }
  bool edit =false;
  int  editIndex =0;
  List statusList=[];
  String statusId='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 20, 0, 0),
              child: Text(
                'Status Managements',
                style: FlutterFlowTheme.title1.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFF0F1113),
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          edit==false?
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300,
                height: 60,

                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x4D101213),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: FlutterFlowDropDown(
                    initialOption: type ?? 'Application',
                    options: [
                      'Application',
                      'Visa',
                      'Common',
                    ],
                    onChanged: (val) => setState(() {
                      type = val;
                    }
                    ),
                    width: 150,
                    height: 50,
                    textStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    hintText: 'Please select...',
                    fillColor: Colors.white,
                    elevation: 0,
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                    borderRadius: 8,
                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 10, 4),
                    hidesUnderline: true,
                  ),
                ),
              ),

              Container(
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
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                          child: TextFormField(
                            controller: status,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Please Enter Status ',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF7C8791),
                                fontSize: 12,
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
                            style: FlutterFlowTheme
                                .bodyText1
                                .override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF090F13),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: FFButtonWidget(
                          onPressed: () async {

                            if(status.text!=''&&type!=null){
                              bool pressed=await alert(context, 'Do you want Add Status');
                              if(pressed){
                                FirebaseFirestore.instance.collection('statusManagement')
                                    .add({
                                  'status':status.text,
                                  'type':type,
                                  'date':DateTime.now(),
                                });
                                showUploadMessage(context, 'New Status added...');
                                setState(() {
                                  status.clear();
                                });
                              }
                            }else{
                              showUploadMessage(context, 'Please Enter Status...');

                            }


                          },
                          text: 'Add',
                          options: FFButtonOptions(
                            width: 100,
                            height: 40,
                            color: Color(0xFF4B39EF),
                            textStyle: FlutterFlowTheme
                                .subtitle2
                                .override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
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
            ],
          ):
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 60,

                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x4D101213),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: FlutterFlowDropDown(
                    initialOption: type ?? 'Application',
                    options: [
                      'Application',
                      'Visa',
                      'Common',
                    ],
                    onChanged: (val) => setState(() {
                      type = val;
                    }
                    ),
                    width: 150,
                    height: 50,
                    textStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                        fontWeight: FontWeight.bold

                    ),
                    hintText: 'Please select...',
                    fillColor: Colors.white,
                    elevation: 0,
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                    borderRadius: 8,
                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 10, 4),
                    hidesUnderline: true,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                child: Container(
                  width: 500,
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
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                            child: TextFormField(
                              controller: eStatus,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Please Enter Status ',
                                labelStyle: FlutterFlowTheme
                                    .bodyText2
                                    .override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF7C8791),
                                  fontSize: 12,
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
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF090F13),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                          child: FFButtonWidget(
                            onPressed: () async {

                              if(eStatus.text!=''){
                                bool pressed=await alert(context, 'Do you want Update Status');
                                if(pressed){


                                  FirebaseFirestore.instance.collection('statusManagement').doc(statusId)
                                      .update({
                                    'status':eStatus.text,
                                    'type':type,
                                    'date':DateTime.now(),
                                  });
                                  showUploadMessage(context, 'Status Updated...');
                                  setState(() {
                                    edit=false;
                                    eStatus.clear();
                                  });
                                }
                              }else{
                                showUploadMessage(context, 'Please Enter Status...');

                              }


                           },
                            text: 'Update',
                            options: FFButtonOptions(
                              width: 100,
                              height: 40,
                              color: Color(0xFF4B39EF),
                              textStyle: FlutterFlowTheme
                                  .subtitle2
                                  .override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.white,
                  borderRadius: 8,
                  borderWidth: 2,
                  buttonSize: 40,
                  fillColor: Colors.red,
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: ()  {


                    edit=false;
                    eStatus.clear();
                    setState(() {

                    });

                      showUploadMessage(context, 'Section was Cancelled...');


                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 5, 0, 5),
            child: Text(
              'Available Status',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF4E5358),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('statusManagement')
              .orderBy('date',descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                var data=snapshot.data!.docs;
                // statusList=data['status'];
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                    itemBuilder: (buildContext,int index){
                    final status=data[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(

                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Container(
                            width: 800,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x2F1D2429),
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.local_police_rounded,
                                    color: Color(0xFF4B39EF),
                                    size: 30,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            status['type'],
                                            style: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF101213),
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            status['status'],
                                            style: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF101213),
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Color(0xFFAAAEB6),
                                      borderRadius: 8,
                                      borderWidth: 2,
                                      buttonSize: 40,
                                      icon: FaIcon(
                                        FontAwesomeIcons.solidEdit,
                                        color: Color(0xFF57636C),
                                        size: 20,
                                      ),
                                      onPressed: () {

                                        edit=true;
                                        eStatus.text=status['status'];
                                        type=status['type'];
                                        statusId=status.id;
                                        editIndex=index;
                                        setState(() {

                                        });

                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.white,
                                      borderRadius: 8,
                                      borderWidth: 2,
                                      buttonSize: 40,
                                      fillColor: Colors.red,
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        bool pressed=await alert(context, 'Do you want to Delete Status');
                                        if(pressed){
                                          edit=false;

                                          // data.reference.update({
                                          //   'status':FieldValue.arrayRemove([status])
                                          // });
                                          showUploadMessage(context, 'Status Deleted...');
                                        }

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              }
            ),
          ),
        ],
      ),
    );
  }
}
