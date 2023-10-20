import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_erp/app/tabs/Human%20Resources/SendMail/sendMail.dart';
import 'package:fl_erp/flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../pages/home_page/home.dart';


class SendToMailList extends StatefulWidget {
  final TabController _tabController;
  const SendToMailList({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<SendToMailList> createState() => _SendToMailListState();
}

class _SendToMailListState extends State<SendToMailList> {

  double width = 0;
  double height = 0;

  int firstIndex = 0;
  int lastIndex = 0;

  // listOfCustomers
  List listOfFilteredCustomers = [];
  List listOfCustomers = [];

  TextEditingController search=TextEditingController();

  /// SELECTED EMPLOYEEE TO SEND MAIL
  List selectedEmployees=[];

  bool allSelected=false;

//GET FIRST 20 DATA
  getFirst20() {
    listOfFilteredCustomers = [];
    print('===============================================');
    print(listOfCustomers.length);
    for (int i = 0; i < listOfCustomers.length; i++) {
      firstIndex = 0;
      if (listOfFilteredCustomers.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfCustomers[i];
        data['index'] = i;
        listOfFilteredCustomers.add(data);
      } else if (listOfFilteredCustomers.length == 20) {
        lastIndex = i - 1;
        break;
      }
      lastIndex = i;
    }

    print('=====================FIRST INDEX==========================');
    print(firstIndex);

    print('==========================LAST INDEX=====================');
    print(lastIndex);

    print('==========================LIST CURRENT LENGTH=====================');
    print(listOfFilteredCustomers.length);

    setState(() {});
  }

  //GET NEXT 20 DATA
  next() {
    listOfFilteredCustomers = [];
    for (int i = firstIndex; i < listOfCustomers.length; i++) {
      if (listOfFilteredCustomers.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfCustomers[i];
        data['index'] = i;
        listOfFilteredCustomers.add(data);
      } else if (listOfFilteredCustomers.length == 20) {
        lastIndex = i - 1;
        break;
      }
      lastIndex = i;
    }

    print(firstIndex);
    print(lastIndex);

    setState(() {});
  }

  //GET PREVIOUS 20 DATA
  prev() {
    listOfFilteredCustomers = [];
    List prev = [];
    for (int i = lastIndex; i >= 0; i--) {
      if (prev.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfCustomers[i];
        data['index'] = i;
        prev.add(data);
      } else if (prev.length == 20) {
        firstIndex = i + 1;
        break;
      }
      firstIndex = i;
    }

    listOfFilteredCustomers = prev.reversed.toList();

    print(firstIndex);
    print(lastIndex);

    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  //GET FIRST 20 SEARCHED DATA
  getSearchedProjects(String txt) {
    listOfFilteredCustomers = [];
    for (int i = 0; i < listOfCustomers.length; i++) {
      if (listOfCustomers[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['email'].toString().toLowerCase().contains(txt)) {
        if (listOfFilteredCustomers.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfCustomers[i];
          data['index'] = i;
          listOfFilteredCustomers.add(data);
        } else if (listOfFilteredCustomers.length == 20) {
          lastIndex = i - 1;
          break;
        }
        lastIndex = i;

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      }
    }

    setState(() {});
  }

  //GET NEXT 20 SEARCHED DATA
  getNextSearchProjects(String txt) {
    listOfFilteredCustomers = [];
    for (int i = firstIndex; i < listOfCustomers.length; i++) {
      if (listOfCustomers[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['email'].toString().toLowerCase().contains(txt)) {
        if (listOfFilteredCustomers.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfCustomers[i];
          data['index'] = i;
          listOfFilteredCustomers.add(data);
        } else if (listOfFilteredCustomers.length == 20) {
          lastIndex = i - 1;
          break;
        }
        lastIndex = i;

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      }
    }
    print(firstIndex);
    print(lastIndex);
    setState(() {});
  }

  //GET PREVIOUS 20 SEARCHED DATA
  getPrevSearchProjects(String txt) {
    listOfFilteredCustomers = [];
    List prev = [];
    print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
    print(lastIndex);
    for (int i = lastIndex; i >= 0; i--) {
      if (listOfCustomers[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['email'].toString().toLowerCase().contains(txt)) {
        if (prev.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfCustomers[i];
          data['index'] = i;
          prev.add(data);
          // prev.add(listOfCustomers[i]);
        } else if (prev.length == 20) {
          firstIndex = i + 1;
          break;
        }
        firstIndex = i;
      }
    }
    listOfFilteredCustomers = prev.reversed.toList();

    print(firstIndex);
    print(lastIndex);

    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    print(employeeList.length);

    listOfCustomers= employeeList.where((element) => element['delete']==false).toList();
    // .addAll(employeeList);

    listOfFilteredCustomers = [];

    getFirst20();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,60,50),

        child: FloatingActionButton(
          backgroundColor: Color(0xff0054FF),
          onPressed: () {
            if(selectedEmployees.isNotEmpty) {
              String html = '<html>'
                  '<head>'
                  '<meta name="viewport" content="width=device-width, initial-scale=1">'
                  '<link href="https://fonts.googleapis.com/css2?family=Gotham:wght@400;700&display=swap" rel="stylesheet">'
                  '<style>'
                  'body {'
                  'font-family: "Gotham", sans-serif;'
                  '}'
                  '.header {'
                  'background-color: #0058ff;'
                  'color: #fff;'
                  'text-align: center;'
                  'padding: 10px;'
                  'display: flex;'
                  'align-items: center;'
                  ' }'
                  '.header img {'
                  ' margin-right: 20px;'
                  '}'
                  '.container {'
                  'width: 80%;'
                  'margin: 0 auto;'
                  'background-color: #f2f2f2;'
                  'padding: 20px;'
                  ' }'
                  'table {'
                  'width: 100%;'
                  'border-collapse: collapse;'
                  'margin-top: 20px;'
                  '}'
                  'th,'
                  'td {'
                  'border: 1px solid #333;'
                  'padding: 10px;'
                  '}'
                  'th {'
                  'background-color: #0058ff;'
                  ' color: #fff;'
                  '}'
                  '@media (max-width: 767px) {'
                  '.container {'
                  'width: 90%;'
                  '}'
                  'th,'
                  'td {'
                  'font-size: 14px;'
                  ' }'
                  ' }'
                  '</style>'
                  ' </head>'
                  '<body>'
                  '<div class="header">'
                  ' <img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/webicon-01.png?alt=media&token=424afef7-b36f-47e0-aa12-ec5dd178085b" style="width:50px;height:50px;" alt="Company Logo" />'
                  '<h3>First Logic Meta Lab Pvt. Ltd</h3>'
                  '</div>'
                  '<div class="container">' +
                  // '<p>'+
                  mailBody +
                  // '</p>'

                      '</div>'
                      ' </body>'
                      '</html>';

              FirebaseFirestore.instance.collection('mail').add({
                'html': html,
                'status': mailSubject,
                'att': mailAttachments,
                'emailList': selectedEmployees,
                'date':FieldValue.serverTimestamp()
              }).then((value) {
                widget._tabController.animateTo(5);
              });
            } else {
              showUploadMessage(context, 'Must choose min one Employee');
            }
          },
          child: Icon(Icons.send),

        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget._tabController.animateTo(35);
            });
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Send To',
          style: TextStyle(color: Colors.white, fontSize: width * 0.02),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Color(0xff231F20),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.15, bottom: height * 0.15),
                child: Material(
                  elevation: 10,
                  child: Container(
                    width: width * 0.6,
                    // height: height * 0.75,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Row(
                                children: [
                                  Text('Select All'),
                                  SizedBox(width: 15,),
                                  Checkbox(
                                      value: allSelected,
                                      activeColor: Color(0xff0054FF),

                                      onChanged:(bool? newValue){

                                        if(allSelected){
                                          selectedEmployees=[];
                                          allSelected=false;
                                        } else {
                                          selectedEmployees=[];
                                          listOfCustomers.forEach((element) {
                                            selectedEmployees.add(element['email']);
                                          });
                                          allSelected=true;
                                        }
                                        print(newValue);
                                        // if(selectedEmployees.contains(email)){
                                        //   selectedEmployees.remove(email);
                                        // } else {
                                        //   selectedEmployees.add(email);
                                        // }
                                        setState(() {});
                                      }),
                                ],
                              ),
                              Container(
                                width: 350,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(
                                      8),
                                  border: Border.all(
                                    color:
                                    Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: search,
                                    obscureText: false,
                                    onChanged: (text) {
                                      setState(() {
                                        listOfFilteredCustomers.clear();
                                        if (search.text == '') {
                                          // listOfFilteredProjects
                                          //     .addAll(listOfActiveProjects);
                                          getFirst20();
                                        } else {
                                          getSearchedProjects(text.toLowerCase());
                                        }
                                      });
                                    },
                                    decoration:
                                    InputDecoration(
                                      labelText: 'Search',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily:
                                          'Montserrat',
                                          color: Colors
                                              .black,
                                          fontWeight:
                                          FontWeight
                                              .w500,
                                          fontSize: 12),
                                      hintText:
                                      'Search for Employees',
                                      hintStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                          fontFamily:
                                          'Montserrat',
                                          color: Colors
                                              .black,
                                          fontWeight:
                                          FontWeight
                                              .w500,
                                          fontSize: 12),
                                      enabledBorder:
                                      UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(
                                          color: Colors
                                              .transparent,
                                          width: 1,
                                        ),
                                        borderRadius:
                                        const BorderRadius
                                            .only(
                                          topLeft: Radius
                                              .circular(
                                              4.0),
                                          topRight: Radius
                                              .circular(
                                              4.0),
                                        ),
                                      ),
                                      focusedBorder:
                                      UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(
                                          color: Colors
                                              .transparent,
                                          width: 1,
                                        ),
                                        borderRadius:
                                        const BorderRadius
                                            .only(
                                          topLeft: Radius
                                              .circular(
                                              4.0),
                                          topRight: Radius
                                              .circular(
                                              4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme
                                        .bodyText2
                                        .override(
                                        fontFamily:
                                        'Montserrat',
                                        color: Color(
                                            0xFF8B97A2),
                                        fontWeight:
                                        FontWeight
                                            .w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          listOfFilteredCustomers.length == 0
                              ? LottieBuilder.network(
                            'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                            height: 500,
                          )
                              : Row(
                            children: [
                              Expanded(
                                child: FittedBox(
                                  child: DataTable(
                                    horizontalMargin: 10,
                                    columns: [
                                      DataColumn(
                                        label: Text("Sl.No",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.008)),
                                      ),
                                      DataColumn(
                                        label: Text("Emp ID",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.008)),
                                      ),
                                      DataColumn(
                                        label: Text("Emp Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.008)),
                                      ),
                                      DataColumn(
                                        label: Text("Designation",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.008)),
                                      ),
                                      // DataColumn(
                                      //   label: Text("Manager",
                                      //       style: TextStyle(
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: MediaQuery.of(context)
                                      //               .size
                                      //               .width *
                                      //               0.008)),
                                      // ),
                                      DataColumn(
                                        label: Text("Email",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.008)),
                                      ),

                                      DataColumn(
                                        label: Text("Action",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.008)),
                                      ),
                                    ],
                                    rows: List.generate(
                                      listOfFilteredCustomers.length,
                                          (index) {
                                        // getCount(data[index].id);

                                        String empId =
                                        listOfFilteredCustomers[index]['empId'];

                                        String name =
                                        listOfFilteredCustomers[index]['name'];



                                        String designation =
                                        listOfFilteredCustomers[index]
                                        ['designation'];

                                        // String manager = empDataById[
                                        // listOfFilteredCustomers[index]
                                        // ['reportingManager'] ??
                                        //     ''] ==
                                        //     null
                                        //     ? ''
                                        //     : empDataById[
                                        // listOfFilteredCustomers[index]
                                        // ['reportingManager'] ??
                                        //     '']
                                        //     .name;

                                        String email =
                                        listOfFilteredCustomers[index]['email'];


                                        int count =
                                        listOfFilteredCustomers[index]['index'];

                                        return DataRow(
                                          color: index.isOdd
                                              ? MaterialStateProperty.all(Colors
                                              .blueGrey.shade50
                                              .withOpacity(0.7))
                                              : MaterialStateProperty.all(
                                              Colors.blueGrey.shade50),
                                          cells: [
                                            DataCell(
                                              SelectableText(
                                                '${count + 1}',
                                                style: FlutterFlowTheme.bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.008,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                empId,
                                                style: FlutterFlowTheme.bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.007,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                name,
                                                style: FlutterFlowTheme.bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.008,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                designation ?? '',
                                                style: FlutterFlowTheme.bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.008,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            // DataCell(
                                            //   SelectableText(
                                            //     manager ?? '',
                                            //     style: FlutterFlowTheme.bodyText2
                                            //         .override(
                                            //       fontFamily: 'Lexend Deca',
                                            //       color: Colors.black,
                                            //       fontSize: MediaQuery.of(context)
                                            //           .size
                                            //           .width *
                                            //           0.008,
                                            //       fontWeight: FontWeight.bold,
                                            //     ),
                                            //   ),
                                            // ),
                                            DataCell(
                                              SelectableText(
                                                email,
                                                style: FlutterFlowTheme.bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.008,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                            DataCell(
                                              Row(
                                                children: [
                                                  Checkbox(
                                                      value: selectedEmployees.contains(email),
                                                      activeColor: Color(0xff0054FF),

                                                      onChanged:(bool? newValue){
                                                        if(selectedEmployees.contains(email)){

                                                          selectedEmployees.remove(email);
                                                          allSelected=false;
                                                        } else {
                                                          selectedEmployees.add(email);
                                                          if(selectedEmployees.length == listOfCustomers.length) {
                                                            allSelected=true;
                                                          } else {
                                                            allSelected=false;
                                                          }
                                                        }
                                                        setState(() {});
                                                      }),
                                                ],
                                              ),
                                            ),
                                            // DataCell(Text(fileInfo.size)),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                firstIndex > 0
                                    ? FFButtonWidget(
                                  onPressed: () {
                                    setState(() {
                                      if (search.text == '') {
                                        lastIndex = firstIndex - 1;
                                        prev();
                                      } else {
                                        lastIndex = firstIndex - 1;
                                        getPrevSearchProjects(search.text);
                                      }
                                    });
                                  },
                                  text: 'Prev',
                                  options: FFButtonOptions(
                                    width: 80,
                                    height: 30,
                                    color: Color(0xff0054FF),
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 8,
                                  ),
                                )
                                    : SizedBox(),
                                // SizedBox(width:50,),
                                (lastIndex + 1 < listOfCustomers.length && listOfFilteredCustomers.length==20)
                                    ? FFButtonWidget(
                                  onPressed: () {
                                    setState(() {
                                      if (search.text == '') {
                                        firstIndex = lastIndex + 1;
                                        next();
                                      } else {
                                        firstIndex = lastIndex + 1;
                                        getNextSearchProjects(search.text);
                                      }
                                    });
                                  },
                                  text: 'Next',
                                  options: FFButtonOptions(
                                    width: 80,
                                    height: 30,
                                    color: Color(0xff0054FF),
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 8,
                                  ),
                                )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
