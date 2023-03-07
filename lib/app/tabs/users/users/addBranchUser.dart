import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_erp/backend/backend.dart';

import 'package:flutter/services.dart';

import '../../../../auth/email_auth.dart';
import '../../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

import '../../../../flutter_flow/upload_media.dart';
import '../../../app_widget.dart';
import '../../../pages/home_page/home.dart';
import '../../Branch/AddBranch.dart';

class CreateUsersWidget extends StatefulWidget {
  const CreateUsersWidget({Key key}) : super(key: key);

  @override
  _CreateUsersWidgetState createState() => _CreateUsersWidgetState();
}

class _CreateUsersWidgetState extends State<CreateUsersWidget> {
  String uploadedFileUrl = '';
  String userSelectValue;
  String editUserRole;
  TextEditingController name;
  TextEditingController email;
  TextEditingController password;
  TextEditingController branch;
  TextEditingController phone;

  TextEditingController editName;
  TextEditingController editEmail;
  TextEditingController editPassword;
  TextEditingController editBranch;
  TextEditingController editPhone;

  String selectedBranch = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final auth = FirebaseAuth.instance;

  List<String> listOfBranchUsers = [];

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    branch = TextEditingController();

    editName = TextEditingController();
    editEmail = TextEditingController();
    editPassword = TextEditingController();
    editPhone = TextEditingController();
    editBranch = TextEditingController();

    if (currentUserRole == 'Super Admin') {
      listOfBranchUsers = [
        'Super Admin',
        'Branch Admin',
        'Accountant',
        'HR',
        'Customer Management',
      ];
    } else {
      listOfBranchUsers = [
        'Branch Admin',
        'Accountant',
        'HR',
        'Customer Management',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (branches.length == 1) {
      branch.text = branches[0];
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Create User',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Color(0xFF14181B),
            fontSize: 28,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // uploadedFileUrl==''?
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.photo_camera,
                              color: Colors.black,
                              size: 35,
                            ),
                            onPressed: () async {
                              final selectedMedia = await selectMedia(
                                mediaSource: MediaSource.photoGallery,
                              );
                              if (selectedMedia != null &&
                                  validateFileFormat(
                                      selectedMedia.storagePath, context)) {
                                showUploadMessage(context, 'Uploading file...',
                                    showLoading: true);
                                final metadata = SettableMetadata(
                                  contentType: 'image/jpeg',
                                  customMetadata: {
                                    'picked-file-path':
                                        selectedMedia.storagePath
                                  },
                                );
                                print(metadata.contentType);
                                final uploadSnap = await FirebaseStorage
                                    .instance
                                    .ref()
                                    .child(DateTime.now()
                                        .toLocal()
                                        .toString()
                                        .substring(0, 10))
                                    .child(DateTime.now()
                                        .toLocal()
                                        .toString()
                                        .substring(10, 17))
                                    .putData(selectedMedia.bytes, metadata);
                                final downloadUrl =
                                    await uploadSnap.ref.getDownloadURL();
                                // final downloadUrl = await uploadData(
                                //     selectedMedia.storagePath, selectedMedia.bytes);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                if (downloadUrl != null) {
                                  setState(() => uploadedFileUrl = downloadUrl);
                                  showUploadMessage(context, 'Success!');
                                } else {
                                  showUploadMessage(
                                      context, 'Failed to upload media');
                                  return;
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                        child: TextFormField(
                          controller: name,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: FlutterFlowTheme.title3.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF57636C),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                          ),
                          style: FlutterFlowTheme.bodyText1,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: FlutterFlowTheme.title3.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF57636C),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                          ),
                          style: FlutterFlowTheme.subtitle2,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10)
                          ],
                          controller: password,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: FlutterFlowTheme.title3.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF57636C),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                          ),
                          style: FlutterFlowTheme.bodyText1,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                        child: TextFormField(
                          controller: phone,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10)
                          ],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: FlutterFlowTheme.title3.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF57636C),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFB2B4B7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                          ),
                          style: FlutterFlowTheme.bodyText1,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    currentUserRole == 'Super Admin'
                        ? Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFB2B4B7),
                                  ),
                                ),
                                child: CustomDropdown.search(
                                  hintText: 'Select branch',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  items: branches,
                                  controller: branch,
                                  // excludeSelected: false,
                                  onChanged: (text) {
                                    print(
                                        '[[[[[[[[[[[[[[[[[[[[[[[[[[[[text]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
                                    print(text);
                                    print(branchNameMap[text]);
                                    print(currentBranchId);
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                        child: FlutterFlowDropDown(
                          initialOption: userSelectValue ?? 'Branch Admin',
                          options: listOfBranchUsers,
                          onChanged: (val) =>
                              setState(() => userSelectValue = val),
                          width: double.infinity,
                          height: 60,
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Select User',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF57636C),
                            size: 15,
                          ),
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Color(0xFFB2B4B7),
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(24, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                    ),
                    //branch

                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          print(currentbranchName +
                              ' ?????????????????????????????????????????????');

                          if (name.text != '' &&
                              email.text != '' &&
                              password.text != '' &&
                              phone.text != '' &&
                              userSelectValue != '') {
                            try {
                              print('1');
                              UserCredential newUser = await auth
                                  .createUserWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text)
                                  .onError((FirebaseAuthException error,
                                      stackTrace) {
                                showUploadMessage(context, error.message);
                                return;
                              });
                              print('2');
                              await FirebaseAuth.instance.signOut();
                              print('3');
                              // final user =
                              signInWithEmail(context, ogUser, ogPass);
                              print('4');
                              print(newUser);
                              if (newUser != null) {
                                await FirebaseFirestore.instance
                                    .collection('admin_users')
                                    .doc(newUser.user.uid)
                                    .set({
                                  'name': name.text,
                                  'email': email.text,
                                  'password': password.text,
                                  'createdDate': FieldValue.serverTimestamp(),
                                  'phone': phone.text,
                                  'branchId': branchNameMap[branch.text],
                                  'branchName': branch.text,
                                  'role': userSelectValue,
                                  'photo_url': uploadedFileUrl,
                                  'uid': newUser.user.uid,
                                  'verified': true,
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection('branch')
                                      .doc(branchNameMap[branch.text])
                                      .update({
                                    'staff':
                                        FieldValue.arrayUnion([email.text]),
                                  }).whenComplete(() {
                                    print(branchNameMap[branch.text]);

                                    showUploadMessage(
                                        context, 'User added successfully');
                                    name.text = '';
                                    phone.text = '';
                                    email.text = '';
                                    branch.text = '';
                                    password.text = '';
                                    userSelectValue = '';
                                    uploadedFileUrl = '';
                                  });
                                });
                              }
                            } catch (e) {}
                          } else {
                            name.text == ''
                                ? showUploadMessage(
                                    context, 'Please enter user name')
                                : phone.text == ''
                                    ? showUploadMessage(
                                        context, 'Please enter  mobile number')
                                    : email.text == ''
                                        ? showUploadMessage(
                                            context, 'Please enter  emailId')
                                        : password.text == ''
                                            ? showUploadMessage(context,
                                                'Please enter  password')
                                            : showUploadMessage(
                                                context, 'Please choose role');
                          }
                        },
                        text: 'Create',
                        options: FFButtonOptions(
                          width: 130,
                          height: 60,
                          color: Color(0xff0054FF),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            'Phone Number',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            'Branch',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            'Role',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('admin_users')
                          .where('branchId', isEqualTo: currentBranchId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var user = snapshot.data.docs;
                        return ListView.builder(
                            itemCount: user.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  color: Colors.grey[200],
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      user[index]['photo_url'] != ''
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: user[index]
                                                      ['photo_url'],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                            ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: Text(
                                            user[index]['name'] ?? '',
                                          )),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: Text(
                                            user[index]['email'] ?? '',
                                          )),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Text(
                                            user[index]['phone'] ?? '',
                                          )),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Text(
                                            user[index]['branchName'] ?? '',
                                          )),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Text(
                                            user[index]['role'] ?? '',
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: InkWell(
                                            onTap: () async {
                                              if (currentUserRole ==
                                                  'Super Admin') {
                                                bool pressed = await alert(
                                                    context,
                                                    'Change User Access');

                                                if (pressed) {
                                                  user[index]['verified'] ==
                                                          true
                                                      ? FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'admin_users')
                                                          .doc(user[index].id)
                                                          .update({
                                                          'verified': false,
                                                        })
                                                      : FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'admin_users')
                                                          .doc(user[index].id)
                                                          .update({
                                                          'verified': true,
                                                        });

                                                  print(branchNameMap[
                                                      branch.text]);
                                                  user[index]['verified'] ==
                                                          true
                                                      ? FirebaseFirestore
                                                          .instance
                                                          .collection('branch')
                                                          .doc(branchNameMap[
                                                                  branch
                                                                      .text] ??
                                                              currentBranchId)
                                                          .update({
                                                          'staff': FieldValue
                                                              .arrayRemove([
                                                            user[index]['email']
                                                          ]),
                                                        })
                                                      : FirebaseFirestore
                                                          .instance
                                                          .collection('branch')
                                                          .doc(branchNameMap[
                                                                  branch
                                                                      .text] ??
                                                              currentBranchId)
                                                          .update({
                                                          'staff': FieldValue
                                                              .arrayUnion([
                                                            user[index]['email']
                                                          ]),
                                                        });
                                                }
                                              } else {
                                                showUploadMessage(context,
                                                    'You are not authorised');
                                              }
                                              // a
                                              // // editName.text=user[index]['name'];
                                              // // editEmail.text=user[index]['email'];
                                              // // editPhone.text=user[index]['phone'];
                                              // // editUserRole=user[index]['role'];
                                              // // editBranch.text=user[index]['branchName'];
                                              // // showDialog<String>(
                                              // //     context: context,
                                              // //     builder: (BuildContext context) => AlertDialog(
                                              // //       title: const Text('Edit User Details?'),
                                              // //       content: Container(
                                              // //         height: MediaQuery.of(context).size.height*0.6,
                                              // //         child: Column(
                                              // //           children: [
                                              // //
                                              // //             Padding(
                                              // //               padding: const EdgeInsets.all(8.0),
                                              // //               child: Container(
                                              // //                 height:40,
                                              // //                 width: MediaQuery.of(context).size.width*0.2,
                                              // //                 decoration: BoxDecoration(
                                              // //                     color: Colors.grey[100],
                                              // //                   borderRadius: BorderRadius.circular(10)
                                              // //                 ),
                                              // //                 child: Padding(
                                              // //                   padding: const EdgeInsets.all(8.0),
                                              // //                   child: TextFormField(
                                              // //                     controller: editName,
                                              // //                     decoration: InputDecoration(
                                              // //                       hintText: 'User name'
                                              // //                     ),
                                              // //                   ),
                                              // //                 ),
                                              // //               ),
                                              // //             ),
                                              // //             Padding(
                                              // //               padding: const EdgeInsets.all(8.0),
                                              // //               child: Container(
                                              // //                 height:40,
                                              // //                 decoration: BoxDecoration(
                                              // //                     color: Colors.grey[100],
                                              // //                     borderRadius: BorderRadius.circular(10)
                                              // //                 ),
                                              // //                 width: MediaQuery.of(context).size.width*0.2,
                                              // //                 child: Padding(
                                              // //                   padding: const EdgeInsets.all(8.0),
                                              // //                   child: TextFormField(
                                              // //                     controller: editEmail,
                                              // //                     decoration: InputDecoration(
                                              // //                       hintText: 'Email'
                                              // //                     ),
                                              // //                   ),
                                              // //                 ),
                                              // //               ),
                                              // //             ),
                                              // //             Padding(
                                              // //               padding: const EdgeInsets.all(8.0),
                                              // //               child: Container(
                                              // //                 height:40,
                                              // //                 decoration: BoxDecoration(
                                              // //                     color: Colors.grey[100],
                                              // //                     borderRadius: BorderRadius.circular(10)
                                              // //                 ),
                                              // //                 width: MediaQuery.of(context).size.width*0.2,
                                              // //                 child: Padding(
                                              // //                   padding: const EdgeInsets.all(8.0),
                                              // //                   child: TextFormField(
                                              // //                     controller: editPassword,
                                              // //                     decoration: InputDecoration(
                                              // //                       hintText: 'Password'
                                              // //                     ),
                                              // //                   ),
                                              // //                 ),
                                              // //               ),
                                              // //             ),
                                              // //             Padding(
                                              // //               padding: const EdgeInsets.all(8.0),
                                              // //               child: Container(
                                              // //                 height:40,
                                              // //                 decoration: BoxDecoration(
                                              // //                     color: Colors.grey[100],
                                              // //                     borderRadius: BorderRadius.circular(10)
                                              // //                 ),
                                              // //                 width: MediaQuery.of(context).size.width*0.2,
                                              // //                 child: Padding(
                                              // //                   padding: const EdgeInsets.all(8.0),
                                              // //                   child: TextFormField(
                                              // //                     controller: editPhone,
                                              // //                     decoration: InputDecoration(
                                              // //                       hintText: 'Phone Number'
                                              // //                     ),
                                              // //                   ),
                                              // //                 ),
                                              // //               ),
                                              // //             ),
                                              // //             Padding(
                                              // //               padding: const EdgeInsets.all(8.0),
                                              // //               child: Container(
                                              // //                 height:40,
                                              // //                 decoration: BoxDecoration(
                                              // //                     color: Colors.grey[100],
                                              // //                     borderRadius: BorderRadius.circular(10)
                                              // //                 ),
                                              // //                 width: MediaQuery.of(context).size.width*0.2,
                                              // //                 child: FlutterFlowDropDown(
                                              // //                   initialOption: editUserRole??'Branch Admin',
                                              // //                   options: ['Super Admin', 'Branch Admin', 'Councilor','Reception'],
                                              // //                   onChanged: (val) => setState(() => editUserRole = val),
                                              // //                   width: double.infinity,
                                              // //                   height: 60,
                                              // //                   textStyle:
                                              // //                   FlutterFlowTheme.bodyText1.override(
                                              // //                     fontFamily: 'Poppins',
                                              // //                     color: Color(0xFF14181B),
                                              // //                     fontSize: 14,
                                              // //                     fontWeight: FontWeight.normal,
                                              // //                   ),
                                              // //                   hintText: 'Select User',
                                              // //                   icon: Icon(
                                              // //                     Icons.keyboard_arrow_down_rounded,
                                              // //                     color: Color(0xFF57636C),
                                              // //                     size: 15,
                                              // //                   ),
                                              // //                   fillColor: Colors.white,
                                              // //                   elevation: 2,
                                              // //                   borderColor: Color(0xFFB2B4B7),
                                              // //                   borderWidth: 1,
                                              // //                   borderRadius: 8,
                                              // //                   margin: EdgeInsetsDirectional.fromSTEB(24, 4, 12, 4),
                                              // //                   hidesUnderline: true,
                                              // //                 ),
                                              // //               ),
                                              // //             ),
                                              // //
                                              // //           ],
                                              // //         ),
                                              // //       ),
                                              // //       actions: <Widget>[
                                              // //         TextButton(
                                              // //           onPressed: () => Navigator.pop(context, 'Cancel'),
                                              // //           child: const Text('Cancel'),
                                              // //         ),
                                              // //         TextButton(
                                              // //           onPressed: (){
                                              // //             FirebaseFirestore.instance.collection('admin_users').doc(user[index].id).update({
                                              // //               'name':editName.text,
                                              // //               'phone':editPhone.text,
                                              // //               'email':editEmail.text,
                                              // //               'role':editUserRole,
                                              // //               'branchName':editBranch.text,
                                              // //               'branchId':branchNameMap[editBranch.text],
                                              // //
                                              // //             });
                                              // //             Navigator.pop(context, 'Cancel');
                                              // //             showUploadMessage(context, 'selected users edited successfully');
                                              // //           },
                                              // //           child: const Text('OK'),
                                              // //         ),
                                              // //       ],
                                              // //     )
                                              // // );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                user[index]['verified'] == true
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                        size: 30,
                                                      )
                                                    : Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                        size: 30,
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
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
