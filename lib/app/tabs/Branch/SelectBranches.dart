import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Login/login.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';

class BranchesWidget extends StatefulWidget {
  const BranchesWidget({Key? key}) : super(key: key);

  @override
  _BranchesWidgetState createState() => _BranchesWidgetState();
}

class _BranchesWidgetState extends State<BranchesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List branches = [];

  getBranch() {
    FirebaseFirestore.instance
        .collection('branch')
        .where('staff', arrayContains: currentUserEmail)
        .snapshots()
        .listen((event) async {
      branches = event.docs;

      if (event.docs.length == 1) {
        final SharedPreferences localStorage =
            await SharedPreferences.getInstance();

        localStorage.setString('branchId', event.docs.first.id);
        localStorage.setString('branchName', event.docs.first['name']);
        localStorage.setString('shortName', event.docs.first['shortName']);
        localStorage.setString('address', event.docs.first['address']);
        localStorage.setString('phone', event.docs.first['phone']);

        currentBranchId = localStorage.getString('branchId')!;
        currentbranchName = localStorage.getString('branchName')!;
        currentbranchShortName = localStorage.getString('shortName')!;
        currentbranchAddress = localStorage.getString('address')!;
        currentbranchphoneNumber = localStorage.getString('phone')!;

        if(mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (mainContext) => Home()),
          );
        }
      }

      if (mounted) {
        setState(() {});
      }
    });
  }
  getUser()  {

    FirebaseFirestore.instance.collection('admin_users').doc(currentUserUid).snapshots().listen((event) {

      currentUserRole=event['role'];
      currentUserEmail=event['email'];
      currentUserPermission=event['verified'];

      getBranch();
      if(mounted){
        setState(() {


        });
      }

    });
  }

  @override
  void initState() {
    super.initState();
    getUser();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Select Branch',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 5),
            child: FlutterFlowIconButton(
              borderColor: Color(0xFFC2C2C2),
              borderRadius: 12,
              borderWidth: 1,
              buttonSize: 60,
              fillColor: Colors.white,
              icon: Icon(
                Icons.logout,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text('Logout !'),
                      content: Text('Do you Want to Logout ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(alertDialogContext),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(alertDialogContext);
                            await  FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPageWidget()),
                                (route) => false);
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                  children: List.generate(branches.length, (index) {
                final branch = branches[index];
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(60, 8, 60, 0),
                  child: InkWell(
                    onTap: () async {
                      final SharedPreferences localStorage =
                          await SharedPreferences.getInstance();

                      localStorage.setString('branchId', branch.id);
                      localStorage.setString('branchName', branch['name']);
                      localStorage.setString('shortName', branch['shortName']);
                      localStorage.setString('address', branch['address']);
                      localStorage.setString('phone', branch['phone']);

                      currentBranchId = localStorage.getString('branchId')!;
                      currentbranchName = localStorage.getString('branchName')!;
                      currentbranchAddress = localStorage.getString('address')!;
                      currentbranchShortName =
                          localStorage.getString('shortName')!;
                      currentbranchphoneNumber =
                          localStorage.getString('phone')!;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (mainContext) => Home()),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFF4B39EF),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0x39000000),
                                    offset: Offset(0, 1),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: AutoSizeText(
                                      branch['name'],
                                      textAlign: TextAlign.center,
                                      style:
                                          FlutterFlowTheme.subtitle1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 4, 8, 0),
                                    child: Text(
                                      'Address : ${branch['address']}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        'Lexend Deca',
                                        color: Color(0xB3FFFFFF),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 4, 8, 0),
                                    child: Text(
                                      'Phone : ${branch['phone']}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        'Lexend Deca',
                                        color: Color(0xB3FFFFFF),
                                        fontSize: 12,
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
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
