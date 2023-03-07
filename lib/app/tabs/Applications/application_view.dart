import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_erp/flutter_flow/upload_media.dart';
import 'package:multiple_select/Item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'ApplicationFormView.dart';

class ApplicationDetailsView extends StatefulWidget {
  final String id;
  final String appId;
  final int status;
  const ApplicationDetailsView({Key key, this.id, this.appId, this.status}) : super(key: key);

  @override
  State<ApplicationDetailsView> createState() => _ApplicationDetailsViewState();
}

class _ApplicationDetailsViewState extends State<ApplicationDetailsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List educationalDetails = [];
  List<Item> countryList = [];
  List<Item> courseList = [];

  List courses = [];
  List countries = [];
  List documentsName = [];
  DocumentSnapshot student;

  TextEditingController newDocument;
  TextEditingController status;
  Timestamp datePicked1;
  Timestamp datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  Map<String,dynamic> documents={};

  getCountry() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("country").get();
    for (var doc in data1.docs) {
      countryList.add(Item.build(
          value: doc.id, display: doc.get('name'), content: doc.get('name')));
    }
    setState(() {});
  }

  getCourse() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("course").get();
    for (var doc in data1.docs) {
      courseList.add(Item.build(
          value: doc.id, display: doc.get('name'), content: doc.get('name')));
    }
    setState(() {});
  }

  PlatformFile pickFile;
  UploadTask uploadTask;
  Future selectFile(String name)async{

    final result = await FilePicker.platform.pickFiles();
    if(result==null) return;

    pickFile=result.files.first;


    String ext=pickFile.name.split('.').last;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...',showLoading: true);

    uploadFileToFireBase(name,fileBytes,ext);

    setState(() {

    });

  }
  Future uploadFileToFireBase(String name, fileBytes,String ext) async {



    // final path='file/${pickFile.name}';
    // final file=File(pickFile.path);


    // final ref=FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);
    uploadTask= FirebaseStorage.instance.ref('uploads/${widget.id}-$name.$ext').putData(fileBytes);
    final snapshot= await  uploadTask.whenComplete((){});
    final urlDownlod = await  snapshot.ref.getDownloadURL();

    student.reference.update({
      'documents.$name':urlDownlod,
    });

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {

    });

  }


  _downloadFilesAsZIP(context, List<String> filenames, files) {

    var encoder = ZipEncoder();
    var archive = Archive();
    ArchiveFile archiveFiles = ArchiveFile.stream(
      filenames[0].toString(),
      files[0].lengthInBytes,
      files[0],
    );
    print(archiveFiles);
    archive.addFile(archiveFiles);
    var outputStream = OutputStream(
      byteOrder: LITTLE_ENDIAN,
    );
    var bytes = encoder.encode(archive,
        level: Deflate.BEST_COMPRESSION, output: outputStream);
    print(bytes);
    downloadFile("${widget.id}.zip", bytes);
  }
  downloadFile(String fileName, Uint8List bytes) {

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = fileName;
    html.document.body.children.add(anchor);

// download
    anchor.click();

// cleanup
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  getAllFiles(){
    var encoder = ZipFileEncoder();
    var archive = Archive();

    // encoder.zipDirectory(Directory(widget.id), filename: '${widget.id}.zip');

    // Manually create a zip of a directory and individual files.
    encoder.create('${widget.id}.zip');
    encoder.addDirectory(Directory(widget.id));
    for(String key in documents.keys){
      encoder.addFile(File.fromUri(documents[key]));
    }

    encoder.close();
    showUploadMessage(context, 'Downloaded....');
  }

  List applicationForms=[];
  getApplication()async{
    QuerySnapshot snap=await FirebaseFirestore.instance.collection('applicationForms')
        .where('candidateId',isEqualTo: widget.id).get();
    applicationForms=[];
    for(DocumentSnapshot snap in snap.docs){
      applicationForms.add({
        'name':snap.get('university'),
        'id':snap.id,
      });
    }
    
    if(mounted){
      setState(() {
        
      });
    }
  }

  _launchURL(String urls) async {

    var url = urls;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

  }


  //  downloadFiles(url)  async {
  //    final name =url.split('/').last;
  //
  //
  //    html(
  //
  //       href: url)
  //
  //       //  href:  "data:application/octet-stream;charset=utf-16le;base64,${file.readAsBytesSync()}");
  //   ..download= 'LEADZ.pdf'
  //   ..setAttribute('download', 'LEADZ.pdf')
  //
  //   ..click();
  // }


  Future<void> download( String url) async {
    html.window.open(url, "_blank");
  }
  Future openFile(String url)async{
    final name =url.split('/').last;
    // final file =await downloadFile(url,name);
    print(name);

    // if(file ==null) {
    //   return;
    // }
    //   if(kIsWeb){
    //     final List<int> bytes = file.path.codeUnits;
    //
    //     // downloadFiles(url);
    //   }
    //   else{
    //     // OpenFile.open(file.path);
    //
    //   }
    }


  // Future <File> downloadFile(String url,String name)async{
  //
  //   final appStorage= await getApplicationDocumentsDirectory();
  //   final file =File('${appStorage.path}/$name');
  //
  //   file.readAsBytesSync();
  //   try {
  //     final response = await Dio().get(
  //         url,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           receiveTimeout: 0,
  //
  //         ));
  //     final ref = file.openSync(mode: FileMode.write);
  //     ref.writeFromSync(response.data);
  //     await ref.close();
  //
  //     return file;
  //   }catch(e){
  //     print(e);
  //     return null;
  //   }
  //
  // }

  void getKeysAndValuesUsingEntries(Map map) {
    // Get all keys and values at the same time using entries
    print('----------');
    print('Get keys and values using entries:');
    map.entries.forEach((entry) {
      print('Key = ${entry.key} : Value = ${entry.value}');
    });
  }
  var key;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplication();
    status = TextEditingController();
    newDocument = TextEditingController();
    getCountry();
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF383838)),
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Color(0xFF090F13),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 5,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('candidates')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.white,
                child: Center(

                  child: Image.asset('assets/images/loading.gif'),
                ),
              );
            }
             student = snapshot.data;
            if (snapshot.data.exists) {
              educationalDetails = snapshot.data.get('educationalDetails');
              documents=snapshot.data.get('documents');
              documentsName=documents.keys.toList();

            }
            return !student.exists
                ? Center(
              child: Text('Loading...'),
            )
                : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          width: 86,
                                          height: 86,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: 
                                          // CachedNetworkImage(
                                          //   imageUrl:
                                          //   'data:image/png;base64,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',
                                          // )
                                        Image.asset('assets/images/aaa.png')
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        20, 8, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name : ' + student['name'] +' '+student['lastName'],
                                          style: FlutterFlowTheme.title3
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF090F13),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DOB : ' + student['dob'],
                                          style: FlutterFlowTheme.title3
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF090F13),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mobile : ' + student['phoneCode']+' '+student['mobile'],
                                          style: FlutterFlowTheme.title3
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF090F13),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Place : ' + student['place'],
                                          style: FlutterFlowTheme.title3
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF090F13),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email : ' + student['email'],
                                          style: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'IELTS Score : ' +
                                              student.get('ieltsScore'),
                                          style: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Enquiry Registered on : ' +
                                              student['date']
                                                  .toDate()
                                                  .toString()
                                                  .substring(0, 16),
                                          style: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF57636C),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  24, 12, 0, 12),
                                              child: Text(
                                                'Educational Details',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily:
                                                  'Lexend Deca',
                                                  color:
                                                  Color(0xFF090F13),
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(20, 0, 20, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color:
                                                  Color(0x3416202A),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 8, 8, 8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Qualification',
                                                        style:
                                                        FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: Color(
                                                              0xFF57636C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Mark',
                                                        style:
                                                        FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: Color(
                                                              0xFF57636C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Year',
                                                        style:
                                                        FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: Color(
                                                              0xFF57636C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: List.generate(
                                                        educationalDetails
                                                            .length,
                                                            (index) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Text(
                                                                  educationalDetails[
                                                                  index]
                                                                  [
                                                                  'qualification'],
                                                                  style: FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                    fontFamily:
                                                                    'Poppins',
                                                                    color: Color(
                                                                        0xFF57636C),
                                                                    fontSize:
                                                                    14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Text(
                                                                  educationalDetails[
                                                                  index]
                                                                  [
                                                                  'marks'],
                                                                  style: FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                    fontFamily:
                                                                    'Poppins',
                                                                    color: Color(
                                                                        0xFF57636C),
                                                                    fontSize:
                                                                    14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Text(
                                                                  educationalDetails[
                                                                  index]
                                                                  [
                                                                  'year'],
                                                                  style: FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                    fontFamily:
                                                                    'Poppins',
                                                                    color: Color(
                                                                        0xFF57636C),
                                                                    fontSize:
                                                                    14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(24, 12, 0, 12),
                                            child: Text(
                                              'Work Experience',
                                              style: FlutterFlowTheme
                                                  .bodyText1
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Color(0xFF090F13),
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(24, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              student.get('experience'),
                                              style: FlutterFlowTheme
                                                  .bodyText1
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Color(0xFF090F13),
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            flex: 2,
                            child: Material(
                              color: Colors.transparent,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                height:
                                MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: [

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
                                                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                                          child: TextFormField(
                                                            controller: newDocument,
                                                            obscureText: false,
                                                            decoration: InputDecoration(
                                                              labelText: 'New Document ',
                                                              hintText: 'Please Enter Document Name',
                                                              labelStyle: FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
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
                                                            style: FlutterFlowTheme
                                                                .bodyText1
                                                                .override(
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
                                                          onPressed: ()  async {

                                                        if(newDocument.text!=''){
                                                          bool pressed=await alert(context, '${newDocument.text} Upload ?');
                                                          if(pressed){
                                                            selectFile(newDocument.text);
                                                            setState(() {

                                                              newDocument.clear();

                                                            });
                                                          }
                                                        }else{
                                                          showUploadMessage(context, 'Please Enter Document Name');
                                                        }




                                                          },
                                                          text: 'Upload',
                                                          options: FFButtonOptions(
                                                            width: 100,
                                                            height: 40,
                                                            color: Color(0xFF4B39EF),
                                                            textStyle: FlutterFlowTheme
                                                                .subtitle2
                                                                .override(
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


                                        Text('Document Download',style: GoogleFonts.roboto(
                                          fontSize: 22
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            children: List.generate(documentsName.length, (index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(width: 0.1)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(documentsName[index],style: GoogleFonts.roboto(
                                                            fontSize: 14,fontWeight: FontWeight.bold
                                                        ),),
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderColor: Colors.transparent,
                                                        borderRadius: 8,
                                                        borderWidth: 1,
                                                        buttonSize: 40,
                                                        fillColor: Colors.green,
                                                        icon: Icon(
                                                          Icons.download_sharp,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        onPressed: ()  {
                                                          _launchURL(documents[documentsName[index]]);

                                                        },
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );

                                            })
                                          ),
                                        ),
                                        Text('Application Forms',style: GoogleFonts.roboto(
                                            fontSize: 22
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 0.1)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(widget.appId,style: GoogleFonts.roboto(
                                                              fontSize: 14,fontWeight: FontWeight.bold
                                                          ),),
                                                        ),
                                                        InkWell(
                                                          onTap: (){
                                                            getAllFiles();



                                                          },
                                                          child: Container(
                                                            height: 45,

                                                            decoration: BoxDecoration(
                                                              color: Colors.green.shade600,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 4,
                                                                  color:
                                                                  Color(0x32171717),
                                                                  offset: Offset(0, 2),
                                                                )
                                                              ],
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  30),
                                                              shape: BoxShape.rectangle,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8, 0, 8, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize.max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [

                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(8,
                                                                        5, 8, 5),
                                                                    child: Text(
                                                                      'VIEW',
                                                                      style:
                                                                      FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                        'Lexend Deca',
                                                                        color:
                                                                        Colors.white,
                                                                        fontSize: 10,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .normal,
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
                                                  ),
                                                )
                                              ]
                                          ),
                                        ),
                                        
                                        widget.status==1?Container():

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 60),
                                          child: FFButtonWidget(
                                            onPressed: ()  async {

                                              bool pressed=await alert(context, 'Application Submitted...');

                                              if(pressed){
                                                FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                    'status')
                                                    .add({
                                                  'date':
                                                  DateTime.now(),
                                                  'next':
                                                  'Verification Process',
                                                  'status':
                                                  'Application Submitted',
                                                  'eId': widget
                                                      .id,
                                                  'userId':
                                                  currentUserUid,
                                                  'comments':
                                                  'Submitted on ${dateTimeFormat('yMMM', DateTime.now())}',
                                                });
                                                FirebaseFirestore.instance.collection('applicationForms').doc(widget.appId)
                                                .update({
                                                  'status':1,
                                                  'submittedDate':DateTime.now(),
                                                  'submittedBy':currentUserUid,
                                                });

                                                Navigator.pop(context);
                                                showUploadMessage(context, 'Application Submitted');
                                              }


                                            },
                                            text: 'Application Submitted',
                                            options: FFButtonOptions(
                                              width: 350,
                                              height: 60,
                                              color: Colors.teal,
                                              textStyle: FlutterFlowTheme.subtitle2.override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              elevation: 2,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 30,
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
