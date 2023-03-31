import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:multiple_select/Item.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../app_widget.dart';
import '../../models/Employee/EmployeeModel.dart';
import '../../tabs/Agent/Report/agentReport.dart';
import '../../tabs/Agent/add/createAgent.dart';
import '../../tabs/Agent/list/agentList.dart';
import '../../tabs/Bank Transfer/deposite/withdraw.dart';
import '../../tabs/Branch/AddBranch.dart';
import '../../tabs/Customers/customerList.dart';
import '../../tabs/Enquiry/AddEnquiry.dart';
import '../../tabs/Enquiry/followUp.dart';
import '../../tabs/Expense/add_expense.dart';
import '../../tabs/Expense/add_expense_head.dart';
import '../../tabs/Human Resources/Attendance/attendance.dart';
import '../../tabs/Human Resources/Employees/Employee_List/employeeList.dart';
import '../../tabs/Human Resources/Employees/addEmployee/addEmployee.dart';
import '../../tabs/Human Resources/Employees/employeeDetails/singleEmployeeDetails.dart';
import '../../tabs/Human Resources/HRSettings/addDept.dart';
import '../../tabs/Human Resources/Leaves/leaves.dart';
import '../../tabs/Human Resources/PayRoll_Slip/BankSlip/bankSlip.dart';
import '../../tabs/Human Resources/PayRoll_Slip/addExcelSheet.dart';
import '../../tabs/Human Resources/hrHomePage.dart';
import '../../tabs/Reports/contra Report.dart';
import '../../tabs/Reports/customer Statement/customerListPage.dart';
import '../../tabs/Reports/customer Statement/customerStatement.dart';
import '../../tabs/Reports/expenseReport.dart';
import '../../tabs/Reports/i&e report.dart';
import '../../tabs/Reports/projectPaymentReport.dart';
import '../../tabs/Reports/projectReport.dart';
import '../../tabs/Reports/reports.dart';
import '../../tabs/Settings/addService/serviceAdding.dart';
import '../../tabs/University/AddProjectType.dart';
import '../../tabs/Enquiry/EnquiryList.dart';

import '../../tabs/homeTab.dart';
import '../../tabs/users/users/addBranchUser.dart';
import 'components/side_menu.dart';

/// ERP VERSIONS
String webVersion = "1.7.0";

///

//LIST OF AGENTS
List<String> agentNumberList = [];
Map<String, dynamic> agentDataById = {'': ''};
Map<String, dynamic> agentIdByNumber = {
  '': '',
};

//LIST OF STAFFS

List<String> staffNames = ['Shabeeb', 'Aquif', 'Sharjas', 'Danish'];
List<String> empNames = [];
List employeeList = [];
Map<String, EmployeeModel> empDataById = {};
Map<String, dynamic> empIdByName = {};

bool order = false;
List<String> intakes = ['Select Intake'];

List<Item> intakeMultiple = [];

List<String> visaStatusList = ['Select status'];

List<String> applicationStatusList = ['Select status'];

Map<String, dynamic> intakeById = {};

Map<String, dynamic> currentUserMap = {};

Map<String, dynamic> idByIntake = {};

List<String> countryList = ['Select Country'];

Map<String, dynamic> courseNameById = {};

Map<String, dynamic> courseIdByName = {};

Map<String, dynamic> courseMap = {};

Map<String, dynamic> ProjectType = {};

Map<String, dynamic> ProjectTypeId = {};

List<String> phnNumbers = [];
Map<String, dynamic> customerDetailsByNumber = {};
Map<String, dynamic> customerDetailsById = {};
List listOfCustomers = [];
List listOfCustomersNames = [];

List<String> expHeadList = [];

//GETTING PROJECTS TO MAPS
Map<String, dynamic> projectIdByName = {};
Map<String, dynamic> projectDataById = {};
Map<String, dynamic> totalProjectByCustId = {};
List listOfProjects = [];
List listOfActiveProjects = [];
double totalProjectCost = 0;
double totalProjectPaid = 0;
double totalProjectDue = 0;

List<String> projectTypeList = ['Select project type'];
getSelectedProjectType() {
  FirebaseFirestore.instance
      .collection("projectType")
      .where('delete', isEqualTo: false)
      .snapshots()
      .listen((event) {
    projectTypeList = [];
    for (DocumentSnapshot doc in event.docs) {
      ProjectType[doc.get('name')] = doc.id;
      ProjectTypeId[doc.id] = doc.get('name');

      projectTypeList.add(doc['name']);
    }
  });
}

List<String> listOfDomain = [
  'Flutter',
  'Php',
  'Python',
  'Html',
  'Server',
  'Domains'
];

List<String> platforms = [
  'Android',
  'IOS',
  'Web',
  'Windows',
  'Linux',
  'OSX',
  'Other'
];

List<String> projectStatusList = [
  'Pending',
  'Started',
  // '50% Completed',
  // '70% Completed',
  // '90% Completed',
  'Completed',
  'Suspended'
];

Map<String, dynamic> branchNameMap = {};
Map<String, dynamic> branchShortNameMap = {};
Map<String, dynamic> branchIdMap = {};
List<String> branches = ['select branch'];

//getExpenseHeadList

getBranches() {
  FirebaseFirestore.instance.collection("branch").snapshots().listen((event) {
    branches = [];
    for (var doc in event.docs) {
      branchIdMap[doc.id] = doc.data();
      branchNameMap[doc.get('name')] = doc.get('branchId');
      branchShortNameMap[doc.id] = doc.get('shortName');

      branches.add(
        doc.get('name'),
      );
    }
  });
}

Map<String, dynamic> countryMap = {};
Map<String, dynamic> countryIdByName = {};

String currentUserRole = '';
bool currentUserPermission;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  getEmployees() {
    FirebaseFirestore.instance
        .collection("employees")
        .where('delete', isEqualTo: false)
        // .orderBy('joinedDate', descending: false)
        .snapshots()
        .listen((event) {
      empNames = [];
      employeeList = [];
      empDataById = {};

      for (DocumentSnapshot doc in event.docs) {
        empDataById[doc.id] = EmployeeModel.fromJson(doc.data());
        empIdByName[doc['name']] = doc.id;
        empNames.add(doc['name']);
        employeeList.add(doc.data());
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  getProjectData() {
    FirebaseFirestore.instance
        .collection("projects")
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('date', descending: false)
        .snapshots()
        .listen((event) {
      totalProjectByCustId = {};
      listOfProjects = [];
      listOfActiveProjects = [];

      List pending = [];
      List amtNotAdded = [];
      List paymentCompleted = [];
      List completedProjects = [];
      List activeProjects = [];
      List suspendedProjects = [];

      totalProjectCost = 0;
      totalProjectPaid = 0;
      totalProjectDue = 0;

      for (DocumentSnapshot doc in event.docs) {
        projectIdByName[doc['projectName']] = doc.id;
        projectDataById[doc.id] = doc.data();
        totalProjectCost += doc['projectCost'];
        totalProjectPaid += doc['totalPaid'];
        totalProjectDue += doc['projectCost'] - doc['totalPaid'];

        // listOfProjects.add(doc.data());

        if (doc['status'] == 'Suspended') {
          suspendedProjects.add(doc.data());
        } else if (doc['status'] == 'Completed') {
          completedProjects.add(doc.data());
        } else {
          if (doc['projectCost'] - doc['totalPaid'] != 0) {
            pending.add(doc.data());
          } else if (doc['projectCost'] == 0) {
            amtNotAdded.add(doc.data());
          } else {
            paymentCompleted.add(doc.data());
          }
        }
      }

      listOfActiveProjects.addAll(pending);
      listOfActiveProjects.addAll(amtNotAdded);
      listOfActiveProjects.addAll(paymentCompleted);

      listOfProjects.addAll(completedProjects);
      listOfProjects.addAll(listOfActiveProjects);
      listOfProjects.addAll(suspendedProjects);

      // for (int i = 0; i < allProjectList.length; i++) {
      //   int count = totalProjectByCustId[allProjectList[i]['customerID']];
      //   count++;
      //   totalProjectByCustId[allProjectList[i]['customerID']] = count;
      // }

      setState(() {});
    });
  }

  sendMail() {
    // String html = '<!DOCTYPE html>'
    //     '<html>'
    //     '<head>'
    //     '<title>Salary Slip</title>'
    //     '</head>'
    //     ' <body>'
    //     '<header>'
    //     '<img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/fl_new.png?alt=media&token=2300d95a-a061-4b9c-a06d-8e3f5906c24f" style="width:120px" alt="Company Logo">'
    //     '<h1>First Logic Meta Lab</h1>'
    //     '</header>'
    //     ' <section>'
    //     ' <h2>Employee Information</h2>'
    //     ' <ul>'
    //     ' <li>Name: John Doe</li>'
    //     ' <li>Employee ID: 12345</li>'
    //     ' <li>Department: Finance</li>'
    //     ' </ul>'
    //     ' </section>'
    //     '<section>'
    //     '<h2>Salary Details</h2>'
    //     '<ul>'
    //     '<li>Gross Salary: \$5,000</li>'
    //     '<li>Deductions: \$500</li>'
    //     '<li>Net Salary: \$4,500</li>'
    //     '</ul>'
    //     '</section>'
    //     '<section>'
    //     '<h2>Payment Details</h2>'
    //     '<ul>'
    //     '<li>Bank Account Number: 123456789</li>'
    //     '<li>Payment Date: 01/01/2023</li>'
    //     '</ul>'
    //     '</section>'
    //     ' <footer>'
    //     ' <p>Contact us at: <a href="mailto:hr@firstlogicmetalab.com">hr@firstlogicmetalab.com</a></p>'
    //     ' <p>Legal Disclosures: This salary slip is for informational purposes only and should not be considered as an official document.</p>'
    //     '</footer>'
    //     ' </body>'
    //     '</html>';

    // String html = '<html>'
    //     '<head>'
    //     '<meta name="viewport" content="width=device-width, initial-scale=1">'
    //     '<link href="https://fonts.googleapis.com/css2?family=Gotham:wght@400;700&display=swap" rel="stylesheet">'
    //     '<style>'
    //     'body {'
    //     'font-family: "Gotham", sans-serif;'
    //     '}'
    //     '.header {'
    //     'background-color: #0058ff;'
    //     'color: #fff;'
    //     'text-align: center;'
    //     'padding: 10px;'
    //     'display: flex;'
    //     'align-items: center;'
    //     ' }'
    //     '.header img {'
    //     ' margin-right: 20px;'
    //     '}'
    //     '.container {'
    //     'width: 80%;'
    //     'margin: 0 auto;'
    //     'background-color: #f2f2f2;'
    //     'padding: 20px;'
    //     ' }'
    //     'table {'
    //     'width: 100%;'
    //     'border-collapse: collapse;'
    //     'margin-top: 20px;'
    //     '}'
    //     'th,'
    //     'td {'
    //     'border: 1px solid #333;'
    //     'padding: 10px;'
    //     '}'
    //     'th {'
    //     'background-color: #0058ff;'
    //     ' color: #fff;'
    //     '}'
    //     '@media (max-width: 767px) {'
    //     '.container {'
    //     'width: 90%;'
    //     '}'
    //     'th,'
    //     'td {'
    //     'font-size: 14px;'
    //     ' }'
    //     ' }'
    //     '</style>'
    //     ' </head>'
    //     '<body>'
    //     '<div class="header">'
    //     ' <img src="https://via.placeholder.com/50x50" alt="Company Logo" />'
    //     '<h3>First Logic Meta Lab Pvt. Ltd</h3>'
    //     '</div>'
    //     '<div class="container">'
    //     '<p>'
    //     'Dear [Employee Name],'
    //     '</p>'
    //     '<p>'
    //     'I hope this email finds you in good health and spirits. I am writing to'
    //     'inform you that your salary for the month of [Month, Year] has been'
    //     'credited to your account.'
    //     '</p>'
    //     '<p>'
    //     'Your total salary amount is [Amount]. Please find the details of your'
    //     'leaves below:'
    //     '</p>'
    //     '<p>'
    //     'In case of any discrepancy, please bring it to our notice within 2 days.'
    //     'We would be happy to assist you with any questions or concerns you may'
    //     'have.'
    //     ' </p>'
    //     ' <p>'
    //     ' Thank you for your continued contributions to the company.'
    //     ' </p>'
    //     '<p>'
    //     'Best regards,<br />'
    //     'HR Manager'
    //     '</p>'
    //     '</div>'
    //     ' </body>'
    //     '</html>';
    // '<html>'
    // '<head>'
    // '<title>Salary Credit Notification</title>'
    // ' </head>'
    // '<body>'
    // '<header>'
    // '<img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/new_logo.jpeg?alt=media&token=981d964a-7480-420d-a9c6-341e8948922b" style="width:100px" alt="Company Logo">'
    // //     '<h1>First Logic Meta Lab</h1>'
    // '</header>'
    // '<p>Dear <b>Employee</b>,</p>'
    // '<p>I hope this email finds you in good health and spirits. I am writing to inform you that your salary for the month of <b>${dateTimeFormat('MMM y', DateTime(
    //       DateTime.now().year,
    //       DateTime.now().month - 1,
    //       DateTime.now().day,
    //     ))}</b> has been credited to your account.</p>'
    // '<p>Your total salary amount is <b>₹10000</b>. Please find the details of your leaves below:</p>'
    // '<br>'
    // '<ul>'
    // '<li>Total Working Days: 26</li>'
    // '<li>Number of Leaves: 10</li>'
    // '</ul>'
    // '<br>'
    // '<p>In case of any discrepancy, please bring it to our notice within 2 days. We would be happy to assist you with any questions or concerns you may have.</p>'
    // '<p>Thank you for your continued contributions to the company.</p>'
    // '<br>'
    // '<p>Best regards,</p>'
    // '<p>HR Manager<br>'
    // 'First Logic Meta Lab Pvt. Ltd</p>'
    // '</body>'
    // '</html>';

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
        '<div class="container">'
        '<p>'
        'Dear <b>Employee</b>,'
        '</p>'
        '<p>'
        'I hope this email finds you in good health and spirits. I am writing to'
        'inform you that your salary for the month of <b>${dateTimeFormat('MMM y', DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            ))}</b> has been'
        'credited to your account.'
        '</p>'
        '<p>'
        'Your total salary amount is <b>₹13000</b>.'
        'Please find the details below:'
        '</p>'
        ' <section>'
        ' <h2>Employee Information</h2>'
        ' <ul>'
        ' <li>Name: Abu</li>'
        ' <li>Employee ID: FL119</li>'
        ' <li>Total Working Days: 26</li>'
        '<li>Number of Leaves: 1</li>'
        ' </ul>'
        ' </section>';

    html += '<section>'
        '<h2>Salary Details</h2>'
        '<ul>'
        '<li>Basic Salary: ₹11000</li>'
        '<li>Payable Salary: ₹11000</li>';

    html += '<li>Incentive: ₹1500</li>';

    html += '<li>Over Time: ₹1500</li>';

    html += '<li>Deductions: ₹1000</li>';

    html += '<li>Take Home: ₹13000</li>'
        '</ul>'
        '</section>'
        '<p>'
        'In case of any discrepancy, please bring it to our notice within 2 days.'
        'We would be happy to assist you with any questions or concerns you may'
        'have.'
        ' </p>'
        ' <p>'
        ' Thank you for your continued contributions to the company.'
        ' </p>'
        '<p>'
        'Best regards,<br />'
        'HR Manager'
        '</p>'
        '</div>'
        ' </body>'
        '</html>';

    print('here[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
    print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[here]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
    FirebaseFirestore.instance.collection('mail').add({
      'html': html,
      'status': 'Salary Information',
      'emailList': [
        'siddiquec321@gmail.com',
        // 'akkuashkar158@gmail.com',
        // 'firstlogicil@gmail.com',
        'mmsharjas@gmail.com',
        'snehamp984@gmail.com',
      ],
      // 'message': {
      //   'subject': 'Pay Slip',
      //   'text': 'Monthly Salary Details',
      //   'html': html,
      // },
    });
  }

  getCustomers() async {
    await FirebaseFirestore.instance
        .collection('customer')
        .where('status', isEqualTo: 0)
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      phnNumbers = [];
      for (DocumentSnapshot customer in event.docs) {
        phnNumbers.add(customer['mobile']);
        customerDetailsByNumber[customer['mobile']] = customer.data();
        customerDetailsById[customer.id] = customer.data();
        listOfCustomers.add(customer.data());
        listOfCustomersNames.add(customer['name']);
        // // listOfFilteredCustomers.add(customer.data());
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  getExpenseHead() async {
    List data = [];
    await FirebaseFirestore.instance
        .collection('expenseHead')
        .doc(currentBranchId)
        .snapshots()
        .listen((event) {
      data = event['expenseHead'];
      expHeadList = [];
      for (var item in data) {
        expHeadList.add(item);
      }
    });

    if (mounted) {
      setState(() {});
    }
  }

  getUsers() {
    FirebaseFirestore.instance
        .collection('admin_users')
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot doc in event.docs) {
        currentUserMap[doc.id] = doc.data();
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  getAgents() {
    FirebaseFirestore.instance
        .collection('agents')
        .where('verified', isEqualTo: true)
        .snapshots()
        .listen((event) {
      agentNumberList = [];
      for (DocumentSnapshot doc in event.docs) {
        agentNumberList.add(doc['mobileNumber']);
        agentDataById[doc.id] = doc.data();
        agentIdByNumber[doc['mobileNumber']] = doc.id;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  getUser() {
    FirebaseFirestore.instance
        .collection('admin_users')
        .doc(currentUserUid)
        .snapshots()
        .listen((event) {
      currentUserRole = event['role'];
      currentUserPermission = event['verified'];

      if (mounted) {
        setState(() {});
      }
    });
  }

  getCurrentVersion() async {
    DocumentSnapshot<Map<String, dynamic>> event = await FirebaseFirestore
        .instance
        .collection('settings')
        .doc(currentBranchId)
        .get();

    if (event.data()['version'] != webVersion) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            // <-- SEE HERE
            title: const Text('Warning'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'New version found!!! Please refresh to version ${event.data()['version']} '),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  html.window.location.reload();
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    getCurrentVersion();
    super.initState();

    // addFieldToAllDoc();
    //
    // sendMail();
    getEmployees();
    getCustomers();

    getAgents();
    getExpenseHead();
    getUsers();
    getUser();
    getSelectedProjectType();
    getBranches();

    getProjectData();

    _tabController = TabController(vsync: this, length: 30, initialIndex: 0);
    // updateProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: currentUserPermission == false
          ? Center(
              child: Text(
                'Please Contact Admin',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            )
          : ResponsiveBuilder(
              builder: (context, sizingInformation) {
                // if (sizingInformation.isDesktop) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideMenu(tabController: _tabController),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController, //asd
                        children: [
                          HomeTab(), //0

                          //ENQUIRY
                          AddEnquiryWidget(), //1
                          EnqyiryListWidget(), //2
                          FollowUpPage(), //3

                          //CUSTOMER
                          CustomerListWidget(), //4

                          //HR
                          HrDashBoard(
                            tabController: _tabController,
                          ), //5
                          EmployeeList(
                            tabController: _tabController,
                          ), //6
                          AddEmployee(
                            tabController: _tabController,
                          ), //7
                          SingleEmployeeDetails(
                            tabController: _tabController,
                          ), //8
                          HrAttendance(
                            tabController: _tabController,
                          ), //9
                          HrLeavePage(
                            tabController: _tabController,
                          ), //10
                          HrSettingsPage(
                            tabController: _tabController,
                          ), //11

                          //ACCOUNTS
                          AddExpense(), //12
                          BankTransfer(), //13

                          //AGENT
                          AddPromoters(), //14
                          AgentList(), //15
                          AgentReport(), //16

                          //REPORTS
                          CustomerListingWidget(
                            tabController: _tabController,
                          ), //17
                          CustomerStatement(tabController: _tabController), //18
                          ProjectPaymentReport(), //19
                          ProjectReport(), //20
                          Reports(), //21
                          ExpenseReport(), //22
                          ContraReport(), //23
                          FirmReport(), //24

                          //SETTINGS
                          AddProjectTypeWidget(), //25
                          AddServices(), //26
                          CreateUsersWidget(), //27
                          AddBranchWidget(), //28
                          ExpenseHeadPage(), //29
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  addFieldToAllDoc() {
    List list = [
      {
        'name': 'Personal Details',
        'completed': false,
      },
      {
        'name': 'Project Details',
        'completed': false,
      },
      {
        'name': 'Payment Details',
        'completed': false,
      },
      {
        'name': 'Documents',
        'completed': false,
      },
      {
        'name': 'Services',
        'completed': false,
      },
      {
        'name': 'Statement',
        'completed': false,
      },
    ];

    FirebaseFirestore.instance.collection('projects').get().then(
          (value) => value.docs.forEach(
            (element) {
              ///
              // String str = element['careOf'];asd
              //'agentName':
              //        careOfNo.text ?? '',
              // print(str);
              // str = str.replaceAll(' ', '').toLowerCase();
              //
              // print(str);as
              // List paymentDetails = [];
              // for (var item in element['paymentDetails']) {
              //   Map det = item;
              //
              //   if (det['paymentProof'][0] == '') {
              //     det['paymentProof'].removeAt(0);
              //     // [item['paymentProof'] ?? ''];
              //
              //   }
              //   paymentDetails.add(det);
              // }
              // print('====================================================');
              // print(element['projectName']);
              // print(paymentDetails);
              ///

              FirebaseFirestore.instance
                  .collection('projects')
                  .doc(element.id)
                  .update({
                // 'email': '',

                'totalCost': element['projectCost'],

                // 'careOf': FieldValue.delete(),
                // 'careOfNo':FieldValue.delete(),
              });
            },
          ),
        );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

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
