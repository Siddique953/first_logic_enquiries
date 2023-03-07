// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_erp/backend/backend.dart';
// import 'package:fl_erp/backend/schema/index.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_theme.dart';
// import 'package:fl_erp/flutter_flow/flutter_flow_widgets.dart';
//
// import 'add_Category.dart';
// import 'categoryDetails.dart';
//
//
//
//
//
// class CategoryList extends StatefulWidget  {
//   const CategoryList({ Key key,}) : super(key: key);
//
//   @override
//   State<CategoryList> createState() => _CategoryListState();
// }
//
// class _CategoryListState extends State<CategoryList> {
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
//         stream: FirebaseFirestore.instance.collection('category').snapshots(),
//         builder: (context, snapshot) {
//           if(!snapshot.hasData){
//             return Center(child: CircularProgressIndicator());
//           }
//           var data=snapshot.data.docs;
//           print(data.length);
//           return Container(
//
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 SizedBox(
//                   width: double.infinity,
//                   child: DataTable(
//                     horizontalMargin: 0,
//                     columns: [
//                       DataColumn(
//                         label: Text("#ID",style: TextStyle(fontWeight: FontWeight.bold),),
//                       ),
//                       DataColumn(
//                         label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//
//                       DataColumn(
//                         label: Text(""),
//                       ),
//                       DataColumn(
//                         label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                     rows: List.generate(
//                       data.length,
//                           (index) {
//
//                         String name=data[index]['name'];
//                         String imageUrl1=data[index]['imageUrl'];
//
//
//
//
//
//                         return DataRow(
//                           cells: [
//                             DataCell(Text(data[index].id)),
//                             DataCell(Text(name)),
//                             DataCell(  Row(
//                               children: [
//
//                               ],
//                             ),),
//                             DataCell(   Row(
//                               children: [
//                                 FFButtonWidget(
//                                   onPressed: ()  {
//
//                                 
//                                    
//                                     setState(() {
//                                       edit=true;
//                                       currentCategoryId=data[index].id;
//                                       currentName=name;
//                                       currentImage=imageUrl1;
//                                     });
//                                    
//                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCategoryWidget(
//                                    //   name:name,
//                                    //     imageUrl:imageUrl1,
//                                    //   categoryId:data[index].id,
//                                    // )));
//                                   },
//                                   text: 'Details',
//                                   options: FFButtonOptions(
//                                     width: 90,
//                                     height: 30,
//                                     color: Colors.white,
//                                     textStyle: FlutterFlowTheme.subtitle2.override(
//                                       fontFamily: 'Poppins',
//                                       color: Colors.black,
//                                     ),
//                                     borderSide: BorderSide(
//                                       color: Colors.transparent,
//                                       width: 1,
//                                     ),
//                                     borderRadius: 8,
//                                   ),
//                                 ),
//
//                               ],
//                             ),),
//                             // DataCell(Text(fileInfo.size)),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//     );
//   }
// }
//
//
