// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fl_erp/backend/firebase_storage/storage.dart';
// import 'package:fl_erp/backend/schema/categories_record.dart';
// import 'package:fl_erp/backend/schema/index.dart';
// import 'package:fl_erp/backend/schema/sub_category_record.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_drop_down.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_theme.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_erp/flutter_flow/upload_media.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
//
// class EditSubCategoryWidget extends StatefulWidget {
//   final String name;
//   final String gst;
//   final String imageUrl;
//   final String subCategoryId;
//   final String CategoryId;
//   const EditSubCategoryWidget({Key key, this.name, this.imageUrl, this.subCategoryId, this.gst, this.CategoryId}) : super(key: key);
//
//   @override
//   _EditSubCategoryWidgetState createState() => _EditSubCategoryWidgetState();
// }
//
// class _EditSubCategoryWidgetState extends State<EditSubCategoryWidget> {
//   TextEditingController categoryName;
//   String uploadedFileUrl1='';
//   String selectedCategory = "";
//   String dropDownValue;
//
//   final List<DropdownMenuItem> fetchedCategories = <DropdownMenuItem>[];
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
//   Future getCategories() async {
//     QuerySnapshot data1 =
//     await FirebaseFirestore.instance.collection("category").get();
//     for (var doc in data1.docs) {
//       fetchedCategories.add(DropdownMenuItem(
//         child: Text(doc.get('name')),
//         value: doc.get('categoryId'),
//       ));
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     selectedCategory=widget.CategoryId;
//     dropDownValue=widget.gst;
//     categoryName = TextEditingController(text: widget.name);
//
//
//     if (fetchedCategories.isEmpty) {
//       getCategories().then((value) {
//         setState(() {});
//       });
//     }
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
//           'Edit Sub Universities',
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
//                   height: 200,
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
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text('Tax :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
//                     FlutterFlowDropDown(
//                       initialOption: dropDownValue?? '5',
//                       options: ['0', '5', '12', '18','28'].toList(),
//                       onChanged: (val) => setState(() => dropDownValue = val),
//                       width: 180,
//                       height: 50,
//                       textStyle: FlutterFlowTheme.bodyText1.override(
//                         fontFamily: 'Poppins',
//                         color: Colors.black,
//                       ),
//                       fillColor: Colors.white,
//                       elevation: 2,
//                       borderColor: Colors.black,
//                       borderWidth: 0,
//                       borderRadius: 0,
//                       margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
//                       hidesUnderline: true,
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: 170,
//                 // height: 70,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:
//                   BorderRadius.circular(8),
//                   border: Border.all(
//                     color: Color(0xFFE6E6E6),
//                   ),
//                 ),
//                 child: SearchableDropdown.single(
//                   items: fetchedCategories,
//                   value: selectedCategory,
//                   hint: "Select Universities",
//                   searchHint: "Select Universities",
//                   onChanged: (value) {
//
//                     selectedCategory =
//                         value;
//
//                   },
//                   isExpanded: true,
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
//                             'You want to Delete this SubCategory?');
//
//                         if (proceed) {
//                           await SubCategoryRecord
//                               .collection
//                               .doc(widget.subCategoryId)
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
//                         final categoryId =
//                             selectedCategory;
//                         final imageUrl = uploadedFileUrl1==''?widget.imageUrl:
//                         uploadedFileUrl1;
//                         final name =
//                             categoryName
//                                 .text;
//                         if (name == "" || name == null) {
//                           showUploadMessage(context,
//                               "please enter Subcategory name");
//                         } else if (imageUrl == "" ||
//                             imageUrl == null) {
//                           showUploadMessage(context,
//                               "please choose a Subcategory image");
//                         } else {
//                           bool proceed = await alert(
//                               context,
//                               'You want to update this SubCategory?');
//
//                           if (proceed) {
//                             final subCategoryRecordData =
//                             createSubCategoryRecordData(
//                               imageUrl: imageUrl,
//                               gst: int.tryParse(dropDownValue),
//                               categoryId: categoryId,
//                               name: name,
//                               search: setSearchParam(name),
//                             );
//
//                             await SubCategoryRecord
//                                 .collection
//                                 .doc(widget.subCategoryId)
//                                 .set(subCategoryRecordData);
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
//                         color: FlutterFlowTheme.primaryColor,
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
