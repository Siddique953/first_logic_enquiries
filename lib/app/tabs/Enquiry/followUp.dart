import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';

class FollowUpPage extends StatefulWidget {
  const FollowUpPage({Key? key}) : super(key: key);

  @override
  _FollowUpPageState createState() => _FollowUpPageState();
}

class _FollowUpPageState extends State<FollowUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Map<String,dynamic>EnqIdToName={};
  // getName(){
  //   FirebaseFirestore.instance.collection('enquiry').snapshots().listen((event) {
  //     for(DocumentSnapshot doc in event.docs){
  //
  //
  //       EnqIdToName[doc.id]=doc.get('name');
  //     }
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('>>>>>>>>>>>>>>>> $currentBranchId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'FollowUp List',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('followUp')
                      .where('branch', isEqualTo: currentBranchId)
                      .where('done', isEqualTo: false)
                      .orderBy('next', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = snapshot.data!.docs;
                    return data.length == 0
                        ? LottieBuilder.network(
                            'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                            height: 500,
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              horizontalMargin: 10,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Enquiry Id",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                DataColumn(
                                  label: Text("Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Project Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("FollowUp Detail",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Next FollowUp Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Assignee",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                DataColumn(
                                  label: Text("Action",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ],
                              rows: List.generate(
                                data.length,
                                (index) {
                                  String eId = data[index]['eId'];
                                  Timestamp date = data[index]['date'];
                                  String dId = data[index]['dId'];
                                  String status = data[index]['followUpDetail'];
                                  Timestamp followUpdate = data[index]['next'];
                                  String assignee = data[index]['assignee'];

                                  return DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(Text(
                                        eId,
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        dateTimeFormat(
                                            'd-MMM-y', date.toDate()),
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('enquiry')
                                              .doc(eId)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text('');
                                            }
                                            var userName = snapshot.data
                                                !.get('projectTopic');
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.10,
                                              child: Text(
                                                userName ?? '',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          })),
                                      DataCell(Text(
                                        status,
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        dateTimeFormat(
                                            'd-MMM-y', followUpdate.toDate()),
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        assignee,
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),

                                      DataCell(
                                        Row(
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () async {
                                                print(eId);
                                                bool proceed = await alert(
                                                    context,
                                                    'FollowUp Completed?');

                                                if (proceed) {
                                                  FirebaseFirestore.instance
                                                      .collection('followUp')
                                                      .doc(dId)
                                                      .update({
                                                    'done': true,
                                                  }).then((value) {
                                                    showUploadMessage(context,
                                                        '$eId Follow up completed');
                                                  }).catchError((e) {
                                                    showUploadMessage(context,
                                                        'Updation Failed');
                                                    print(e);
                                                  });
                                                }
                                              },
                                              text: 'Done',
                                              options: FFButtonOptions(
                                                width: 90,
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

                                      // DataCell(Text(fileInfo.size)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
