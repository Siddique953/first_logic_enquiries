import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../auth/email_auth.dart';
import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../flutter_flow/upload_media.dart';

String ogUser = '';
String ogPass = '';

class AddBranchWidget extends StatefulWidget {
  const AddBranchWidget({Key key}) : super(key: key);

  @override
  _AddBranchWidgetState createState() => _AddBranchWidgetState();
}

class _AddBranchWidgetState extends State<AddBranchWidget> {
  bool edit = false;
  TextEditingController name;
  TextEditingController address;
  TextEditingController email;
  TextEditingController phone;
  TextEditingController shortName;
  TextEditingController eshortName;
  TextEditingController eName;
  TextEditingController eAddress;
  TextEditingController eEmail;
  TextEditingController ePhone;
  TextEditingController search;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> admins1 = [];
  String dropDownValue;
  String currentId = '';

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

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    shortName = TextEditingController();
    eshortName = TextEditingController();
    address = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    search = TextEditingController();
    eName = TextEditingController();
    eAddress = TextEditingController();
    eEmail = TextEditingController();
    ePhone = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 50,
              ),
              edit == false
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Add Branch',
                                style: FlutterFlowTheme.subtitle1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF151B1E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: name,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Branch Name',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: email,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Branch Email',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: phone,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Mobile',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Mobile',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: shortName,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'short Name',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Mobile',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: address,
                                  obscureText: false,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Branch Address',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (name.text != '' &&
                                      email.text != '' &&
                                      phone.text != '' &&
                                      address.text != '') {
                                    bool pressed = await alert(
                                        context, 'Do you want Add New Branch?');
                                    if (pressed) {
                                      FirebaseFirestore.instance
                                          .collection('branch')
                                          .add({
                                        'name': name.text,
                                        'phone': phone.text,
                                        'address': address.text,
                                        'email': email.text,
                                        'staff': [],
                                        'search': setSearchParam(name.text),
                                        'shortName': shortName.text,
                                      }).then((value) {
                                        value.update({
                                          'branchId': value.id,
                                        });
                                        FirebaseFirestore.instance
                                            .collection('settings')
                                            .doc(value.id)
                                            .set({
                                          'branchId': value.id,
                                          'customerId': 1,
                                          'cashInHand': 0,
                                          'cashAtBank': 0,
                                          'receiptNo': 1,
                                          'projects': 0,
                                          'enquiryId': 0,
                                        });
                                        FirebaseFirestore.instance
                                            .collection('expenseHead')
                                            .doc(value.id)
                                            .set({'expenseHead': []});
                                      });
                                      showUploadMessage(
                                          context, 'New Branch Added...');

                                      setState(() {
                                        name.clear();
                                        phone.clear();
                                        address.clear();
                                        email.clear();
                                      });
                                    }
                                  } else {
                                    name.text == ''
                                        ? showUploadMessage(
                                            context, 'Please Enter Name')
                                        : email.text == ''
                                            ? showUploadMessage(
                                                context, 'Please Enter Email')
                                            : phone.text == ''
                                                ? showUploadMessage(context,
                                                    'Please Enter Phone number')
                                                : shortName.text == ''
                                                    ? showUploadMessage(context,
                                                        'Please Enter short name')
                                                    : showUploadMessage(context,
                                                        'Please Enter Address');
                                  }
                                },
                                text: 'Create  Branch',
                                options: FFButtonOptions(
                                  width: 230,
                                  height: 50,
                                  color: Color(0xff0054FF),
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              edit = false;
                              setState(() {});
                            },
                            text: 'Clear ',
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Edit Branch',
                                style: FlutterFlowTheme.subtitle1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF151B1E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: eName,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Branch Name',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: eEmail,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Branch Email',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: ePhone,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Mobile',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Mobile',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: eshortName,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'short Name',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Mobile',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: eAddress,
                                  obscureText: false,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    hintText: 'Please Enter Branch Address',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (eEmail.text != '' &&
                                      eEmail.text != '' &&
                                      ePhone.text != '' &&
                                      eAddress.text != '') {
                                    bool pressed = await alert(
                                        context, 'Do you want Update Branch?');
                                    if (pressed) {
                                      FirebaseFirestore.instance
                                          .collection('branch')
                                          .doc(currentId)
                                          .update({
                                        'name': eName.text,
                                        'phone': ePhone.text,
                                        'address': eAddress.text,
                                        'email': eEmail.text,
                                        'shortName': eshortName.text,
                                        // 'staff':[],
                                        'search': setSearchParam(eName.text)
                                      });

                                      showUploadMessage(
                                          context, 'Branch Details Updated...');

                                      setState(() {
                                        edit = false;
                                        eName.clear();
                                        ePhone.clear();
                                        eAddress.clear();
                                        eEmail.clear();
                                        eshortName.clear();
                                      });
                                    }
                                  } else {
                                    eName.text == ''
                                        ? showUploadMessage(
                                            context, 'Please Enter Name')
                                        : eEmail.text == ''
                                            ? showUploadMessage(
                                                context, 'Please Enter Email')
                                            : ePhone.text == ''
                                                ? showUploadMessage(context,
                                                    'Please Enter Phone number')
                                                : eshortName.text == ''
                                                    ? showUploadMessage(context,
                                                        'Please Enter short name')
                                                    : showUploadMessage(context,
                                                        'Please Enter Address');
                                  }
                                },
                                text: 'Update Branch',
                                options: FFButtonOptions(
                                  width: 230,
                                  height: 50,
                                  color: Color(0xFF4B39EF),
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 20, 25, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: search,
                        obscureText: false,
                        onChanged: (text) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Search',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          hintText: 'Search Branch',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF252525),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF252525),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 150,
                    ))
                  ],
                ),
              ),
              search.text == ''
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('branch')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data.docs;
                        return SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            horizontalMargin: 20,
                            columns: [
                              DataColumn(
                                label: Text(
                                  "Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text("Mobile",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              DataColumn(
                                label: Text("Email",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              DataColumn(
                                label: Text(""),
                              ),
                              DataColumn(
                                label: Text("Action",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                            rows: List.generate(
                              data.length,
                              (index) {
                                return DataRow(
                                  color: index.isOdd
                                      ? MaterialStateProperty.all(Colors
                                          .blueGrey.shade50
                                          .withOpacity(0.7))
                                      : MaterialStateProperty.all(
                                          Colors.blueGrey.shade50),
                                  cells: [
                                    DataCell(Text(
                                      data[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                                    DataCell(Text(
                                      data[index]['phone'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                                    DataCell(Text(
                                      data[index]['email'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),

                                    DataCell(
                                      Row(
                                        children: [],
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              setState(() {
                                                edit = true;
                                                currentId = data[index].id;

                                                eName.text =
                                                    data[index]['name'];
                                                ePhone.text =
                                                    data[index]['phone'];
                                                eshortName.text =
                                                    data[index]['shortName'];
                                                eEmail.text =
                                                    data[index]['email'];
                                                eAddress.text =
                                                    data[index]['address'];
                                              });
                                            },
                                            text: 'Details',
                                            options: FFButtonOptions(
                                              width: 90,
                                              height: 30,
                                              color: Colors.white,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // DataCell(Text(fileInfo.size)),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      })
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('branch')
                          .where('search',
                              arrayContains: search.text.toUpperCase())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data.docs;
                        return data.length == 0
                            ? Center(
                                child: Text('No Data'),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: DataTable(
                                  horizontalMargin: 20,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text("Mobile",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text("Email",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text(""),
                                    ),
                                    DataColumn(
                                      label: Text("Action",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                  rows: List.generate(
                                    data.length,
                                    (index) {
                                      return DataRow(
                                        color: index.isOdd
                                            ? MaterialStateProperty.all(Colors
                                                .blueGrey.shade50
                                                .withOpacity(0.7))
                                            : MaterialStateProperty.all(
                                                Colors.blueGrey.shade50),
                                        cells: [
                                          DataCell(Text(
                                            data[index]['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
                                          DataCell(Text(
                                            data[index]['phone'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
                                          DataCell(Text(
                                            data[index]['email'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),

                                          DataCell(
                                            Row(
                                              children: [],
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    setState(() {
                                                      edit = true;
                                                      currentId =
                                                          data[index].id;
                                                      eshortName.text =
                                                          data[index]
                                                              ['shortName'];
                                                      eName.text =
                                                          data[index]['name'];
                                                      ePhone.text =
                                                          data[index]['phone'];
                                                      eEmail.text =
                                                          data[index]['email'];
                                                      eAddress.text =
                                                          data[index]
                                                              ['address'];
                                                    });
                                                  },
                                                  text: 'Update',
                                                  options: FFButtonOptions(
                                                    width: 90,
                                                    height: 30,
                                                    color: Colors.white,
                                                    textStyle: FlutterFlowTheme
                                                        .subtitle2
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius: 8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // DataCell(Text(fileInfo.size)),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
