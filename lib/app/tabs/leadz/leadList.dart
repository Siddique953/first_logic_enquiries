import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import '../Enquiry/AddEnquiry.dart';

class LeadList extends StatefulWidget {
  const LeadList({Key key}) : super(key: key);

  @override
  State<LeadList> createState() => _LeadListState();
}

class _LeadListState extends State<LeadList> {
  TextEditingController branch;
  String selectedBranch = '';

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
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 15, 30, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                    child: Text(
                      "Lead List",
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  currentUserRole == 'Super Admin'
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: CustomDropdown.search(
                            hintText: 'Select branch',
                            hintStyle: TextStyle(color: Colors.black),
                            items: branches,
                            controller: branch,
                            // excludeSelected: false,
                            onChanged: (text) {
                              setState(() {
                                selectedBranch = branchNameMap[branch.text];
                              });
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('leadList')
                            .doc(selectedBranch)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var data = snapshot.data;
                          List LeadList = data['lead'];
                          List leadz = [];
                          for (var item in LeadList) {
                            if (item['converted'] == false) {
                              leadz.add(item);
                            }
                          }

                          return Column(
                            children: [
                              leadz.length == 0
                                  ? Center(
                                      child: Text(
                                      'No Data Found....',
                                      style: FlutterFlowTheme.bodyText2
                                          .override(
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                        rows: List.generate(
                                          leadz.length,
                                          (index) {
                                            final lead = leadz[index];

                                            return DataRow(
                                              color: index.isOdd
                                                  ? MaterialStateProperty.all(
                                                      Colors.blueGrey.shade50
                                                          .withOpacity(0.7))
                                                  : MaterialStateProperty.all(
                                                      Colors.blueGrey.shade50),
                                              cells: [
                                                DataCell(Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12))),
                                                DataCell(Text(lead['name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12))),
                                                DataCell(Text(
                                                    lead['email'].toString() ??
                                                        '',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12))),
                                                DataCell(Text(lead['mobile'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12))),
                                                DataCell(
                                                  Row(
                                                    children: [
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          bool pressed =
                                                              await alert(
                                                                  context,
                                                                  'Move to Enquiry ?');
                                                          if (pressed) {
                                                            lead['converted'] =
                                                                true;

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddEnquiryWidget(
                                                                              name: lead['name'],
                                                                              mobile: lead['mobile'],
                                                                              email: lead['email'].toString(),
                                                                              lead: true,
                                                                            )));

                                                            data.reference
                                                                .update({
                                                              'lead': leadz,
                                                            });
                                                          }

                                                          showUploadMessage(
                                                              context,
                                                              'lead moved to enquiry successfully');
                                                        },
                                                        text: 'Move',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 80,
                                                          height: 30,
                                                          color: Colors.teal,
                                                          textStyle: FlutterFlowTheme
                                                              .subtitle2
                                                              .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
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
                                    ),
                            ],
                          );
                        }),
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
