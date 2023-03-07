

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../backend/firebase_storage/storage.dart';
import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import 'editBanner.dart';
import 'editCategoryBanner.dart';
import 'editFeed.dart';
import 'editFeedBottomBanner.dart';
import 'editWeeklyFeed.dart';

class UploadFeedWidget extends StatefulWidget {
  const UploadFeedWidget({Key key}) : super(key: key);

  @override
  _UploadFeedWidgetState createState() => _UploadFeedWidgetState();
}

class _UploadFeedWidgetState extends State<UploadFeedWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController video;
  TextEditingController name;
  TextEditingController categoryBanner;
  String uploadedFileUrl1='';
  String uploadedFileUrl2='';
  String uploadedFileUrl3='';
  String selectedCategory = '';
  String dropDownValue ;

  final List<DropdownMenuItem> fetchedCategories = <DropdownMenuItem>[];

  getCategory() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("category").get();
    for (var doc in data1.docs) {
      // Map<String , dynamic> data = doc.data();

      fetchedCategories.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('categoryId'),
      ));
    }
  }
  @override
  void initState() {
    super.initState();
    if (fetchedCategories.isEmpty) {
      getCategory().then((value) {
        setState(() {});
      });
    }
    video=TextEditingController();
    name=TextEditingController();
    categoryBanner=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Upload Feeds',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 800,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(

                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text('Video Feed',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                FFButtonWidget(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditFeedWidget()));
                                  },
                                  text: 'Edit Feed',
                                  icon: Icon(
                                    Icons.mode_edit,
                                    size: 13,
                                  ),
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 35,
                                    color: secondaryColor,
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                uploadedFileUrl1==''?
                                Text(
                                    'Please Upload Feed',
                                    style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500)
                                ):
                                Expanded(
                                  child: TextFormField(
                                    controller: video,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF232323),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF232323),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 100,),
                                FFButtonWidget(
                                  onPressed: () async {

                                    final selectedMedia = await selectMedia(
                                      isVideo: true,
                                      maxWidth: 1080.00,
                                      maxHeight: 1320.00,
                                    );
                                    if (selectedMedia != null &&
                                        validateFileFormat(
                                            selectedMedia.storagePath, context)) {
                                      showUploadMessage(context, 'Uploading file...',
                                          showLoading: true);
                                      final downloadUrl = await uploadData(
                                          selectedMedia.storagePath,
                                          selectedMedia.bytes);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != null) {
                                        setState(
                                                () {
                                              uploadedFileUrl1 = downloadUrl;
                                              video.text= uploadedFileUrl1;
                                              print(uploadedFileUrl1);
                                            } );
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                      }
                                    }
                                  },
                                  text: uploadedFileUrl1==''?'Upload Feed':'Change Feed ',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 40,
                                    color: secondaryColor,
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 12,
                                  ),
                                ),
                                SizedBox(width: 20,),
                                uploadedFileUrl1==''?Container():
                                FFButtonWidget(
                                  onPressed: () async {
                                    FirebaseFirestore.instance.collection('feed').add({
                                      'mainFeed':uploadedFileUrl1,
                                      'likes':[],

                                    }).then((value) {
                                      value.update({
                                        'id':value.id
                                      });
                                    });
                                    showUploadMessage(context, 'Video Feed Uploaded');
                                    setState(() {
                                      video.text='';
                                      uploadedFileUrl1='';
                                    });
                                  },
                                  text: 'Upload Video Feed ',
                                  options: FFButtonOptions(
                                    width: 220,
                                    height: 40,
                                    color: secondaryColor,
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 800,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(

                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text('Feed Bottom Banner',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                        FFButtonWidget(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditFeedBannerWidget()));
                                          },
                                          text: 'Edit Banner',
                                          icon: Icon(
                                            Icons.mode_edit,
                                            size: 13,
                                          ),
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 35,
                                            color: secondaryColor,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        uploadedFileUrl3==''?
                                        Text(
                                            'Please Upload Feed Bottom Banner',
                                            style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500)
                                        ):
                                        Expanded(
                                          child: TextFormField(
                                            controller: name,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF232323),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight: Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF232323),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight: Radius.circular(4.0),
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            style: FlutterFlowTheme.bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 100,),
                                        FFButtonWidget(
                                          onPressed: () async {

                                            final selectedMedia = await selectMedia(
                                              maxWidth: 1080.00,
                                              maxHeight: 1320.00,
                                            );
                                            if (selectedMedia != null &&
                                                validateFileFormat(
                                                    selectedMedia.storagePath, context)) {
                                              showUploadMessage(context, 'Uploading file...',
                                                  showLoading: true);
                                              final downloadUrl = await uploadData(
                                                  selectedMedia.storagePath,
                                                  selectedMedia.bytes);
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              if (downloadUrl != null) {
                                                setState(
                                                        () {
                                                      uploadedFileUrl3 = downloadUrl;
                                                      name.text= uploadedFileUrl3;
                                                    } );
                                                showUploadMessage(context, 'Success!');
                                              } else {
                                                showUploadMessage(
                                                    context, 'Failed to upload media');
                                              }
                                            }
                                          },
                                          text: uploadedFileUrl1==''?'Upload Image':'Change Image ',
                                          options: FFButtonOptions(
                                            width: 130,
                                            height: 40,
                                            color: secondaryColor,
                                            textStyle: FlutterFlowTheme.subtitle2.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 12,
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        uploadedFileUrl3==''?Container():
                                        FFButtonWidget(
                                          onPressed: () async {
                                            FirebaseFirestore.instance.collection('banner').doc('banner').update({
                                              'bottomFeed':FieldValue.arrayUnion([uploadedFileUrl3]),
                                            });
                                            showUploadMessage(context, 'Feed Bottom Banner Uploaded');
                                            setState(() {
                                              name.text='';
                                              uploadedFileUrl3='';
                                            });
                                          },
                                          text: 'Upload Feed Bottom Banner ',
                                          options: FFButtonOptions(
                                            width: 220,
                                            height: 40,
                                            color: secondaryColor,
                                            textStyle: FlutterFlowTheme.subtitle2.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
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

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 800,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Weekly Banner',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                FFButtonWidget(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditWeeklyBannerWidget()));
                                  },
                                  text: 'Edit Banner',
                                  icon: Icon(
                                    Icons.mode_edit,
                                    size: 13,
                                  ),
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 35,
                                    color: secondaryColor,
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                uploadedFileUrl2==''?
                                Text(
                                    'Please Upload Weekly Banner',
                                    style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500)
                                ):
                                Expanded(
                                  child: TextFormField(
                                    controller: categoryBanner,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF232323),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF232323),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 100,),
                                FFButtonWidget(
                                  onPressed: () async {

                                    final selectedMedia = await selectMedia(
                                      maxWidth: 1080.00,
                                      maxHeight: 1320.00,
                                    );
                                    if (selectedMedia != null &&
                                        validateFileFormat(
                                            selectedMedia.storagePath, context)) {
                                      showUploadMessage(context, 'Uploading file...',
                                          showLoading: true);
                                      final downloadUrl = await uploadData(
                                          selectedMedia.storagePath,
                                          selectedMedia.bytes);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != null) {
                                        setState(
                                                () {
                                              uploadedFileUrl2 = downloadUrl;
                                              categoryBanner.text= uploadedFileUrl2;
                                            } );
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                      }
                                    }
                                  },
                                  text: uploadedFileUrl2==''?'Upload Image':'Change Image ',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 40,
                                    color: secondaryColor,
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 12,
                                  ),
                                ),
                                SizedBox(width: 20,),

                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Select Week',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                              SizedBox(width: 20,),
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
                              )
                            ],
                          ),
                          uploadedFileUrl2==''?Container():
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    if(uploadedFileUrl2!=''){

                                      FirebaseFirestore.instance.collection('weeklyFeed').doc(dropDownValue).set({
                                        'imageUrl':uploadedFileUrl2,
                                        'week':dropDownValue,
                                      });
                                      showUploadMessage(context, 'Weekly Banner Uploaded..');
                                      setState(() {
                                        categoryBanner.text='';
                                        uploadedFileUrl2='';
                                      });
                                    }else{
                                    showUploadMessage(context, 'Please Upload Banner');
                                    }
                                  },
                                  text: 'Upload Weekly Banner ',
                                  options: FFButtonOptions(
                                    width: 220,
                                    height: 40,
                                    color: secondaryColor,
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
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

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
