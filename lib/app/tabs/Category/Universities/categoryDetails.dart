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
// class EditCategoryWidget extends StatefulWidget {
//   final String name;
//   final String imageUrl;
//   final String categoryId;
//   const EditCategoryWidget({Key key, this.name, this.imageUrl, this.categoryId}) : super(key: key);
//
//   @override
//   _EditCategoryWidgetState createState() => _EditCategoryWidgetState();
// }
//
// class _EditCategoryWidgetState extends State<EditCategoryWidget> {
//   TextEditingController categoryName;
//   String uploadedFileUrl1='';
//   final scaffoldKey = GlobalKey<ScaffoldState>();
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
//   void initState() {
//     super.initState();
//     categoryName = TextEditingController(text: widget.name);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: FlutterFlowTheme.primaryColor,
//         automaticallyImplyLeading: true,
//         title: Text(
//           'Edit Universities',
//           style: FlutterFlowTheme.bodyText1.override(
//             fontFamily: 'Poppins',
//             color: Colors.white,
//             fontSize: 20,
//           ),
//         ),
//         actions: [],
//         centerTitle: true,
//         elevation: 0,
//       ),
//       backgroundColor: Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Container(
//                 decoration: BoxDecoration(),
//                 child: CachedNetworkImage(
//                   imageUrl: uploadedFileUrl1==''?widget.imageUrl:uploadedFileUrl1,
// height: 200,
//                   width: 150,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FFButtonWidget(
//                 onPressed: () async {
//                   await showDialog(
//                     context: context,
//                     builder: (alertDialogContext) {
//                       return AlertDialog(
//                         title: Text('Change Image'),
//                         content: Text('Do you want to Change Image ?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(alertDialogContext),
//                             child: Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () async {
//                               final selectedMedia = await selectMedia(
//                                 maxWidth: 1080.00,
//                                 maxHeight: 1320.00,
//                               );
//                               if (selectedMedia != null &&
//                                   validateFileFormat(
//                                       selectedMedia.storagePath, context)) {
//                                 Navigator.pop(alertDialogContext);
//
//                                 showUploadMessage(context, 'Uploading file...',
//                                     showLoading: true);
//                                 final downloadUrl = await uploadData(
//                                     selectedMedia.storagePath,
//                                     selectedMedia.bytes);
//                                 ScaffoldMessenger.of(context)
//                                     .hideCurrentSnackBar();
//                                 if (downloadUrl != null) {
//                                   setState(
//                                           () {
//                                         uploadedFileUrl1 = downloadUrl;
//                                       } );
//                                   showUploadMessage(context, 'Success!');
//                                 } else {
//                                   showUploadMessage(
//                                       context, 'Failed to upload media');
//                                 }
//                               }
//                               Navigator.pop(alertDialogContext);
//
//                             },
//                             child: Text('Confirm'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 text: 'Change Image',
//                 options: FFButtonOptions(
//                   width: 130,
//                   height: 40,
//                   color: FlutterFlowTheme.primaryColor,
//                   textStyle: FlutterFlowTheme.subtitle2.override(
//                     fontFamily: 'Poppins',
//                     color: Colors.white,
//                     fontSize: 12,
//                   ),
//                   borderSide: BorderSide(
//                     color: Colors.transparent,
//                     width: 1,
//                   ),
//                   borderRadius: 12,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
//                 child: TextFormField(
//                   controller: categoryName,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     hintText: 'Please Enter Universities Name',
//                     hintStyle: FlutterFlowTheme.bodyText1.override(
//                       fontFamily: 'Poppins',
//                       color: Colors.black,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Color(0xFF232323),
//                         width: 1,
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(4.0),
//                         topRight: Radius.circular(4.0),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Color(0xFF232323),
//                         width: 1,
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(4.0),
//                         topRight: Radius.circular(4.0),
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                   style: FlutterFlowTheme.bodyText1.override(
//                     fontFamily: 'Poppins',
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FFButtonWidget(
//                       onPressed: () async {
//
//                         bool proceed = await alert(
//                             context,
//                             'You want to Delete this category?');
//
//                         if (proceed) {
//                           await CategoriesRecord
//                               .collection
//                               .doc(widget.categoryId)
//                               .delete();
//                           showUploadMessage(
//                               context, 'Delete Success!');
//                         }
//                         Navigator.pop(context);
//                       },
//                       text: 'Delete',
//                       options: FFButtonOptions(
//                         width: 130,
//                         height: 40,
//                         color: Color(0xFFF10202),
//                         textStyle: FlutterFlowTheme.subtitle2.override(
//                           fontFamily: 'Poppins',
//                           color: Colors.white,
//                         ),
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                           width: 1,
//                         ),
//                         borderRadius: 12,
//                       ),
//                     ),
//                     FFButtonWidget(
//                       onPressed: () async {
//                         final imageUrl = uploadedFileUrl1==''?widget.imageUrl:
//                         uploadedFileUrl1;
//                         final name =
//                             categoryName
//                                 .text;
//                         if (name == "" || name == null) {
//                           showUploadMessage(context,
//                               "please enter category name");
//                         } else if (imageUrl == "" ||
//                             imageUrl == null) {
//                           showUploadMessage(context,
//                               "please choose a category image");
//                         } else {
//                           bool proceed = await alert(
//                               context,
//                               'You want to update this category?');
//
//                           if (proceed) {
//                             final categoriesRecordData =
//                             createCategoriesRecordData(
//                               imageUrl: imageUrl,
//                               name: name,
//                               search: setSearchParam(name),
//                             );
//
//                             await CategoriesRecord
//                                 .collection
//                                 .doc(widget.categoryId)
//                                 .set(categoriesRecordData);
//                             showUploadMessage(context,
//                                 'Update Success!');
//                           }
//                         }
//                         Navigator.pop(context);
//                       },
//                       text: 'Update',
//                       options: FFButtonOptions(
//                         width: 130,
//                         height: 40,
//                         color: secondaryColor,
//                         textStyle: FlutterFlowTheme.subtitle2.override(
//                           fontFamily: 'Poppins',
//                           color: Colors.white,
//                         ),
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                           width: 1,
//                         ),
//                         borderRadius: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
