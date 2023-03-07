import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';

import '../../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../../main.dart';

class AddNewCourse extends StatefulWidget {
  const AddNewCourse({Key key}) : super(key: key);

  @override
  State<AddNewCourse> createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {


  List<Item> intakes = [];
  List selectedIntakes = [];
  TextEditingController name;
  String dropDownValue;
  String type;

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List<String>();
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }
  getIntakes() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("intakes")
        .where('available',isEqualTo: true)
        .get();
    for (var doc in data1.docs) {
      intakes.add(Item.build(
        value: doc.id,
        display: dateTimeFormat('MMM yyyy', doc['intake'].toDate()),
        content: dateTimeFormat('MMM yyyy', doc['intake'].toDate()),
      ));

    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIntakes();
    name=TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Add New Course'),),
      content: Container(
        width: 1000,
        color: Colors.transparent,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 50, 30, 50),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,

                      child: Container(
                        width: 330,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              16, 0, 0, 0),
                          child: TextFormField(
                            controller: name,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Course Name',
                              labelStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                              hintText: 'Please Enter Course Name',
                              hintStyle: FlutterFlowTheme
                                  .bodyText2
                                  .override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                              ),
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius:
                                const BorderRadius.only(
                                  topLeft:
                                  Radius.circular(4.0),
                                  topRight:
                                  Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius:
                                const BorderRadius.only(
                                  topLeft:
                                  Radius.circular(4.0),
                                  topRight:
                                  Radius.circular(4.0),
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText2
                                .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12

                            ),
                          ),
                        ),
                      ),
                    ),
                   SizedBox(width: 20,),
                    Expanded(
                      child: FlutterFlowDropDown(
                        initialOption: type??'UG',
                        options: ['UG', 'PG', 'DIPLOMA',]
                            .toList(),
                        onChanged: (val) => setState(() => type = val),
                        width: 180,
                        height: 50,
                        textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        hintText: 'Please select Duration',
                        fillColor: Colors.white,
                        elevation: 2,
                        borderColor: Colors.black,
                        borderWidth: 0,
                        borderRadius: 0,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                        hidesUnderline: true,
                      ),
                    ),
                    SizedBox(width: 40,),






                  ],
                ),

              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Container(
                    //     width: 400,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //     child: MultiFilterSelect(
                    //       allItems: intakes,
                    //       initValue: selectedIntakes,
                    //       hintText: 'Select Intakes',
                    //       selectCallback: (List selectedValue) =>
                    //       selectedIntakes = selectedValue,
                    //     )
                    // ),
                    // SizedBox(width: 100,),


                    FFButtonWidget(
                      onPressed: () async {

                        if(name.text!=''&&dropDownValue!=''){

                          bool proceed = await alert(context,
                              'You want to Add This Course?');
                          if(proceed){
                            FirebaseFirestore.instance.collection('course')
                                .add({
                              'name':name.text,
                              'duration':dropDownValue,
                              'link':'',
                              'type':type,
                              'intakes':selectedIntakes,
                              'search':setSearchParam(name.text),
                              'delete':false
                            });
                            showUploadMessage(context, 'Course Added...');
                            Navigator.pop(context,name.text);
                            setState(() {



                            });
                          }

                        }else{
                          name.text==''?showUploadMessage(context, 'Please Enter Name'):
                          showUploadMessage(context, 'Please Select duration');
                        }
                      },
                      text: 'Add',
                      options: FFButtonOptions(
                        width: 100,
                        height: 50,
                        color: myColors,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),

                    SizedBox(width: 10,),






                  ],
                ),

              ),

            ],),
        ),),
    );
  }
}
