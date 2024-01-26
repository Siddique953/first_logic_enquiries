import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../app_widget.dart';
import '../../../pages/home_page/home.dart';

class CreateUsersWidget extends StatefulWidget {
  const CreateUsersWidget({Key? key}) : super(key: key);

  @override
  _CreateUsersWidgetState createState() => _CreateUsersWidgetState();
}

class _CreateUsersWidgetState extends State<CreateUsersWidget> {
  String uploadedFileUrl = '';
  String userSelectValue = '';
  String editUserRole = '';
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController branch;
  late TextEditingController phone;
  late TextEditingController editName;
  late TextEditingController editEmail;
  late TextEditingController editPassword;
  late TextEditingController editBranch;
  late TextEditingController editPhone;

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                  showUploadMessage(
                                      context, 'Uploading file...',
                                      showLoading: true);

                                  final metadata = SettableMetadata(
                                    contentType: 'image/jpeg',
                                    customMetadata: {
                                      'picked-file-path':
                                          selectedMedia.storagePath
                                    },
                                  );
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
                                    setState(
                                        () => uploadedFileUrl = downloadUrl);
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
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: name,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Name',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 350,
                                height: 60,
                                color: Colors.white,
                                padding: EdgeInsets.only(right: 10),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: phone,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter phone number";
                                      } else if (!RegExp(
                                              r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(value)) {
                                        return "phone number is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Phone',
                                        labelStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                        hintText: 'Please Enter Phone',
                                        hintStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                        errorBorder: errorOutlineInputBOrder,
                                        border: outlineInputBorder,
                                        disabledBorder: outlineInputBorder,
                                        focusedErrorBorder:
                                            errorOutlineInputBOrder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder),
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                child: FlutterFlowDropDown(
                                  initialOption: userSelectValue ?? 'Councilor',
                                  options: currentUserRole == 'Super Admin'
                                      ? [
                                          'Super Admin',
                                          'Branch Admin',
                                          'HR',
                                          'Councilor',
                                          'Reception',
                                          'Accounts',
                                        ]
                                      : [
                                          'Branch Admin',
                                          'HR',
                                          'Councilor',
                                          'Reception',
                                          'Accounts',
                                        ],
                                  onChanged: (val) =>
                                      setState(() => userSelectValue = val),
                                  width: double.infinity,
                                  height: 60,
                                  textStyle:
                                      FlutterFlowTheme.bodyText1.override(
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
                                  borderColor: Colors.grey,
                                  borderWidth: 1,
                                  borderRadius: 8,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      24, 4, 12, 4),
                                  hidesUnderline: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                height: 60,
                                child: TextFormField(
                                  controller: email,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) {
                                    if (email!.isEmpty) {
                                      return "Enter your email";
                                    } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                        .hasMatch(email)) {
                                      return "Email not valid";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Email',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      errorBorder: errorOutlineInputBOrder,
                                      border: outlineInputBorder,
                                      disabledBorder: outlineInputBorder,
                                      focusedErrorBorder:
                                          errorOutlineInputBOrder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: outlineInputBorder),
                                  style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                width: 350,
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: password,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter password number";
                                      } else if (value.length < 6) {
                                        return "password length must be more than six characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                        hintText: 'Please Enter Password',
                                        hintStyle: FlutterFlowTheme.bodyText2
                                            .override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                        errorBorder: errorOutlineInputBOrder,
                                        border: outlineInputBorder,
                                        disabledBorder: outlineInputBorder,
                                        focusedErrorBorder:
                                            errorOutlineInputBOrder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder),
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          currentUserRole == 'Super Admin'
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: CustomDropdown.search(
                                        hintText: 'Select branch',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        items: branches,
                                        controller: branch,
                                        // excludeSelected: false,
                                        onChanged: (text) {
                                          // setState(() {
                                          // addBranchId =
                                          //     branchNameMap[branch.text];
                                          // });
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                print(
                                    '[[[[[[[[[[[[[[[[[[[ogPass]]]]]]]]]]]]]]]]]]]');
                                if (name.text != '' &&
                                    email.text != '' &&
                                    password.text != '' &&
                                    phone.text != '' &&
                                    userSelectValue != '') {
                                  try {

                                    final doc = FirebaseFirestore.instance.collection('admin_users').doc();

                                      doc.set({
                                        'branchName': currentbranchName,
                                        'branchId': currentBranchId,
                                        'createdDate':
                                            FieldValue.serverTimestamp(),
                                        'name': name.text,
                                        'email': email.text,
                                        'password': password.text,
                                        'phone': phone.text,
                                        'delete':false,
                                        'photo_url': uploadedFileUrl,
                                        'role': userSelectValue,
                                        'uid': doc.id,
                                        'verified': true,
                                      }).then((value) {
                                        FirebaseFirestore.instance
                                            .collection('branch')
                                            .doc(currentBranchId)
                                            .update({
                                          'staff': FieldValue.arrayUnion(
                                              [email.text]),
                                        });
                                        showUploadMessage(
                                            context, 'User added successfully');
                                        name.text = '';
                                        phone.text = '';
                                        email.text = '';
                                        password.text = '';
                                        userSelectValue = '';
                                        uploadedFileUrl = '';
                                      });

                                  } catch (e) {
                                      showUploadMessage(context, e.toString());
                                      return null;
                                    }

                                } else {
                                  name.text == ''
                                      ? showUploadMessage(
                                          context, 'Please enter user name')
                                      : email.text == ''
                                          ? showUploadMessage(
                                              context, 'Please enter  emailId')
                                          : password.text == ''
                                              ? showUploadMessage(context,
                                                  'Please enter  password')
                                              : phone.text == ''
                                                  ? showUploadMessage(context,
                                                      'Please enter  mobile number')
                                                  : showUploadMessage(context,
                                                      'Please choose role');
                                }
                              },
                              text: 'Create',
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color: Colors.teal,
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('admin_users')
                      .where('branchId', isEqualTo: currentBranchId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var user = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          horizontalMargin: 10,
                          columnSpacing: 20,
                          columns: [
                            DataColumn(
                              label: Text(
                                "Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Phone Number",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Role",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Access",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Action",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            user!.docs.length,
                            (index) {
                              DocumentSnapshot data = user!.docs[index];

                              return DataRow(
                                color: index.isOdd
                                    ? MaterialStateProperty.all(Colors
                                        .blueGrey.shade50
                                        .withOpacity(0.7))
                                    : MaterialStateProperty.all(
                                        Colors.blueGrey.shade50),
                                cells: [
                                  DataCell(SelectableText(
                                    data['name'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(Text(
                                    data['email'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    data['phone'],
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    data['role'] ?? '',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(SelectableText(
                                    data['verified'] == true
                                        ? 'Verified'
                                        : 'Block',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: data['verified'] == true
                                          ? Colors.black
                                          : Colors.red,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(InkWell(
                                    onTap: () {
                                      ///Edit
                                      //
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.teal,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'View',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                    //   ListView.builder(
                    //   itemCount: user.length,
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemBuilder: (context,int index){
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           width: double.infinity,
                    //           height: 50,
                    //           color: Colors.grey[200],
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             children: [
                    //               user[index]['photo_url']!=''?
                    //               Container(width: MediaQuery.of(context).size.width*0.08, child: Center(child: CachedNetworkImage(imageUrl:user[index]['photo_url'],)))
                    //                   :Container(width: MediaQuery.of(context).size.width*0.08,),
                    //               Container(width: MediaQuery.of(context).size.width*0.15,child: Text(user[index]['display_name']??'',)),
                    //               Container(width: MediaQuery.of(context).size.width*0.15,child: Text(user[index]['email']??'',)),
                    //               Container(width: MediaQuery.of(context).size.width*0.1,child: Text(user[index]['mobileNumber']??'',)),
                    //               Container(width: MediaQuery.of(context).size.width*0.1,child: Text(user[index]['branchName']??'',)),
                    //               Container(width: MediaQuery.of(context).size.width*0.1,child: Text(user[index]['role']??'',)),
                    //               Container(
                    //                   width: MediaQuery.of(context).size.width*0.05,
                    //                   height: 30,
                    //                   decoration:BoxDecoration(
                    //                       color: Colors.teal,
                    //                     borderRadius: BorderRadius.circular(10)
                    //                   ),
                    //                   child: InkWell(
                    //                     onTap:(){
                    //
                    //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UserAttendance(
                    //                         staffId:user[index].id,
                    //                         staffName:user[index]['display_name']
                    //
                    //                       )));
                    //
                    //                     },
                    //                       child: Center(child:
                    //                       Text('View',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                    //                       )
                    //                   ) ,
                    //               ),
                    //               Container(
                    //                 width: MediaQuery.of(context).size.width*0.05,
                    //                 decoration: BoxDecoration(
                    //                     // color: Color(0xFF4B39EF),
                    //                   borderRadius: BorderRadius.circular(10)
                    //                 ),
                    //                 child:Padding(
                    //                   padding: const EdgeInsets.all(5.0),
                    //                   child: InkWell(
                    //                     onTap: () async {
                    //
                    //                       bool pressed=await alert(context, 'Change User Access');
                    //
                    //                     if(pressed){
                    //                       user[index]['verified'] ==true?
                    //                       FirebaseFirestore.instance.collection('admin_users').doc(user[index].id).update({
                    //                         'verified':false,
                    //                       })
                    //                           :FirebaseFirestore.instance.collection('admin_users').doc(user[index].id).update({
                    //                         'verified':true,
                    //                       });
                    //                     }
                    //
                    //
                    //                       // editName.text=user[index]['display_name'];
                    //                       // editEmail.text=user[index]['email'];
                    //                       // editPhone.text=user[index]['mobileNumber'];
                    //                       // editUserRole=user[index]['role'];
                    //                       // editBranch.text=user[index]['branchName'];
                    //                       // showDialog<String>(
                    //                       //     context: context,
                    //                       //     builder: (BuildContext context) => AlertDialog(
                    //                       //       title: const Text('Edit User Details?'),
                    //                       //       content: Container(
                    //                       //         height: MediaQuery.of(context).size.height*0.6,
                    //                       //         child: Column(
                    //                       //           children: [
                    //                       //
                    //                       //             Padding(
                    //                       //               padding: const EdgeInsets.all(8.0),
                    //                       //               child: Container(
                    //                       //                 height:40,
                    //                       //                 width: MediaQuery.of(context).size.width*0.2,
                    //                       //                 decoration: BoxDecoration(
                    //                       //                     color: Colors.grey[100],
                    //                       //                   borderRadius: BorderRadius.circular(10)
                    //                       //                 ),
                    //                       //                 child: Padding(
                    //                       //                   padding: const EdgeInsets.all(8.0),
                    //                       //                   child: TextFormField(
                    //                       //                     controller: editName,
                    //                       //                     decoration: InputDecoration(
                    //                       //                       hintText: 'User name'
                    //                       //                     ),
                    //                       //                   ),
                    //                       //                 ),
                    //                       //               ),
                    //                       //             ),
                    //                       //             Padding(
                    //                       //               padding: const EdgeInsets.all(8.0),
                    //                       //               child: Container(
                    //                       //                 height:40,
                    //                       //                 decoration: BoxDecoration(
                    //                       //                     color: Colors.grey[100],
                    //                       //                     borderRadius: BorderRadius.circular(10)
                    //                       //                 ),
                    //                       //                 width: MediaQuery.of(context).size.width*0.2,
                    //                       //                 child: Padding(
                    //                       //                   padding: const EdgeInsets.all(8.0),
                    //                       //                   child: TextFormField(
                    //                       //                     controller: editEmail,
                    //                       //                     decoration: InputDecoration(
                    //                       //                       hintText: 'Email'
                    //                       //                     ),
                    //                       //                   ),
                    //                       //                 ),
                    //                       //               ),
                    //                       //             ),
                    //                       //             Padding(
                    //                       //               padding: const EdgeInsets.all(8.0),
                    //                       //               child: Container(
                    //                       //                 height:40,
                    //                       //                 decoration: BoxDecoration(
                    //                       //                     color: Colors.grey[100],
                    //                       //                     borderRadius: BorderRadius.circular(10)
                    //                       //                 ),
                    //                       //                 width: MediaQuery.of(context).size.width*0.2,
                    //                       //                 child: Padding(
                    //                       //                   padding: const EdgeInsets.all(8.0),
                    //                       //                   child: TextFormField(
                    //                       //                     controller: editPassword,
                    //                       //                     decoration: InputDecoration(
                    //                       //                       hintText: 'Password'
                    //                       //                     ),
                    //                       //                   ),
                    //                       //                 ),
                    //                       //               ),
                    //                       //             ),
                    //                       //             Padding(
                    //                       //               padding: const EdgeInsets.all(8.0),
                    //                       //               child: Container(
                    //                       //                 height:40,
                    //                       //                 decoration: BoxDecoration(
                    //                       //                     color: Colors.grey[100],
                    //                       //                     borderRadius: BorderRadius.circular(10)
                    //                       //                 ),
                    //                       //                 width: MediaQuery.of(context).size.width*0.2,
                    //                       //                 child: Padding(
                    //                       //                   padding: const EdgeInsets.all(8.0),
                    //                       //                   child: TextFormField(
                    //                       //                     controller: editPhone,
                    //                       //                     decoration: InputDecoration(
                    //                       //                       hintText: 'Phone Number'
                    //                       //                     ),
                    //                       //                   ),
                    //                       //                 ),
                    //                       //               ),
                    //                       //             ),
                    //                       //             Padding(
                    //                       //               padding: const EdgeInsets.all(8.0),
                    //                       //               child: Container(
                    //                       //                 height:40,
                    //                       //                 decoration: BoxDecoration(
                    //                       //                     color: Colors.grey[100],
                    //                       //                     borderRadius: BorderRadius.circular(10)
                    //                       //                 ),
                    //                       //                 width: MediaQuery.of(context).size.width*0.2,
                    //                       //                 child: CustomDropdown.search(
                    //                       //                   hintText: 'Select branch',
                    //                       //                   items: branches,
                    //                       //                   controller: editBranch,
                    //                       //                   // excludeSelected: false,
                    //                       //                   onChanged: (text){
                    //                       //                     setState(() {
                    //                       //
                    //                       //                     });
                    //                       //
                    //                       //                   },
                    //                       //                 ),
                    //                       //               ),
                    //                       //             ),
                    //                       //             Padding(
                    //                       //               padding: const EdgeInsets.all(8.0),
                    //                       //               child: Container(
                    //                       //                 height:40,
                    //                       //                 decoration: BoxDecoration(
                    //                       //                     color: Colors.grey[100],
                    //                       //                     borderRadius: BorderRadius.circular(10)
                    //                       //                 ),
                    //                       //                 width: MediaQuery.of(context).size.width*0.2,
                    //                       //                 child: FlutterFlowDropDown(
                    //                       //                   initialOption: editUserRole??'Branch Admin',
                    //                       //                   options: ['Super Admin', 'Branch Admin', 'Councilor','Reception'],
                    //                       //                   onChanged: (val) => setState(() => editUserRole = val),
                    //                       //                   width: double.infinity,
                    //                       //                   height: 60,
                    //                       //                   textStyle:
                    //                       //                   FlutterFlowTheme.bodyText1.override(
                    //                       //                     fontFamily: 'Poppins',
                    //                       //                     color: Color(0xFF14181B),
                    //                       //                     fontSize: 14,
                    //                       //                     fontWeight: FontWeight.normal,
                    //                       //                   ),
                    //                       //                   hintText: 'Select User',
                    //                       //                   icon: Icon(
                    //                       //                     Icons.keyboard_arrow_down_rounded,
                    //                       //                     color: Color(0xFF57636C),
                    //                       //                     size: 15,
                    //                       //                   ),
                    //                       //                   fillColor: Colors.white,
                    //                       //                   elevation: 2,
                    //                       //                   borderColor: Color(0xFFB2B4B7),
                    //                       //                   borderWidth: 1,
                    //                       //                   borderRadius: 8,
                    //                       //                   margin: EdgeInsetsDirectional.fromSTEB(24, 4, 12, 4),
                    //                       //                   hidesUnderline: true,
                    //                       //                 ),
                    //                       //               ),
                    //                       //             ),
                    //                       //
                    //                       //           ],
                    //                       //         ),
                    //                       //       ),
                    //                       //       actions: <Widget>[
                    //                       //         TextButton(
                    //                       //           onPressed: () => Navigator.pop(context, 'Cancel'),
                    //                       //           child: const Text('Cancel'),
                    //                       //         ),
                    //                       //         TextButton(
                    //                       //           onPressed: (){
                    //                       //             FirebaseFirestore.instance.collection('admin_users').doc(user[index].id).update({
                    //                       //               'display_name':editName.text,
                    //                       //               'mobileNumber':editPhone.text,
                    //                       //               'email':editEmail.text,
                    //                       //               'role':editUserRole,
                    //                       //               'branchName':editBranch.text,
                    //                       //               'branchId':branchNameMap[editBranch.text],
                    //                       //
                    //                       //             });
                    //                       //             Navigator.pop(context, 'Cancel');
                    //                       //             showUploadMessage(context, 'selected users edited successfully');
                    //                       //           },
                    //                       //           child: const Text('OK'),
                    //                       //         ),
                    //                       //       ],
                    //                       //     )
                    //                       // );
                    //                     },
                    //                     child:Row(
                    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                       children: [
                    //                         user[index]['verified'] ==true?
                    //                         Icon(Icons.check,color: Colors.green,size: 30,)
                    //                             :Icon(Icons.close,color: Colors.red,size: 30,),
                    //
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }
                    // );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  InputBorder errorOutlineInputBOrder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1,
      color: Colors.redAccent,
    ),
  );
  InputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1,
      color: Color(0xffBBC5CD),
    ),
  );
}
