// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_erp/backend/backend.dart';
// import 'package:fl_erp/backend/schema/index.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_theme.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_widgets.dart';
//
// import 'EditSubCategory.dart';
// import 'Universities/categoryDetails.dart';
//
//
//
//
// class SubCategoryList extends StatefulWidget  {
//   const SubCategoryList({ Key key,}) : super(key: key);
//
//   @override
//   State<SubCategoryList> createState() => _SubCategoryListState();
// }
//
// class _SubCategoryListState extends State<SubCategoryList> {
//
//   String uploadedFileUrl1;
//   TextEditingController textController1;
//
//   @override
//   void initState() {
//     super.initState();
//     textController1 = TextEditingController();
//
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
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('subCategory').snapshots(),
//         builder: (context, snapshot) {
//           if(!snapshot.hasData){
//             return Center(child: CircularProgressIndicator());
//           }
//           var data=snapshot.data.docs;
//           print(data.length);
//           return Container(
//             height: MediaQuery.of(context).size.height*0.8,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: DataTable(
//                 columns: [
//                   DataColumn(
//                     label: Text("#ID",style: TextStyle(fontWeight: FontWeight.bold),),
//                   ),
//                   DataColumn(
//                     label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold)),
//                   ),
//                   DataColumn(
//                     label: Text("GST",style: TextStyle(fontWeight: FontWeight.bold)),
//                   ),
//
//                   DataColumn(
//                     label: Text(""),
//                   ),
//                   DataColumn(
//                     label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//                 rows: List<DataRow>.generate(
//                   data.length,
//                       (index) {
//
//                     String name=data[index]['name'];
//                     String imageUrl1=data[index]['imageUrl'];
//                     int gst=data[index]['gst'];
//
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(data[index].id)),
//                         DataCell(Text(name)),
//                         DataCell(Text(gst.toString())),
//                         DataCell(  Row(
//                           children: [
//
//                           ],
//                         ),),
//                         DataCell(   Row(
//                           children: [
//                             FFButtonWidget(
//                               onPressed: () async {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>EditSubCategoryWidget(
//                                   gst:gst.toString(),
//                                   name:name,
//                                   imageUrl:imageUrl1,
//                                   subCategoryId:data[index].id,
//                                   CategoryId:data[index]['categoryId'],
//                                 )));
//                               },
//                               text: 'Details',
//                               options: FFButtonOptions(
//                                 width: 90,
//                                 height: 30,
//                                 color: Colors.white,
//                                 textStyle: FlutterFlowTheme.subtitle2.override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.black,
//                                 ),
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 1,
//                                 ),
//                                 borderRadius: 8,
//                               ),
//                             ),
//
//                           ],
//                         ),),
//                         // DataCell(Text(fileInfo.size)),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
// }
//
//
