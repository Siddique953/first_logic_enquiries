import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_erp/backend/firebase_storage/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import 'editBanner.dart';
import 'editCategoryBanner.dart';

class FeedBottomBanner extends StatefulWidget {
  const FeedBottomBanner({Key key}) : super(key: key);

  @override
  _FeedBottomBannerWidgetState createState() => _FeedBottomBannerWidgetState();
}

class _FeedBottomBannerWidgetState extends State<FeedBottomBanner> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController image;
  TextEditingController categoryBanner;
  String uploadedFileUrl1='';
  String uploadedFileUrl2='';
  String selectedCategory = '';

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
    image=TextEditingController();
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
                    'Add Banner',
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
                      height: 160,
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
                                Text('HomePage Banner',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                FFButtonWidget(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBannerWidget()));
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
                                uploadedFileUrl1==''?
                                Text(
                                    'Please Upload Home Page Banner',
                                    style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500)
                                ):
                                Expanded(
                                  child: TextFormField(
                                    controller: image,
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
                                              uploadedFileUrl1 = downloadUrl;
                                              image.text= uploadedFileUrl1;
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
                                uploadedFileUrl1==''?Container():
                                FFButtonWidget(
                                  onPressed: () async {
                                    FirebaseFirestore.instance.collection('banner').doc('banner').update({
                                      'homePageBanner':FieldValue.arrayUnion([uploadedFileUrl1]),
                                    });
                                    showUploadMessage(context, 'HomePage Banner Uploaded');
                                    setState(() {
                                      image.text='';
                                      uploadedFileUrl1='';
                                    });
                                  },
                                  text: 'Upload HomePage Banner ',
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
                                Text('Universities Banner',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                FFButtonWidget(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCategoryBannerWidget()));
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
                                    'Please Upload Universities Banner',
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
                              Container(
                                width: 330,
                                // height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: SearchableDropdown.single(
                                  items: fetchedCategories,
                                  value: selectedCategory,
                                  hint: "Select Universities",
                                  searchHint: "Select Universities",
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value;
                                      // categoryController.text=value;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
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
                                    if(uploadedFileUrl2!=''&&selectedCategory!=''){
                                      List<Map<String,dynamic>> banner=[];
                                      banner.add({
                                        'imageUrl':uploadedFileUrl2,
                                        'name':selectedCategory,
                                      });
                                      FirebaseFirestore.instance.collection('banner').doc('banner').update({
                                        'brandList':FieldValue.arrayUnion(banner),
                                      });
                                      showUploadMessage(context, 'Universities Banner Uploaded..');
                                      setState(() {
                                        categoryBanner.text='';
                                        uploadedFileUrl2='';
                                        selectedCategory='';
                                      });
                                    }else{uploadedFileUrl2==''?
                                    showUploadMessage(context, 'Please Upload Banner'):
                                    showUploadMessage(context, 'Please Select Universities');
                                    }
                                  },
                                  text: 'Upload Universities Banner ',
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
