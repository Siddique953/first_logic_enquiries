
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_select/Item.dart';
import 'package:searchfield/searchfield.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import '../../../flutter_flow/upload_media.dart';

class UniversityDetailsViewWidget extends StatefulWidget {
  final String id;
  const UniversityDetailsViewWidget({Key key, this.id}) : super(key: key);

  @override
  _UniversityDetailsViewWidgetState createState() =>
      _UniversityDetailsViewWidgetState();
}

class _UniversityDetailsViewWidgetState
    extends State<UniversityDetailsViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool edit=false;


  List<Item> courseList = [];
  TextEditingController course;
  TextEditingController c1;
  TextEditingController c2;
  TextEditingController c3;
  TextEditingController c4;
  TextEditingController c5;
  TextEditingController c6;
  TextEditingController c7;
  TextEditingController c8;
  TextEditingController c9;
  TextEditingController c10;

  List <String> courses = [];

  var forms;
  Map<String, dynamic> countryName = {};


  getCourse() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("course").get();
    for (var doc in data1.docs) {
      courses.add(doc.get('name'));
      courseList.add(Item.build(
          value: doc.id, display: doc.get('name'), content: doc.get('name')));
    }
    setState(() {});
  }

  getCuntry() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("country").get();
    for (var doc in data1.docs) {
      countryName[doc.id] = doc.get('name');


    }
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCourse();
    getCuntry();
    course=TextEditingController();
    c1=TextEditingController();
    c2=TextEditingController();
    c3=TextEditingController();
    c4=TextEditingController();
    c5=TextEditingController();
    c6=TextEditingController();
    c7=TextEditingController();
    c8=TextEditingController();
    c9=TextEditingController();
    c10=TextEditingController();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),

        automaticallyImplyLeading: true,
        title: Text(
          'University Details',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('university').doc(widget.id).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: Image.asset('assets/images/loading.gif'));
            }
            var data=snapshot.data;

            // forms=data.get('form');
            return SingleChildScrollView(
              child: edit==true? Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              height: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [

                                  Padding(
                                    padding: EdgeInsetsDirectional
                                        .fromSTEB(20, 20, 20, 20),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child:Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10,),
                                                Text('Please Select Course',  style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF090F13),
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),),
                                                SizedBox(width: 10,),

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
                                                  child: SearchField(
                                                    controller: course,
                                                    suggestions: courses,
                                                    hint: 'Search Course',
                                                    searchStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black.withOpacity(0.8),
                                                    ),
                                                    searchInputDecoration:
                                                    InputDecoration(
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.black.withOpacity(0.8),
                                                        ),
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.red),
                                                      ),
                                                    ),
                                                    onTap: (x) {
                                                      setState(() {


                                                      });
                                                    },
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 10,),


                                                Text('Please Select Criteria',
                                                  style: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),),

                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c1,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 1',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c2,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 2',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c3,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 3',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c4,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 4',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),




                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c5,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 5',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c6,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 6',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c7,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 7',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c8,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 8',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),




                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 10,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          bool pressed = await alert(
                                                              context,
                                                              'Update Course Details');

                                                          if (pressed) {

                                                            snapshot.data.reference.update({
                                                              'courses':courses,
                                                            });

                                                            showUploadMessage(context, 'Course Details Updated...');

                                                          }

                                                        },
                                                        child: Container(
                                                          height: 100,
                                                          constraints: BoxConstraints(
                                                            maxHeight: 50,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Color(0xFF4B39EF),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 4,
                                                                color:
                                                                Color(0x32171717),
                                                                offset: Offset(0, 2),
                                                              )
                                                            ],
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                30),
                                                            shape: BoxShape.rectangle,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8, 0, 8, 0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [

                                                                Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(8,
                                                                      0, 0, 0),
                                                                  child: Text(
                                                                    'Update Course Details',
                                                                    style:
                                                                    FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'Lexend Deca',
                                                                      color:
                                                                      Colors.white,
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),

                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ):Column(
                mainAxisSize: MainAxisSize.max,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              height: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [

                                  Padding(
                                    padding: EdgeInsetsDirectional
                                        .fromSTEB(20, 20, 20, 20),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child:Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10,),
                                                Text('Please Select Course',  style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF090F13),
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),),
                                                SizedBox(width: 10,),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 10,),


                                                Text('Please Select Criteria',
                                                  style: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF090F13),
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),),

                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c1,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 1',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c2,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 2',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c3,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 3',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c4,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 4',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),




                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(

                                              children: [
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c5,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 5',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c6,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 6',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c7,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 7',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: c8,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Criteria 8',
                                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText: 'Please Enter Criteria',
                                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(4.0),
                                                          topRight: Radius.circular(4.0),
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF252525),
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
                                                SizedBox(width: 10,),




                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 10,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          bool pressed = await alert(
                                                              context,
                                                              'Update Course Details');

                                                          if (pressed) {

                                                            snapshot.data.reference.update({
                                                              'courses':courses,
                                                            });

                                                            showUploadMessage(context, 'Course Details Updated...');

                                                          }

                                                        },
                                                        child: Container(
                                                          height: 100,
                                                          constraints: BoxConstraints(
                                                            maxHeight: 50,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Color(0xFF4B39EF),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 4,
                                                                color:
                                                                Color(0x32171717),
                                                                offset: Offset(0, 2),
                                                              )
                                                            ],
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                30),
                                                            shape: BoxShape.rectangle,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8, 0, 8, 0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [

                                                                Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(8,
                                                                      0, 0, 0),
                                                                  child: Text(
                                                                    'Update Course Details',
                                                                    style:
                                                                    FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                      'Lexend Deca',
                                                                      color:
                                                                      Colors.white,
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),

                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
