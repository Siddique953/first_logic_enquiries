
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_erp/app/pages/home_page/home.dart';
import 'package:fl_erp/flutter_flow/upload_media.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/tabs/Branch/AddBranch.dart';
import '../app/tabs/Branch/SelectBranches.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
 late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  bool passwordVisibility=false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility = false;

    if(kDebugMode) {
      emailTextController.text='siddique@firstlogicmetalab.com';
      passwordTextController.text='abu@meta953';
    }
    
    // FirebaseAuth.instance.signInWithEmailAndPassword(email: 'admin@gmail.com', password: '123456');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
          child: Material(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                      ),
                      child: Center(child: LottieBuilder.network('https://assets5.lottiefiles.com/packages/lf20_4vlxeulb.json',fit: BoxFit.cover,)),

                    )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                    child: Container(



                      decoration: BoxDecoration(
                        color: Colors.white,

                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: SizedBox()),
                          Center(
                            child: Text('Sign in',style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.04,color: Colors.black,fontWeight: FontWeight.w500
                            ),),
                          ),

                          Center(
                            child: Container(
                              height: 3,
                              width: MediaQuery.of(context).size.width*0.05,
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          TextFormField(
                            controller: emailTextController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: FlutterFlowTheme.bodyText1,
                              hintText: 'Enter UserName',
                              hintStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff062944),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff062944),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: FlutterFlowTheme.bodyText1,
                          ),
                          Expanded(child: SizedBox()),
                          TextFormField(
                            controller: passwordTextController,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: FlutterFlowTheme.bodyText1,
                              hintText: 'Enter Password',
                              hintStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff062944),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff062944),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                      () => passwordVisibility =
                                  !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.black,
                                  size: 22,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                          ),
                          Expanded(child: SizedBox()),

                          Center(
                            child: FFButtonWidget(
                              onPressed: () async {
                                ogPass = passwordTextController.text;
                                ogUser = emailTextController.text;
                                if(ogUser.trim().isEmpty){
                                  return showUploadMessage(context, 'please Enter Mail Address');
                                }
                                if(ogPass.trim().isEmpty){
                                  return showUploadMessage(context, 'please Enter Password');
                                }

                                else {
                                  try {
                                    FirebaseFirestore.instance.collection('admin_users')
                                        .where('email',isEqualTo: ogUser.trim())
                                        .get()
                                        .then((value) async {
                                      if(value.docs.isEmpty) {
                                        return showUploadMessage(context, 'There is no User Existed');
                                      } else {

                                        if(value.docs[0]['delete'] == true) {
                                          return showUploadMessage(context, 'User is Deleted.');
                                        }

                                        if(value.docs[0]['password'] != ogPass.trim()) {
                                          return showUploadMessage(context, 'Incorrect Password');
                                        } else {
                                          currentUserEmail = ogPass;

                                          currentUserUid = value.docs[0]['uid'];
                                          final prefs = await SharedPreferences.getInstance();
                                          prefs.setString('uid', currentUserUid);

                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BranchesWidget(),
                                            ),
                                                (r) => false,
                                          );
                                        }
                                      }
                                    });
                                  } catch (e) {

                                    showUploadMessage(context, e.toString());

                                  }
                                }

                              },
                              text: 'Sign In',
                              loading: false,
                              options: FFButtonOptions(

                                width: MediaQuery.of(context).size.width*0.13,
                                height: MediaQuery.of(context).size.height*0.05,
                                color: Color(0xff062944),
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                                elevation: 5,
                                borderSide: BorderSide(
                                  color: Colors.blue.shade500,
                                  width: 2,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
