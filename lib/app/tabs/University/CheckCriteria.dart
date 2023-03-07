
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_erp/flutter_flow/upload_media.dart';
import 'package:searchfield/searchfield.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../flutter_flow/upload_media.dart';

class UniversityListWidget extends StatefulWidget {
  const UniversityListWidget({Key key}) : super(key: key);

  @override
  _UniversityListWidgetState createState() => _UniversityListWidgetState();
}

class _UniversityListWidgetState extends State<UniversityListWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List nameList=[];
  bool add=false;
  List un=[];
  List<String> courseList=[];
  List<String> universityList=[];

  TextEditingController universityName=TextEditingController();
  TextEditingController courseName=TextEditingController();

Map<String,dynamic>courseById={};
Map<String,dynamic>universityNameById={};
Map<String,dynamic>courseByName={};
Map<String,dynamic>universityById={};
Map<String,dynamic>universityCourseById={};
Map added={};
  getCourse() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("course").get();
    courseList=[];
    for (var doc in data1.docs) {
      courseList.add(doc.get('name'));
      courseByName[doc.get('name')]=doc.id;
      courseById[doc.id]=doc.get('name');

    }
    setState(() {});
  }
  getUniverSity() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("university").get();
    universityList=[];
    for (var doc in data1.docs) {
      universityList.add(doc.get('name'));
      universityById[doc.get('name')]=doc.id;
      universityNameById[doc.id]=doc.get('name');

      universityCourseById[doc.get('name')]=doc.get('courses');

    }
    setState(() {});
  }


  String selectedUniversity='';
  String selectedCourse='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCourse();
    getUniverSity();
    courseName=TextEditingController();
    universityName=TextEditingController();

  }


  @override
  Widget build(BuildContext context) {
    print(un);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'University List',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '',
                    style: FlutterFlowTheme.bodyText2.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF8B97A2),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Selected Universities',   style: FlutterFlowTheme.title2.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF090F13),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),), Text('Selected Course',   style: FlutterFlowTheme.title2.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF090F13),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text('Selected Course',   style: FlutterFlowTheme.title2.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 330,
                    // height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: SearchField(
                      controller: universityName,
                      suggestions: universityList,
                      hint: 'Search University',
                      searchStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      searchInputDecoration:
                      InputDecoration(
                        focusedBorder: OutlineInputBorder(

                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      onTap: (x) {
                        selectedUniversity=x;
                        courseList=[];
                        courseName.clear();
                        for(var data in universityCourseById[x]){
                          courseList.add(courseById[data]);
                        }

                        print(universityById[x]);
                        setState(() {

                        });
                      },
                    ),
                  ),

                  Container(
                    width: 330,
                    // height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: SearchField(
                      controller: courseName,
                      suggestions: courseList,
                      hint: 'Search Course',
                      searchStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      searchInputDecoration:
                      InputDecoration(
                        focusedBorder: OutlineInputBorder(

                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      onTap: (x) {
                        selectedCourse=x;
                        print(courseById[x]);
                        setState(() {

                        });
                      },
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {

                      if(universityName.text!=''&&courseName.text!=''){
                        bool pressed=await alert(context, 'Do you want to Add?');
                        if(pressed){
                          nameList.add({
                            'name':universityById[universityName.text],
                            'course':courseByName[courseName.text],
                          });
                          showUploadMessage(context, 'New List Added...');
                          setState(() {
                            universityName.clear();
                            courseName.clear();

                          });
                        }
                        if(nameList.length==3){
                          Navigator.pop(context,nameList);
                        }
                      }else{
                        universityName.text==''?showUploadMessage(context, 'Please Choose University'):
                            showUploadMessage(context, 'Please Choose Course');
                      }



                    },
                    text: 'ADD',
                    icon: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    options: FFButtonOptions(
                      width: 120,
                      height: 40,
                      color: Color(0xFF39D2C0),
                      textStyle: GoogleFonts.getFont(
                        'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 15,
                    ),
                  ),
                ],
              ),
            ),

            ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: nameList.length,
                itemBuilder: (buildContext,int index){
                  print(nameList.length);



                  return nameList.length==0?Center(child: Text('List Is Empty'),): Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: // Generated code for this Column-Content Widget...
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${index + 1} - ',
                                              style: FlutterFlowTheme.title2.override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                universityNameById[nameList[index]['name']],
                                                style: FlutterFlowTheme.title2.override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(

                                                courseById[nameList[index]['course']],
                                                style: FlutterFlowTheme.title2.override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [


                                      FFButtonWidget(
                                        onPressed: () {

                                          setState(() {

                                          });

                                        },
                                        text: 'Remove',
                                        icon: Icon(
                                          Icons.not_interested_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 120,
                                          height: 40,
                                          color: Colors.red,
                                          textStyle: GoogleFonts.getFont(
                                            'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          elevation: 3,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        ,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
