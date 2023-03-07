import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';


class EditWeeklyBannerWidget extends StatefulWidget {
  const EditWeeklyBannerWidget({Key key}) : super(key: key);

  @override
  _EditWeeklyBannerWidgetState createState() => _EditWeeklyBannerWidgetState();
}

class _EditWeeklyBannerWidgetState extends State<EditWeeklyBannerWidget> {
  String dropDownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Weekly Banner',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('weeklyFeed').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            var data=snapshot.data.docs;
            return data.length==0?Center(child: Text('No Weekly Banner Available')):Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  dropDownValue=data[index]['week'];
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CachedNetworkImage(
                            imageUrl: data[index]['imageUrl'],
                            width: 250,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          FlutterFlowDropDown(
                            initialOption: dropDownValue ??= '5',
                            options: [
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10',
                              '11',
                              '12',
                              '13',
                              '14',
                              '15',
                              '16',
                              '17',
                              '18',
                              '19',
                              '20',
                              '21',
                              '22',
                              '23',
                              '24',
                              '25',
                              '26',
                              '27',
                              '28',
                              '29',
                              '30',
                              '31',
                              '32',
                              '33',
                              '34',
                              '35',
                              '36',
                              '37',
                              '38',
                              '39',
                              '40'
                            ].toList(),
                            onChanged: (val) => setState(() => dropDownValue = val),
                            width: 180,
                            height: 50,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            icon: FaIcon(
                              FontAwesomeIcons.calendar,
                            ),
                            fillColor: Colors.white,
                            elevation: 2,
                            borderColor: Color(0xFF252525),
                            borderWidth: 0,
                            borderRadius: 0,
                            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            hidesUnderline: true,
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Delete Weekly Feed'),
                                    content: Text('Do you want to Delete Feed ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          DocumentSnapshot delete =data[0];
                                          delete.reference.delete();
                                          Navigator.pop(alertDialogContext);
                                          Navigator.pop(context);

                                        },
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            text: 'Delete',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: Color(0xFFF10202),
                              textStyle: FlutterFlowTheme.subtitle2.override(
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
                    ),
                  );
                },

              ),
            );
          }
        ),
      ),
    );
  }
}
