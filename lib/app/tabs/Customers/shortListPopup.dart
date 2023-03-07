import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

class ShortListPopup extends StatefulWidget {

  final String universityName;
  const ShortListPopup({Key key, this.universityName}) : super(key: key);

  @override
  State<ShortListPopup> createState() => _ShortListPopupState();
}

class _ShortListPopupState extends State<ShortListPopup> {


  List<String> applicationMethod =[
    'Online (University Application Portal)',
    'Leadz Portal',
    'Paper Application',

  ];
  TextEditingController method;
  TextEditingController userName;
  TextEditingController password;
  TextEditingController loginUrl;
  TextEditingController comment;

  String value;
  final formGlobalKey = GlobalKey<FormState>();

  submit() {
    print('aaaaa');
    final isValid = formGlobalKey.currentState.validate();
    if (!isValid) {
      return;
    }
    formGlobalKey.currentState.save();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('popup');
    print(value);
     method=TextEditingController();
     userName=TextEditingController();
     password=TextEditingController();
     loginUrl=TextEditingController();
     comment=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: AlertDialog(
      title:

         Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.clear,color: Colors.red,)),
              ],
            ),
            Text('Application Submission'),
          ],
        ),

      content: Container(
        width: 600,
        color: Colors.transparent,
        child: Column(
          children: [

            Text('Please Enter the Username and Password for the online Application ${widget.universityName}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),

            SizedBox(height: 15,),
            Container(
              width: 400,
              height: 60,

              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomDropdown(
                hintText: 'Select Application Method',
                items: applicationMethod,
                controller: method,
                excludeSelected: false,
                onChanged: (text){
                  setState(() {

                      value=text;



                  });

                },

              ),
            ),

            value=='Online (University Application Portal)'?


          Column(children: [
            SizedBox(height: 25,),

            Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFE6E6E6),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    16, 0, 0, 0),
                child: TextFormField(
                  onFieldSubmitted: (text){
                    setState(() {

                    });
                  },
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Please Enter username !';
                    }
                    return null;
                  },
                  controller: userName,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Please Enter UserName',
                    hintStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
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
                    color: Color(0xFF8B97A2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),

            Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFE6E6E6),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    16, 0, 0, 0),
                child: TextFormField(
                  onFieldSubmitted: (text){
                    setState(() {

                    });
                  },
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Please Enter password !';
                    }
                    return null;
                  },
                  controller: password,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Please Enter Password',
                    hintStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
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
                    color: Color(0xFF8B97A2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 25,),

            Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFE6E6E6),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    16, 0, 0, 0),
                child: TextFormField(
                  onChanged: (text){
                    setState(() {

                    });
                  },
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Please Enter login url !';
                    }
                    return null;
                  },
                  controller: loginUrl,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Login Url',
                    labelStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Please Enter Login Url',
                    hintStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
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
                    color: Color(0xFF8B97A2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: 400,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFE6E6E6),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    16, 0, 0, 0),
                child: TextFormField(
                  controller: comment,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Comments',
                    labelStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Comments, if any',
                    hintStyle: FlutterFlowTheme
                        .bodyText2
                        .override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
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
                    color: Color(0xFF8B97A2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
          ],):
            ( value!='Online (University Application Portal)'
            )?

            Column(children: [
              SizedBox(height: 25,),
              Container(
                width: 400,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFE6E6E6),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      16, 0, 0, 0),
                  child: TextFormField(
                    controller: comment,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Comments',
                      labelStyle: FlutterFlowTheme
                          .bodyText2
                          .override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: 'Comments, if any',
                      hintStyle: FlutterFlowTheme
                          .bodyText2
                          .override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
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
                      color: Color(0xFF8B97A2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,)

            ],):Container(),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                FFButtonWidget(
                  onPressed: ()  async {
                    print(value);

                    if(value=='Online (University Application Portal)') {
                     await submit();

                     if(userName.text!=''&&password.text!=''&&loginUrl.text!=''){
                       Navigator.pop(context,{'method':method.text,'comment':comment.text,'username':userName.text,'password':password.text,'loginUrl':loginUrl.text});

                    }


                  }else if(method.text!=''){
                      Navigator.pop(context,{'method':method.text,'comment':comment.text,'username':userName.text,'password':password.text,'loginUrl':loginUrl.text});
                    }
                  },
                  text: 'Submit',
                  options: FFButtonOptions(
                    width: 150,
                    height: 50,
                    color: Colors.teal,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ],
            ),



          ],
        ),),
    ));
  }
}
