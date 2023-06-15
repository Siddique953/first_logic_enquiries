import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/upload_media.dart';

String mailSubject='';
String mailBody='';
List mailAttachments=[];

class SendMailToEmployees extends StatefulWidget {
  final TabController _tabController;
  const SendMailToEmployees({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<SendMailToEmployees> createState() => _SendMailToEmployeesState();
}

class _SendMailToEmployeesState extends State<SendMailToEmployees> {

  PlatformFile pickFile;
  UploadTask uploadTask;
  bool sendToHover=false;

  /// SEND MAIL

  TextEditingController subject = TextEditingController();
  TextEditingController bodyOfMail = TextEditingController();
  List attachments = [];

  double width = 0;
  double height = 0;
  @override
  Widget build(BuildContext context) {


    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget._tabController.animateTo(5);
            });
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Compose E-Mail',
          style: TextStyle(color: Colors.white, fontSize: width * 0.02),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Color(0xff231F20),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.2, bottom: height * 0.2),
                child: Material(
                  elevation: 10,
                  child: Container(
                    width: width * 0.6,
                    // height: height * 0.75,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.all(width * 0.005),
                            child: Text('Compose Mail',
                              style:TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),

                          /// MAIL SUBJECT
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(
                                5, 10, 30, 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 350,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          8),
                                      border: Border.all(
                                        color:
                                        Color(0xFFE6E6E6),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          16, 0, 0, 0),
                                      child: TextFormField(
                                        controller: subject,
                                        obscureText: false,
                                        decoration:
                                        InputDecoration(
                                          labelText: 'Subject',
                                          labelStyle: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                              fontFamily:
                                              'Montserrat',
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              fontSize: 12),
                                          hintText:
                                          'Please Enter Mail Subject',
                                          hintStyle: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                              fontFamily:
                                              'Montserrat',
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              fontSize: 12),
                                          enabledBorder:
                                          UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color: Colors
                                                  .transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                              topLeft: Radius
                                                  .circular(
                                                  4.0),
                                              topRight: Radius
                                                  .circular(
                                                  4.0),
                                            ),
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color: Colors
                                                  .transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                              topLeft: Radius
                                                  .circular(
                                                  4.0),
                                              topRight: Radius
                                                  .circular(
                                                  4.0),
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                            fontFamily:
                                            'Montserrat',
                                            color: Color(
                                                0xFF8B97A2),
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///MAIL BODY
                          Padding(
                            padding:
                            EdgeInsetsDirectional.all(8.0),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 440,
                                    height: 450,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          8),
                                      border: Border.all(
                                        color:
                                        Color(0xFFE6E6E6),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          16, 0, 0, 0),
                                      child: TextFormField(
                                        controller: bodyOfMail,
                                        obscureText: false,
                                        maxLines: 100,
                                        textAlign: TextAlign.start,

                                        decoration:
                                        InputDecoration(
                                          labelText:
                                          'Body',
                                          labelStyle: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                              fontFamily:
                                              'Montserrat',
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              fontSize: 12),
                                          hintText:
                                          'Enter Body of your E-Mail',
                                          hintStyle: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                              fontFamily:
                                              'Montserrat',
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              fontSize: 12),
                                          enabledBorder:
                                          UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color: Colors
                                                  .transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                              topLeft: Radius
                                                  .circular(
                                                  4.0),
                                              topRight: Radius
                                                  .circular(
                                                  4.0),
                                            ),
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color: Colors
                                                  .transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                              topLeft: Radius
                                                  .circular(
                                                  4.0),
                                              topRight: Radius
                                                  .circular(
                                                  4.0),
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                            fontFamily:
                                            'Montserrat',
                                            color: Color(
                                                0xFF8B97A2),
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: attachments.length+1,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                // childAspectRatio: 1,
                              ),
                              itemBuilder:
                                  (BuildContext context,
                                  int index) {
                                return index ==
                                    attachments.length
                                    ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      selectFileToUpload(
                                          context, 'mail');
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration:
                                      BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            8),
                                        border: Border.all(
                                          color: Color(
                                              0xFFE6E6E6),
                                        ),
                                      ),
                                      child:
                                      Icon(Icons.add),
                                    ),
                                  ),
                                )
                                    : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onLongPress: ()async{
                                      bool pressed= await alert(context,'Do you want to remove this file ?');

                                      if(pressed){
                                        attachments.removeAt(index);
                                        setState(() {

                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration:
                                      BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius
                                            .circular(8),
                                        border: Border.all(
                                          color: Color(
                                              0xFFE6E6E6),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            height: 160,
                                            width: 200,
                                            decoration:
                                            BoxDecoration(
                                              color: Colors
                                                  .white,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  8),
                                              border:
                                              Border.all(
                                                color: Color(
                                                    0xFFE6E6E6),
                                              ),
                                            ),
                                            child: Icon(Icons
                                                .file_present_outlined),
                                          ),
                                          Center(
                                            child: Text(
                                              attachments[
                                              index]['filename'],overflow: TextOverflow.fade,),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [

                              Row(
                                children: [

                                  GestureDetector(
                                    onTap: () {
                                      // String html = '<html>'
                                      //     '<head>'
                                      //     '<meta name="viewport" content="width=device-width, initial-scale=1">'
                                      //     '<link href="https://fonts.googleapis.com/css2?family=Gotham:wght@400;700&display=swap" rel="stylesheet">'
                                      //     '<style>'
                                      //     'body {'
                                      //     'font-family: "Gotham", sans-serif;'
                                      //     '}'
                                      //     '.header {'
                                      //     'background-color: #0058ff;'
                                      //     'color: #fff;'
                                      //     'text-align: center;'
                                      //     'padding: 10px;'
                                      //     'display: flex;'
                                      //     'align-items: center;'
                                      //     ' }'
                                      //     '.header img {'
                                      //     ' margin-right: 20px;'
                                      //     '}'
                                      //     '.container {'
                                      //     'width: 80%;'
                                      //     'margin: 0 auto;'
                                      //     'background-color: #f2f2f2;'
                                      //     'padding: 20px;'
                                      //     ' }'
                                      //     'table {'
                                      //     'width: 100%;'
                                      //     'border-collapse: collapse;'
                                      //     'margin-top: 20px;'
                                      //     '}'
                                      //     'th,'
                                      //     'td {'
                                      //     'border: 1px solid #333;'
                                      //     'padding: 10px;'
                                      //     '}'
                                      //     'th {'
                                      //     'background-color: #0058ff;'
                                      //     ' color: #fff;'
                                      //     '}'
                                      //     '@media (max-width: 767px) {'
                                      //     '.container {'
                                      //     'width: 90%;'
                                      //     '}'
                                      //     'th,'
                                      //     'td {'
                                      //     'font-size: 14px;'
                                      //     ' }'
                                      //     ' }'
                                      //     '</style>'
                                      //     ' </head>'
                                      //     '<body>'
                                      //     '<div class="header">'
                                      //     ' <img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/webicon-01.png?alt=media&token=424afef7-b36f-47e0-aa12-ec5dd178085b" style="width:50px;height:50px;" alt="Company Logo" />'
                                      //     '<h3>First Logic Meta Lab Pvt. Ltd</h3>'
                                      //     '</div>'
                                      //     '<div class="container">'
                                      //     '<p>'+
                                      //     bodyOfMail.text +
                                      //     '</p>'
                                      //
                                      //         '</div>'
                                      //         ' </body>'
                                      //         '</html>';
                                      //
                                      // FirebaseFirestore.instance.collection('mail').add({
                                      //   'html': html,
                                      //   'status': subject.text,
                                      //   'att': attachments[0],
                                      //   // 'emailList': [employeeDetails.email],
                                      //   'date':FieldValue.serverTimestamp()
                                      // });

                                      if(bodyOfMail.text.isNotEmpty&&subject.text.isNotEmpty){
                                        mailBody=bodyOfMail.text;
                                        mailSubject=subject.text;
                                        mailAttachments=attachments;
                                        widget._tabController.animateTo(36);
                                      } else {
                                       subject.text.isEmpty?
                                       showUploadMessage(context, 'Enter Mail Subject'):
                                       showUploadMessage(context, 'Enter Mail Body');
                                      }

                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors
                                          .click,
                                      onEnter: (v) {
                                        sendToHover = true;
                                        setState(() {});
                                      },
                                      onExit: (v) {
                                        sendToHover = false;
                                        setState(() {});
                                      },
                                      child: Material(
                                        color:
                                        Colors.transparent,
                                        elevation: sendToHover
                                            ? 10
                                            : 0,
                                        child: Container(
                                          width: 120,
                                          height: 30,
                                          color:
                                          Colors.blueAccent,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Icon(
                                                  Icons.send,
                                                  color: Colors
                                                      .white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'SEND TO',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  //PICK FILE
  Future selectFileToUpload(BuildContext context, String type) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickFile = result.files.first;
    String name = pickFile.name;

    String ext = pickFile.name.split('.').last;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...', showLoading: true);

    uploadFileToFireBase(name, fileBytes, ext, context, type);

    setState(() {});
  }

  //UPDATE DOCUMENT DATE
  Future uploadFileToFireBase(String name, fileBytes, String ext,
      BuildContext context, String type) async {
    String ref = '';
    String urlDownload = '';

      ref =
      'employees/mailDocs/Group/${DateFormat('dd - MMM - yyyy')}/$name.$ext';

    uploadTask = FirebaseStorage.instance.ref(ref).putData(fileBytes);
    final snapshot = await uploadTask.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {

        attachments.add({
          'filename':name,
          'path':urlDownload,
        });

    });
  }
}
