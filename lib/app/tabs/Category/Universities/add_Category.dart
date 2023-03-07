// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fl_erp/backend/firebase_storage/storage.dart';
// import 'package:fl_erp/backend/schema/categories_record.dart';
// import 'package:fl_erp/backend/schema/index.dart';
// import 'package:fl_erp/constant/Constant.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_theme.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_erp/flutter_flow/upload_media.dart';
//
//
//
//
// class AddCategoryWidget1 extends StatefulWidget {
//   const AddCategoryWidget1({Key key}) : super(key: key);
//
//   @override
//   _AddCategoryWidget1State createState() => _AddCategoryWidget1State();
// }
//
// class _AddCategoryWidget1State extends State<AddCategoryWidget1> {
//   TextEditingController name;
//   TextEditingController image;
//   String uploadedFileUrl1='';
//  
//  
//   //while editing
//   TextEditingController eName;
//   TextEditingController eImage;
//   String eUploadedFileUrl1='';
//  
//
//
//   @override
//   void initState() {
//     super.initState();
//     name = TextEditingController();
//     eName = TextEditingController(text: currentName);
//     image = TextEditingController(text: uploadedFileUrl1);
//     eImage = TextEditingController(text: currentImage);
//   }
//   setSearchParam(String caseNumber) {
//     ListBuilder<String> caseSearchList = ListBuilder<String>();
//     String temp = "";
//
//     List<String> nameSplits = caseNumber.split(" ");
//     for (int i = 0; i < nameSplits.length; i++) {
//       String name = "";
//
//       for (int k = i; k < nameSplits.length; k++) {
//         name = name + nameSplits[k] + " ";
//       }
//       temp = "";
//
//       for (int j = 0; j < name.length; j++) {
//         temp = temp + name[j];
//         caseSearchList.add(temp.toUpperCase());
//       }
//     }
//     return caseSearchList;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
//       child:  edit==true?Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TextFormField(
//             controller: eName,
//             obscureText: false,
//             decoration: InputDecoration(
//               labelText: 'Universities Name',
//               labelStyle: FlutterFlowTheme.bodyText1.override(
//                 fontFamily: 'Poppins',
//                 color: Colors.black,
//               ),
//               hintText: 'Please Enter Universities Name',
//               hintStyle: FlutterFlowTheme.bodyText1.override(
//                 fontFamily: 'Poppins',
//                 color: Colors.black,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Color(0xFF252525),
//                   width: 1,
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4.0),
//                   topRight: Radius.circular(4.0),
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Color(0xFF252525),
//                   width: 1,
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4.0),
//                   topRight: Radius.circular(4.0),
//                 ),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             style: FlutterFlowTheme.bodyText1.override(
//               fontFamily: 'Poppins',
//               color: Colors.black,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 30),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                Container(
//                  height: 100,
//                    width: 100,
//                    child: CachedNetworkImage(imageUrl: currentImage)),
//                 FFButtonWidget(
//                   onPressed: () async {
//                     final selectedMedia = await selectMedia(
//                       maxWidth: 1080.00,
//                       maxHeight: 1320.00,
//                     );
//                     if (selectedMedia != null &&
//                         validateFileFormat(
//                             selectedMedia.storagePath, context)) {
//                       showUploadMessage(context, 'Uploading file...',
//                           showLoading: true);
//                       final downloadUrl = await uploadData(
//                           selectedMedia.storagePath,
//                           selectedMedia.bytes);
//                       ScaffoldMessenger.of(context)
//                           .hideCurrentSnackBar();
//                       if (downloadUrl != null) {
//                         setState(
//                                 () {
//                                   eUploadedFileUrl1 = downloadUrl;
//                                  eImage.text= eUploadedFileUrl1;
//                                 } );
//                         showUploadMessage(context, 'Success!');
//                       } else {
//                         showUploadMessage(
//                             context, 'Failed to upload media');
//                       }
//                     }
//                   },
//                   text: 'Change Image ',
//                   options: FFButtonOptions(
//                     width: 130,
//                     height: 40,
//                     color: secondaryColor,
//                     textStyle: FlutterFlowTheme.subtitle2.override(
//                       fontFamily: 'Poppins',
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     borderSide: BorderSide(
//                       color: Colors.transparent,
//                       width: 1,
//                     ),
//                     borderRadius: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           FFButtonWidget(
//             onPressed: () async {
//               final category = eImage.text;
//               final imageUrl = eUploadedFileUrl1;
//               if (category == "" || category == null) {
//                 showUploadMessage(
//                     context, "Please Enter Universities name");
//               } else if (imageUrl == "" ||
//                   imageUrl == null) {
//                 showUploadMessage(context,
//                     "Please Choose a Universities image");
//               } else {
//                 bool proceed = await alert(context,
//                     'You want to add this category?');
//
//                 if (proceed) {
//                   final categoriesRecordData =
//                   createCategoriesRecordData(
//                     name: category,
//                     imageUrl: imageUrl,
//                     search: setSearchParam(category),
//                   );
//
//                   await CategoriesRecord.collection
//                       .doc(currentCategoryId)
//                   .update(categoriesRecordData);
//                     showUploadMessage(
//                         context, 'Upload Success!');
//                     setState(() {
//
//                       uploadedFileUrl1='';
//                       name.text='';
//                       image.text='';
//
//
//                     });
//                 }
//               }
//             },
//             text: 'Update Universities',
//             options: FFButtonOptions(
//               width: double.infinity,
//               height: 50,
//               color: secondaryColor,
//               textStyle: FlutterFlowTheme.subtitle2.override(
//                 fontFamily: 'Poppins',
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//               borderSide: BorderSide(
//                 color: Colors.transparent,
//                 width: 1,
//               ),
//               borderRadius: 12,
//             ),
//           ),
//         ],
//       ):
//       Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TextFormField(
//             controller: name,
//             obscureText: false,
//             decoration: InputDecoration(
//               labelText: 'Universities Name',
//               labelStyle: FlutterFlowTheme.bodyText1.override(
//                 fontFamily: 'Poppins',
//                 color: Colors.black,
//               ),
//               hintText: 'Please Enter Universities Name',
//               hintStyle: FlutterFlowTheme.bodyText1.override(
//                 fontFamily: 'Poppins',
//                 color: Colors.black,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Color(0xFF252525),
//                   width: 1,
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4.0),
//                   topRight: Radius.circular(4.0),
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Color(0xFF252525),
//                   width: 1,
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4.0),
//                   topRight: Radius.circular(4.0),
//                 ),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             style: FlutterFlowTheme.bodyText1.override(
//               fontFamily: 'Poppins',
//               color: Colors.black,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 30),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 uploadedFileUrl1==''?
//                 Text(
//                     'Please Upload Image',
//                     style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600)
//                 ):
//                 Expanded(
//                   child: TextFormField(
//                     controller: image,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       hintStyle: FlutterFlowTheme.bodyText1.override(
//                         fontFamily: 'Poppins',
//                         color: Colors.black,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFF232323),
//                           width: 1,
//                         ),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(4.0),
//                           topRight: Radius.circular(4.0),
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xFF232323),
//                           width: 1,
//                         ),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(4.0),
//                           topRight: Radius.circular(4.0),
//                         ),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     style: FlutterFlowTheme.bodyText1.override(
//                       fontFamily: 'Poppins',
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 FFButtonWidget(
//                   onPressed: () async {
//                     final selectedMedia = await selectMedia(
//                       maxWidth: 1080.00,
//                       maxHeight: 1320.00,
//                     );
//                     if (selectedMedia != null &&
//                         validateFileFormat(
//                             selectedMedia.storagePath, context)) {
//                       showUploadMessage(context, 'Uploading file...',
//                           showLoading: true);
//                       final downloadUrl = await uploadData(
//                           selectedMedia.storagePath,
//                           selectedMedia.bytes);
//                       ScaffoldMessenger.of(context)
//                           .hideCurrentSnackBar();
//                       if (downloadUrl != null) {
//                         setState(
//                                 () {
//                               uploadedFileUrl1 = downloadUrl;
//                               image.text= uploadedFileUrl1;
//                             } );
//                         showUploadMessage(context, 'Success!');
//                       } else {
//                         showUploadMessage(
//                             context, 'Failed to upload media');
//                       }
//                     }
//                   },
//                   text: uploadedFileUrl1==''?'Upload Image':'Change Image ',
//                   options: FFButtonOptions(
//                     width: 130,
//                     height: 40,
//                     color: secondaryColor,
//                     textStyle: FlutterFlowTheme.subtitle2.override(
//                       fontFamily: 'Poppins',
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     borderSide: BorderSide(
//                       color: Colors.transparent,
//                       width: 1,
//                     ),
//                     borderRadius: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           FFButtonWidget(
//             onPressed: () async {
//               final category = name.text;
//               final imageUrl = uploadedFileUrl1;
//               if (category == "" || category == null) {
//                 showUploadMessage(
//                     context, "Please Enter Universities name");
//               } else if (imageUrl == "" ||
//                   imageUrl == null) {
//                 showUploadMessage(context,
//                     "Please Choose a Universities image");
//               } else {
//                 bool proceed = await alert(context,
//                     'You want to add this category?');
//
//                 if (proceed) {
//                   final categoriesRecordData =
//                   createCategoriesRecordData(
//                     name: category,
//                     imageUrl: imageUrl,
//                     search: setSearchParam(category),
//                   );
//
//                   await CategoriesRecord.collection
//                       .add(categoriesRecordData)
//                       .then((DocumentReference doc) {
//                     String docId = doc.id;
//                     CategoriesRecord.collection
//                         .doc(docId)
//                         .update({"categoryId": docId});
//                     showUploadMessage(
//                         context, 'Upload Success!');
//                     setState(() {
//
//                       uploadedFileUrl1='';
//                       name.text='';
//                       image.text='';
//
//
//                     });
//                   });
//                 }
//               }
//             },
//             text: 'Create  Universities',
//             options: FFButtonOptions(
//               width: double.infinity,
//               height: 50,
//               color: secondaryColor,
//               textStyle: FlutterFlowTheme.subtitle2.override(
//                 fontFamily: 'Poppins',
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//               borderSide: BorderSide(
//                 color: Colors.transparent,
//                 width: 1,
//               ),
//               borderRadius: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
