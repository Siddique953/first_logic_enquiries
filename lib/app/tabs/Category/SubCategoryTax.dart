import 'package:fl_erp/backend/backend.dart';
import 'package:fl_erp/flutter_flow/flutter_flow_drop_down.dart';
import 'package:flutter/material.dart';

import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

class SubCategoryTaxWidget extends StatefulWidget {
  const SubCategoryTaxWidget({Key key}) : super(key: key);

  @override
  _SubCategoryTaxWidgetState createState() => _SubCategoryTaxWidgetState();
}

class _SubCategoryTaxWidgetState extends State<SubCategoryTaxWidget> {
  String dropDownValue;
  TextEditingController search;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Sub Universities Tax',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          
          children: [
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
                      onChanged: (text){

                        setState(() {

                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        hintText: 'Search Sub Universities',
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
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: search.text==''?
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('subCategory').snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());

                  }
                  var data=snapshot.data.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      dropDownValue=data[index]['gst'].toString();
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                        child: Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    data[index]['name'],
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                FlutterFlowDropDown(
                                  initialOption: dropDownValue ??= '5',
                                  options: ['0', '5', '12', '18','28'].toList(),
                                  onChanged: (val) => setState(() => dropDownValue = val),
                                  width: 180,
                                  height: 50,
                                  textStyle: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                  fillColor: Colors.white,
                                  elevation: 2,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0,
                                  borderRadius: 0,
                                  margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                  hidesUnderline: true,
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Confirm'),
                                          content: Text('Do you want to update Tax $dropDownValue ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(alertDialogContext),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {

                                               FirebaseFirestore.instance.collection('subCategory')
                                               .doc(data[index]['subCategoryId']).update({
                                                 'gst':int.tryParse(dropDownValue),
                                               });

                                              QuerySnapshot prd=await FirebaseFirestore.instance.collection('products')
                                               .where('subCategory',isEqualTo:data[index]['subCategoryId'] )
                                                   .get();
                                               var products=prd.docs;

                                               DocumentSnapshot updates=products[0];
                                               updates.reference.update({
                                                 'gst':int.tryParse(dropDownValue),
                                               });


                                                Navigator.pop(alertDialogContext);
                                                // Navigator.pop(context);

                                              },
                                              child: Text('Confirm'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  text: 'Update',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 40,
                                    color: secondaryColor,
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
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
                          ),
                        ),
                      );
                    },

                  );
                }
              ):
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('subCategory')
                      .where('search',arrayContains: search.text.toUpperCase()).snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());

                    }
                    var data=snapshot.data.docs;
                    return data.length==0?Center(child: Text('No SubCategory Available')):ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        dropDownValue=data[index]['gst'].toString();
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                          child: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data[index]['name'],
                                      style: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  FlutterFlowDropDown(
                                    initialOption: dropDownValue ??= '5',
                                    options: ['0', '5', '12', '18','28'].toList(),
                                    onChanged: (val) => setState(() => dropDownValue = val),
                                    width: 180,
                                    height: 50,
                                    textStyle: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    fillColor: Colors.white,
                                    elevation: 2,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0,
                                    borderRadius: 0,
                                    margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                    hidesUnderline: true,
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Confirm'),
                                            content: Text('Do you want to update Tax $dropDownValue ?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(alertDialogContext),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {

                                                  FirebaseFirestore.instance.collection('subCategory')
                                                      .doc(data[index].id).update({
                                                    'gst':int.tryParse(dropDownValue),
                                                  });

                                                  QuerySnapshot prd=await FirebaseFirestore.instance.collection('products')
                                                      .where('subCategory',isEqualTo:data[index].id)
                                                      .get();
                                                  var products=prd.docs;
                                                  
                                                  for(DocumentSnapshot doc in prd.docs){

                                                    doc.reference.update({
                                                      'gst':int.tryParse(dropDownValue),
                                                    });                                            
                                                  }

                                                  // DocumentSnapshot updates=products[0];
                                                  // updates.reference.update({
                                                  //   'gst':int.tryParse(dropDownValue),
                                                  // });


                                                  Navigator.pop(alertDialogContext);
                                                  // Navigator.pop(context);

                                                },
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    text: 'Update',
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 40,
                                      color: secondaryColor,
                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
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
                            ),
                          ),
                        );
                      },

                    );
                  }
              ),

            ),
                
          ],
        ),
      ),
    );
  }
}
