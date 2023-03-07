// import 'package:flutter/cupertino.dart';
// import 'package:fl_erp/backend/firebase_storage/storage.dart';
// import 'package:fl_erp/backend/schema/categories_record.dart';
// import 'package:fl_erp/backend/schema/index.dart';
// import 'package:fl_erp/backend/schema/sub_category_record.dart';
// import 'package:fl_erp/constant/Constant.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_drop_down.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_theme.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_erp/flutter_flow/upload_media.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
//
// class AddSubCategoryWidget1 extends StatefulWidget {
//   const AddSubCategoryWidget1({Key key}) : super(key: key);
//
//   @override
//   _AddSubCategoryWidget1State createState() => _AddSubCategoryWidget1State();
// }
//
// class _AddSubCategoryWidget1State extends State<AddSubCategoryWidget1> {
//   TextEditingController name;
//   TextEditingController image;
//   String uploadedFileUrl1='';
//   String dropDownValue1;
//   TextEditingController textController1;
//   String dropDownValue2;
//   String dropDownValue;
//   TextEditingController textController2;
//   String uploadedFileUrl2;
//   TextEditingController categoryController = TextEditingController();
//   String selectedCategory = "";
//   final List<DropdownMenuItem> fetchedCategories = <DropdownMenuItem>[];
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
//     dropDownValue1 = 'Option 1';
//     textController1 = TextEditingController();
//     dropDownValue2 = 'Option 1';
//     textController2 = TextEditingController();
//     if (fetchedCategories.isEmpty) {
//       getCategories().then((value) {
//         setState(() {});
//       });
//     }
//     name = TextEditingController();
//     image = TextEditingController(text: uploadedFileUrl1);
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
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TextFormField(
//             controller: name,
//             obscureText: false,
//             decoration: InputDecoration(
//               labelText: 'SUb Universities Name',
//               labelStyle: FlutterFlowTheme.bodyText1.override(
//                 fontFamily: 'Poppins',
//                 color: Colors.black,
//               ),
//               hintText: 'Please Enter Sub Universities Name',
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
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text('Tax :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
//               FlutterFlowDropDown(
//                 initialOption: dropDownValue ??= '5 ',
//                 options: ['0 ', '5 ', '12 ', '18 ','28'].toList(),
//                 onChanged: (val) => setState(() => dropDownValue = val),
//                 width: 180,
//                 height: 50,
//                 textStyle: FlutterFlowTheme.bodyText1.override(
//                   fontFamily: 'Poppins',
//                   color: Colors.black,
//                 ),
//                 fillColor: Colors.white,
//                 elevation: 2,
//                 borderColor: Colors.black,
//                 borderWidth: 0,
//                 borderRadius: 0,
//                 margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
//                 hidesUnderline: true,
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: 10.0, horizontal: 0.0),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: 330,
//               // height: 70,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: Color(0xFFE6E6E6),
//                 ),
//               ),
//               child: SearchableDropdown.single(
//                 items: fetchedCategories,
//                 value: selectedCategory,
//                 hint: "Select one",
//                 searchHint: "Select one",
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCategory = value;
//                     categoryController.text = value;
//                   });
//                 },
//                 isExpanded: true,
//               ),
//             ),
//           ),
//           FFButtonWidget(
//             onPressed: () async {
//               final category = name.text;
//               final categoryId = selectedCategory;
//
//               final imageUrl = uploadedFileUrl1;
//               if (category == "" || category == null) {
//                 showUploadMessage(
//                     context, "Please Enter Sub Universities name");
//               } else if (imageUrl == "" ||
//                   imageUrl == null) {
//                 showUploadMessage(context,
//                     "Please Choose a Sub Universities image");
//               } else {
//                 bool proceed = await alert(context,
//                     'You want to add this Sub Universities?');
//
//                 if (proceed) {
//                   final subCategoryRecordData =
//                   createSubCategoryRecordData(
//                     name: category,
//                     categoryId: categoryId,
//                     gst: int.tryParse(dropDownValue),
//                     imageUrl: imageUrl,
//                     search: setSearchParam(category),
//                   );
//
//                   await SubCategoryRecord.collection
//                       .add(subCategoryRecordData)
//                       .then((DocumentReference doc) {
//                     String docId = doc.id;
//                     CategoriesRecord.collection
//                         .doc(docId)
//                         .update({"subCategoryId": docId});
//                     showUploadMessage(
//                         context, 'Upload Success!');
//                     setState(() {
//
//                       uploadedFileUrl1='';
//                       name.text='';
//                       image.text='';
//                       selectedCategory='';
//
//
//                     });
//                   });
//                 }
//               }
//             },
//             text: 'Create Sub Universities',
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
