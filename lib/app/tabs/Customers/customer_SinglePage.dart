import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:fl_erp/backend/backend.dart';
import 'package:lottie/lottie.dart';
import 'package:searchfield/searchfield.dart';
import 'package:excel/excel.dart';
import '../../../paymentReport/report/Invoice.dart';
import '../../../paymentReport/report/generatePdf.dart';
import '../../../paymentReport/report/generatePrintFunction.dart';
import '../../../paymentReport/report/newPDF.dart';
import '../../../paymentReport/report/printingFunction.dart';
import '../../pages/home_page/home.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import 'package:country_pickers/country_pickers.dart';
import 'createProjectPopUp.dart';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart' as html;

bool subTabView = false;

class CustomerSinglePage extends StatefulWidget {
  final String id;
  final int selectedIndex;
  final bool tab;
  final Map project;
  const CustomerSinglePage({
    Key key,
    this.id,
    this.selectedIndex,
    this.tab,
    this.project,
  }) : super(key: key);

  @override
  _CustomerSinglePageState createState() => _CustomerSinglePageState();
}

class _CustomerSinglePageState extends State<CustomerSinglePage> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  int selectedIndex;
  var selectedProject;

  List projectsList;
  int indexNum = 0;
  List<String> projectNames = [''];
  List<String> projectNamesSortList = [''];
  List<String> staffNamesSortList = [''];
  TextEditingController projectName = TextEditingController();
  Map<String, dynamic> currentProject = {};
  bool service = false;

  List items = [];
  Map<String, dynamic> uploadData = {};
  bool loaded = false;
  Map<String, dynamic> documents = {};

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PlatformFile pickFile;
  UploadTask uploadTask;

  //Personal Details

  TextEditingController nameController;
  String uploadedFileUrl = '';
  TextEditingController email;
  String countryCode = 'IN';
  String phoneCode = '';
  TextEditingController nationality;
  TextEditingController mobile;
  TextEditingController whatsAppNo;
  TextEditingController studentPlace;
  TextEditingController address;
  TextEditingController city;
  TextEditingController companyName;
  TextEditingController companyAddress;
  TextEditingController companyEmail;
  TextEditingController agentName;
  // TextEditingController careOfNo;

  TextEditingController projectname;
  TextEditingController topic;
  TextEditingController projectCost;

  TextEditingController Domain;
  TextEditingController platform;
  TextEditingController deliverable;

// Payment Details
  DateTime selectedDate;
  TextEditingController staffName;
  TextEditingController payingAmount;
  TextEditingController description;

  //PAYMENT SORTING
  TextEditingController staffNameSortValue;
  TextEditingController projectNameSortValue;

  List<String> personalKeys = [
    'name',
    'email',
    'mobile',
    'whatsAppNo',
    'place',
    'companyAddress',
    'companyEmail',
    'companyName',
    'address',
    'agentName',
  ];

  //Education
  String country;
  TextEditingController projectType;
  TextEditingController projectStatus;
  // bool radioSelected1 = true;
  // bool cash = false;
  // // String radioval='';
  // bool bank = false;
  String paymentMethode = '';

  //DOCUMENTS
  TextEditingController documentName;

  TextEditingController documentDescription;

  TextEditingController projectNameInDocuments;
  TextEditingController projectNameSortInDocuments;
  List customerDocumentList = [];

  List project = [];

  //SERVICES

  DateTime serviceStartingDate;
  DateTime serviceEndingDate;
  TextEditingController serviceName;
  TextEditingController serviceAmount;
  TextEditingController serviceDescription;
  TextEditingController projectNameInServices;
  TextEditingController projectNameSortInServices;
  List selectedServicesList = [];
  List serviceNames = [];
  List<String> customerServiceNames = [''];
  List<String> customerServiceAndProjectNames = [''];
  Map<String, dynamic> serviceIdByName = {};
  Map<String, dynamic> serviceDataById = {};

  List servicePaymentList = [];
  List projectAndServicePaymentList = [];

  //GET SERVICES
  List<String> servicesList = [''];

  getServices() {
    FirebaseFirestore.instance
        .collection('services')
        .where('branchId', isEqualTo: currentBranchId)
        .where('delete', isEqualTo: false)
        .snapshots()
        .listen((event) {
      servicesList = [];
      for (var doc in event.docs) {
        servicesList.add(doc['name']);
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  getCustomerServices() {
    print('HEREEEEEEEEEEEEEE');
    FirebaseFirestore.instance
        .collection('customerServices')
        .where('customerId', isEqualTo: widget.id)
        .where('delete', isEqualTo: false)
        .snapshots()
        .listen((event) {
      print('HEREEEEEEEEEEEEEE');
      print(event.docs.length);

      selectedServicesList = [];
      customerServiceNames = [];
      servicePaymentList = [];

      for (var doc in event.docs) {
        selectedServicesList.add(doc);
        customerServiceNames.add(doc['serviceName']);
        // servicePaymentList.add(doc['paymentDetails']);
        serviceIdByName[doc['serviceName']] = doc.id;
        serviceDataById[doc.id] = doc.data();

        List data = doc['paymentDetails'];
        for (int i = 0; i < data.length; i++) {
          Map value = {};
          value = doc.data();
          value['amount'] = data[i]['amount'];
          value['paidDate'] = data[i]['datePaid'];
          value['paymentMethode'] = data[i]['paymentMethod'];
          value['staffName'] = data[i]['staffName'];
          value['description'] = data[i]['description'];
          value['projectId'] = data[i]['serviceId'];
          value['paymentProof'] = data[i]['paymentProof'] ?? [];

          value['billCode'] =
              data[i]['billCode'].toString().replaceFirst('PMNA', '');
          double exp = double.tryParse(data[i]['amount'].toString());
          totalExp += exp;

          servicePaymentList.add(value);
        }
      }

      if (mounted) {
        // payments.addAll(servicePaymentList);
        customerServiceAndProjectNames = [];
        customerServiceAndProjectNames.addAll(customerServiceNames);
        customerServiceAndProjectNames.addAll(projectNames);

        //ADDING PAYMENTS
        projectAndServicePaymentList = [];
        projectAndServicePaymentList.addAll(servicePaymentList);
        projectAndServicePaymentList.toList();
        projectAndServicePaymentList.addAll(payments);
        projectAndServicePaymentList.toList();

        setState(() {});
      }
    });
  }

  var urlDownload;

  //PICK FILE
  Future selectFileToUpload(String name, BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickFile = result.files.first;

    String ext = pickFile.name.split('.').last;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...', showLoading: true);

    uploadFileToFireBase(name, fileBytes, ext, context);

    setState(() {});
  }

  //UPDATE DOCUMENT DATE
  Future uploadFileToFireBase(
      String name, fileBytes, String ext, BuildContext context) async {
    uploadTask = FirebaseStorage.instance
        .ref('uploads/${widget.id}/${widget.id}-$name.$ext')
        .putData(fileBytes);
    final snapshot = await uploadTask.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {});
  }

  //ADD DOCUMENT DATA
  addToFireBaseDocument(String name, BuildContext context) async {
    List data = [];

    data.add({
      'url': urlDownload,
      'dateSubmitted': DateTime.now(),
      'docName': documentName.text.toUpperCase(),
      'projectId': projectIdByName[projectNameInDocuments.text],
      'docDescription': documentDescription.text,
    });

    FirebaseFirestore.instance
        .collection('customer')
        .doc(widget.id)
        .update({'documents': FieldValue.arrayUnion(data)}).then((value) {
      showUploadMessage(context, 'Document $name Added...');
      // Navigator.pop(context);
    });
  }

  //TAKE DOCUMENT DATA FROM FIREBASE
  getUploadedDocuments() async {
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      var data = event.get('documents');
      customerDocumentList = [];

      for (int i = 0; i < data.length; i++) {
        if (projectDataById[data[i]['projectId']]['projectName'] ==
            projectNameSortInDocuments.text) {
          customerDocumentList.add(data[i]);
        } else if (projectNameSortInDocuments.text == 'All' ||
            projectNameSortInDocuments.text == '') {
          customerDocumentList.add(data[i]);
        }
      }

      // customerDocumentList = event.get('documents');
      setState(() {});
    });
    if (mounted) {
      setState(() {});
    }
  }

  //get PROJECTS
  getProjects() async {
    projectsList = [];
    projectNames = [];
    projectNamesSortList = ['All'];
    staffNamesSortList = ['All'];

    FirebaseFirestore.instance
        .collection('projects')
        .where('branchId', isEqualTo: currentBranchId)
        .where('customerID', isEqualTo: widget.id)
        .snapshots()
        .listen((event) {
      projectsList = event.docs;
      projectNames = [];

      projectNamesSortList = ['All'];
      for (int i = 0; i < projectsList.length; i++) {
        projectNames.add(projectsList[i]['projectName']);
        projectNamesSortList.add(projectsList[i]['projectName']);
      }
      for (int i = 0; i < staffNames.length; i++) {
        staffNamesSortList.add(staffNames[i]);
      }

      if (projectNames.length == 1) {
        projectName.text = projectNames[0];
        projectName.text = projectNames[0];
        projectNameInDocuments.text = projectNames[0];

        currentProject = projectDataById[projectIdByName[projectName.text]];
      }
      if (mounted) {
        customerServiceAndProjectNames = [];
        customerServiceAndProjectNames.addAll(projectNames);
        customerServiceAndProjectNames.addAll(customerServiceNames);
        setState(() {
          if (projectsList.length == 1) {
            subTabView = true;
          }
        });
      }
    });
  }

  List payments = [];
  List paymentsSort = [];
  double totalExp = 0;

  getPaymentDetails() {
    FirebaseFirestore.instance
        .collection('projects')
        .where('branchId', isEqualTo: currentBranchId)
        .where('customerID', isEqualTo: widget.id)
        .snapshots()
        .listen((event) {
      var customer = event.docs;
      payments = [];
      paymentsSort = [];
      for (var doc in customer) {
        List data = doc['paymentDetails'];
        for (int i = 0; i < data.length; i++) {
          Map value = {};
          value = doc.data();
          value['amount'] = data[i]['amount'];
          value['paidDate'] = data[i]['datePaid'];
          value['paymentMethode'] = data[i]['paymentMethod'];
          value['staffName'] = data[i]['staffName'];
          value['description'] = data[i]['description'];
          value['projectId'] = data[i]['projectId'];
          value['paymentProof'] = data[i]['paymentProof'] ?? [];
          value['billCode'] =
              data[i]['billCode'].toString().replaceFirst('PMNA', '');
          double exp = double.tryParse(data[i]['amount'].toString());
          totalExp += exp;
          payments.add(value);
          paymentsSort.add(value);

          print(
              '---------------------PAYMENTS LENGTH-------------------------');
          print(payments.length);
          print(paymentsSort.length);

          // if (projectDataById[data[i]['projectId']]['projectName'] ==
          //         projectNameSortValue.text &&
          //     data[i]['staffName'] == staffNameSortValue.text) {
          //   Map value = {};
          //   value = doc.data();
          //   value['amount'] = data[i]['amount'];
          //   value['paidDate'] = data[i]['datePaid'];
          //   value['paymentMethode'] = data[i]['paymentMethod'];
          //   value['staffName'] = data[i]['staffName'];
          //   value['description'] = data[i]['description'];
          //   value['projectId'] = data[i]['projectId'];
          //   payments.add(value);
          // } else if (projectDataById[data[i]['projectId']]['projectName'] ==
          //         projectNameSortValue.text &&
          //     (staffNameSortValue.text == 'All' ||
          //         staffNameSortValue.text == '')) {
          //   Map value = {};
          //   value = doc.data();
          //   value['amount'] = data[i]['amount'];
          //   value['paidDate'] = data[i]['datePaid'];
          //   value['paymentMethode'] = data[i]['paymentMethod'];
          //   value['staffName'] = data[i]['staffName'];
          //   value['description'] = data[i]['description'];
          //   value['projectId'] = data[i]['projectId'];
          //   payments.add(value);
          // } else if (data[i]['staffName'] == staffNameSortValue.text &&
          //     (projectNameSortValue.text == 'All' ||
          //         projectNameSortValue.text == '')) {
          //   Map value = {};
          //   value = doc.data();
          //   value['amount'] = data[i]['amount'];
          //   value['paidDate'] = data[i]['datePaid'];
          //   value['paymentMethode'] = data[i]['paymentMethod'];
          //   value['staffName'] = data[i]['staffName'];
          //   value['description'] = data[i]['description'];
          //   value['projectId'] = data[i]['projectId'];
          //   payments.add(value);
          // } else if (projectNameSortValue.text == 'All' &&
          //     staffNameSortValue.text == 'All') {
          //   Map value = {};
          //   value = doc.data();
          //   value['amount'] = data[i]['amount'];
          //   value['paidDate'] = data[i]['datePaid'];
          //   value['paymentMethode'] = data[i]['paymentMethod'];
          //   value['staffName'] = data[i]['staffName'];
          //   value['description'] = data[i]['description'];
          //   value['projectId'] = data[i]['projectId'];
          //   payments.add(value);
          // } else if ((projectNameSortValue.text == '' &&
          //         staffNameSortValue.text == 'All') ||
          //     (projectNameSortValue.text == 'All' &&
          //         staffNameSortValue.text == '')) {
          //   Map value = {};
          //   value = doc.data();
          //   value['amount'] = data[i]['amount'];
          //   value['paidDate'] = data[i]['datePaid'];
          //   value['paymentMethode'] = data[i]['paymentMethod'];
          //   value['staffName'] = data[i]['staffName'];
          //   value['description'] = data[i]['description'];
          //   value['projectId'] = data[i]['projectId'];
          //   payments.add(value);
          // } else if (projectNameSortValue.text == '' &&
          //     staffNameSortValue.text == '') {
          //   Map value = {};
          //   value = doc.data();
          //   value['amount'] = data[i]['amount'];
          //   value['paidDate'] = data[i]['datePaid'];
          //   value['paymentMethode'] = data[i]['paymentMethod'];
          //   value['staffName'] = data[i]['staffName'];
          //   value['description'] = data[i]['description'];
          //   value['projectId'] = data[i]['projectId'];
          //   payments.add(value);
          // }
        }
      }

      if (mounted) {
        projectAndServicePaymentList = [];
        projectAndServicePaymentList.addAll(servicePaymentList);
        projectAndServicePaymentList.addAll(payments);

        setState(() {
          print(payments.length);
          projectAndServicePaymentList
              .sort((a, b) => b['paidDate'].compareTo(a['paidDate']));
        });
      }
    });
  }

  getSortedPayments() {
    List data = [];
    data.addAll(paymentsSort);
    payments.clear();

    for (int i = 0; i < data.length; i++) {
      if ((projectDataById[data[i]['projectId']]['projectName'] ==
                  projectNameSortValue.text ||
              serviceDataById[data[i]['serviceId']]['serviceName'] ==
                  projectNameSortValue.text) &&
          data[i]['staffName'] == staffNameSortValue.text) {
        Map value = {};
        value = data[i];

        payments.add(value);
      } else if ((projectDataById[data[i]['projectId']]['projectName'] ==
                  projectNameSortValue.text ||
              serviceDataById[data[i]['serviceId']]['serviceName'] ==
                  projectNameSortValue.text) &&
          (staffNameSortValue.text == 'All' || staffNameSortValue.text == '')) {
        Map value = {};
        value = data[i];

        payments.add(value);
      } else if (data[i]['staffName'] == staffNameSortValue.text &&
          (projectNameSortValue.text == 'All' ||
              projectNameSortValue.text == '')) {
        Map value = {};
        value = data[i];

        payments.add(value);
      } else if (projectNameSortValue.text == 'All' &&
          staffNameSortValue.text == 'All') {
        Map value = {};
        value = data[i];

        payments.add(value);
      } else if ((projectNameSortValue.text == '' &&
              staffNameSortValue.text == 'All') ||
          (projectNameSortValue.text == 'All' &&
              staffNameSortValue.text == '')) {
        Map value = {};
        value = data[i];

        payments.add(value);
      } else if (projectNameSortValue.text == '' &&
          staffNameSortValue.text == '') {
        Map value = {};
        value = data[i];

        payments.add(value);
      }
    }
    setState(() {
      payments.sort((a, b) => b['paidDate'].compareTo(a['paidDate']));
    });
  }

  Future<void> importData(String customer) async {
    var excel = Excel.createExcel();

    Sheet sheetObject = excel[customer];
    CellStyle cellStyle = CellStyle(
        verticalAlign: VerticalAlign.Center,
        horizontalAlign: HorizontalAlign.Center,
        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));
    CellStyle totalStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Calibri),
        fontSize: 16,
        bold: true);

    //HEADINGS

    if (payments.length > 0) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'Date'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'Project Name'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'Amount'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
      cell5.value = 'Description'; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
      cell6.value = 'Payment Methode'; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
      cell7.value = 'Staff Name'; // dynamic values support provided;
      cell7.cellStyle = cellStyle;
    }

    print(payments.length);

    //CELL VALUES

    for (int i = 0; i <= payments.length; i++) {
      if (i == payments.length) {
        var cell6 = sheetObject.cell(CellIndex.indexByString("C${i + 3}"));
        cell6.value = 'Total Expenses '; // dynamic values support provided;
        cell6.cellStyle = totalStyle;

        var cell7 = sheetObject.cell(CellIndex.indexByString("D${i + 3}"));
        cell7.value = totalExp; // dynamic values support provided;
        cell7.cellStyle = totalStyle;
      } else {
        var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
        cell1.value = '${i + 1}'; // dynamic values support provided;
        cell1.cellStyle = cellStyle;
        var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
        cell2.value = dateTimeFormat(
            'd-MMM-y',
            payments[i]['paidDate']
                .toDate()); // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
        cell3.value = projectDataById[payments[i]['projectId']]
            ['projectName']; // dynamic values support provided;
        cell3.cellStyle = cellStyle;
        var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
        cell4.value = payments[i]['amount']; // dynamic values support provided;
        cell4.cellStyle = cellStyle;
        var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
        cell5.value =
            payments[i]['description']; // dynamic values support provided;
        cell5.cellStyle = cellStyle;
        var cell6 = sheetObject.cell(CellIndex.indexByString("F${i + 2}"));
        cell6.value =
            payments[i]['paymentMethode']; // dynamic values support provided;
        cell6.cellStyle = cellStyle;
        var cell7 = sheetObject.cell(CellIndex.indexByString("G${i + 2}"));
        cell7.value =
            payments[i]['staffName']; // dynamic values support provided;
        cell7.cellStyle = cellStyle;
        // var cell7 = sheetObject.cell(CellIndex.indexByString("G${i + 2}"));
        // cell7.value = payments[i]['modeOfPayment']
        //     .toString(); // dynamic values support provided;
        // cell7.cellStyle = cellStyle;
        // var cell8 = sheetObject.cell(CellIndex.indexByString("H${i + 2}"));
        // cell8.value =
        //     payments[i]['amount'].toString(); // dynamic values support provided;
        // cell8.cellStyle = cellStyle;
      }
    }

    excel.setDefaultSheet(customer);
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", "${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
  }

  RegExp phnValidation = RegExp(r'^[0-9]{10}$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    customerServiceAndProjectNames = [''];

    selectedIndex = widget.selectedIndex;
    subTabView = widget.tab;
    selectedProject = widget.project;
    print('===============================================================');
    print(subTabView);
    print(selectedIndex);
    print(selectedProject['projectId']);

    //Personal Details
    nameController = TextEditingController();
    email = TextEditingController();
    mobile = TextEditingController();
    nationality = TextEditingController();
    studentPlace = TextEditingController();
    address = TextEditingController();
    city = TextEditingController();
    companyName = TextEditingController();
    companyAddress = TextEditingController();
    companyEmail = TextEditingController();
    whatsAppNo = TextEditingController();
    agentName = TextEditingController();
    // careOfNo = TextEditingController();

    //project
    topic = TextEditingController();
    Domain = TextEditingController();
    deliverable = TextEditingController();
    platform = TextEditingController();
    projectType = TextEditingController();
    projectStatus = TextEditingController();
    projectName = TextEditingController();
    projectname = TextEditingController();
    projectCost = TextEditingController();

    //payment
    staffName = TextEditingController();
    staffNameSortValue = TextEditingController();
    projectNameSortValue = TextEditingController();
    payingAmount = TextEditingController();
    description = TextEditingController();
    selectedDate = DateTime.now();

    //documents
    documentName = TextEditingController();

    documentDescription = TextEditingController();
    projectNameInDocuments = TextEditingController();
    projectNameSortInDocuments = TextEditingController();

    //SERVICES
    serviceName = TextEditingController();
    serviceAmount = TextEditingController();
    serviceDescription = TextEditingController();
    projectNameInServices = TextEditingController();
    projectNameSortInServices = TextEditingController();

    subTabView = false;

    //get Services
    getServices();

    //Get Sorted Services
    getCustomerServices();

    getUploadedDocuments();

    //getting projects
    getProjects();

    //get payments
    getPaymentDetails();

    print('===============================================================');
    print(subTabView);
    print(selectedIndex);
    print(selectedProject['projectId']);
  }

  @override
  DocumentSnapshot cust;

  downloadUrl(String urls) async {
    var url = urls;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildDropdownItem(Country country) => Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(
                width: 8.0,
              ),
              Text("+${country.phoneCode}(${country.isoCode})"),
            ],
          ),
        );

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customer')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset('assets/images/loading.gif'),
                ));
          }

          cust = snapshot.data;

          Map<String, dynamic> customerData = snapshot.data.data();
          bool PD = true;
          for (String key in personalKeys) {
            if (customerData[key] == null || customerData[key] == "") {
              PD = false;
              break;
            }
          }
          // bool TK = true;
          // if (travelHistory.length == 0) {
          //   TK = false;
          // }

          items = cust['form'];
          project = cust['projectDetails'];

          //paymentDetails

          if (loaded == false) {
            loaded = true;

            //projectDetails

            try {
              //Personal Details
              address.text = cust['address'];
              nameController.text = cust['name'];
              email.text = cust['email'];
              countryCode = cust['countryCode'];
              phoneCode = cust['phoneCode'];
              mobile.text = cust['mobile'];
              whatsAppNo.text = cust['whatsAppNo'];
              companyAddress.text = cust['companyAddress'];
              companyEmail.text = cust['companyEmail'];
              companyName.text = cust['companyName'];

              studentPlace.text = cust['place'] ?? '';
              // careOfNo.text = cust['careOfNo'];
              agentName.text = agentDataById[cust['agentId']]['name'];
            } catch (e) {
              print(e);
            }
          }

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color(0xFFECF0F5),
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: true,
              title: Text(
                'Details',
                style: FlutterFlowTheme.title1.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF090F13),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0,
            ),
            backgroundColor: Color(0xFFECF0F5),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  color: Color(0xFFF1F4F8),
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24, 12, 24, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  cust['photo'] == ''
                                      ? Container(
                                          width: 60,
                                          height: 60,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png',
                                          ),
                                        )
                                      : Container(
                                          width: 60,
                                          height: 60,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: cust['photo'],
                                          ),
                                        ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: Text(
                                            cust.id,
                                            style: FlutterFlowTheme.title3
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 2, 0, 0),
                                          child: Text(
                                            cust['name'],
                                            style: FlutterFlowTheme.title3
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 3, 0, 0),
                                          child: Text(
                                            cust['email'],
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF4B39EF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SingleChildScrollView(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(items.length,
                                            (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                print(
                                                    '[[[[[[[[[[[[[[[[[[projectsList]]]]]]]]]]]]]]]]]]');
                                                print(projectsList);
                                                print(indexNum);

                                                selectedIndex = index;

                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 90,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: selectedIndex == index
                                                      ? Color(0xff0054FF)
                                                      : Color(0xFFF1F4F8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 5,
                                                      color: Color(0x3B000000),
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(4, 4, 4, 4),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      index < 1
                                                          ? (index == 0 && PD)
                                                              // (index == 1 &&
                                                              //     TK)
                                                              ? Icon(
                                                                  Icons
                                                                      .done_all_outlined,
                                                                  color: selectedIndex ==
                                                                          index
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xFF43B916),
                                                                  size: 30,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .access_time_rounded,
                                                                  color: selectedIndex ==
                                                                          index
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .red,
                                                                  size: 25,
                                                                )
                                                          : Container(),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 8, 0, 0),
                                                        child: Text(
                                                          items[index]['name'],
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: selectedIndex ==
                                                                    index
                                                                ? Colors.white
                                                                : Color(
                                                                    0xFF090F13),
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  selectedIndex == 0
                      ?

                      //PERSONAL DETAILS
                      Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  //HEADING
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 10, 30, 5),
                                    child: Text(
                                      'Personal Details',
                                      style: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF8B97A2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                    ),
                                  ),

                                  //NAME EMAIL PHONE WHTSAPP
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 10, 30, 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 330,
                                            height: 65,
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
                                                controller: nameController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Customer Name',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter First Name',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 330,
                                            height: 65,
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
                                                controller: email,
                                                obscureText: false,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (v) {
                                                  if (v.isNotEmpty) {
                                                    if (!v.contains('@')) {
                                                      return "Enter valid Email Address";
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter Email',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 330,
                                            height: 65,
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
                                              child: Row(
                                                children: [
                                                  CountryPickerDropdown(
                                                    initialValue:
                                                        countryCode ?? 'IN',
                                                    itemBuilder:
                                                        _buildDropdownItem,
                                                    // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                                                    priorityList: [
                                                      CountryPickerUtils
                                                          .getCountryByIsoCode(
                                                              'GB'),
                                                      CountryPickerUtils
                                                          .getCountryByIsoCode(
                                                              'CN'),
                                                    ],
                                                    sortComparator: (Country a,
                                                            Country b) =>
                                                        a.isoCode.compareTo(
                                                            b.isoCode),
                                                    onValuePicked:
                                                        (Country country) {
                                                      countryCode =
                                                          country.isoCode;
                                                      phoneCode = '+' +
                                                          country.phoneCode;

                                                      setState(() {});
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller: mobile,
                                                      obscureText: false,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      validator: (v) {
                                                        if (!phnValidation
                                                            .hasMatch(v)) {
                                                          return "Enter valid Phone Number";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      maxLength: 10,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Mobile',
                                                        labelStyle:
                                                            FlutterFlowTheme
                                                                .bodyText2
                                                                .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        hintText:
                                                            'Please Enter Mobile',
                                                        hintStyle:
                                                            FlutterFlowTheme
                                                                .bodyText2
                                                                .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
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
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
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
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 330,
                                            height: 65,
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
                                                controller: whatsAppNo,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (v) {
                                                  if (!phnValidation
                                                      .hasMatch(v)) {
                                                    return "Enter valid Phone Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'whatsAppNo',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter whatsApp Number',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //PERSONAL DETAILS
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 10, 30, 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 330,
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
                                                controller: studentPlace,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'place',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter place',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 330,
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
                                                controller: companyName,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Company Name',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter Company Name',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 330,
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
                                                controller: companyEmail,
                                                obscureText: false,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (v) {
                                                  if (v.isNotEmpty) {
                                                    if (!v.contains('@')) {
                                                      return "Enter valid Email Address";
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'Company Email',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter Company Email',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //ADDRESS
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 10, 30, 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 330,
                                            height: 100,
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
                                                maxLines: 5,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                controller: address,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Address',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter Address',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 330,
                                            height: 100,
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
                                                maxLines: 5,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                controller: companyAddress,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Company Address',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter Company Address',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //c/o details
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 10, 30, 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 330,
                                            height: 65,
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
                                              child: SearchField(
                                                suggestions: agentNumberList,
                                                controller: agentName,
                                                hint:
                                                    'Please Enter c/o Agent Number',
                                                searchStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                ),
                                                searchInputDecoration:
                                                    InputDecoration(
                                                  labelText: 'c/o Number',
                                                  labelStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  hintText:
                                                      'Please Enter c/o Name',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
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
                                                onTap: (x) {
                                                  agentName.text = x;
                                                  setState(() {
                                                    print(x);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Spacer(),
                                        // Expanded(
                                        //   child: Container(
                                        //     width: 350,
                                        //     height: 60,
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.white,
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //       border: Border.all(
                                        //         color: Color(0xFFE6E6E6),
                                        //       ),
                                        //     ),
                                        //     child: Padding(
                                        //       padding: EdgeInsets.fromLTRB(
                                        //           16, 0, 0, 0),
                                        //       child: TextFormField(
                                        //         controller: careOfNo,
                                        //         obscureText: false,
                                        //         decoration: InputDecoration(
                                        //           labelText: 'C/0 Number',
                                        //           labelStyle: FlutterFlowTheme
                                        //               .bodyText2
                                        //               .override(
                                        //                   fontFamily:
                                        //                       'Montserrat',
                                        //                   color: Colors.black,
                                        //                   fontWeight:
                                        //                       FontWeight.w500,
                                        //                   fontSize: 12),
                                        //           hintText:
                                        //               'Please Enter Number',
                                        //           hintStyle: FlutterFlowTheme
                                        //               .bodyText2
                                        //               .override(
                                        //                   fontFamily:
                                        //                       'Montserrat',
                                        //                   color: Colors.black,
                                        //                   fontWeight:
                                        //                       FontWeight.w500,
                                        //                   fontSize: 12),
                                        //           enabledBorder:
                                        //               UnderlineInputBorder(
                                        //             borderSide: BorderSide(
                                        //               color: Colors.transparent,
                                        //               width: 1,
                                        //             ),
                                        //             borderRadius:
                                        //                 const BorderRadius.only(
                                        //               topLeft:
                                        //                   Radius.circular(4.0),
                                        //               topRight:
                                        //                   Radius.circular(4.0),
                                        //             ),
                                        //           ),
                                        //           focusedBorder:
                                        //               UnderlineInputBorder(
                                        //             borderSide: BorderSide(
                                        //               color: Colors.transparent,
                                        //               width: 1,
                                        //             ),
                                        //             borderRadius:
                                        //                 const BorderRadius.only(
                                        //               topLeft:
                                        //                   Radius.circular(4.0),
                                        //               topRight:
                                        //                   Radius.circular(4.0),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         style: FlutterFlowTheme
                                        //             .bodyText2
                                        //             .override(
                                        //                 fontFamily:
                                        //                     'Montserrat',
                                        //                 color:
                                        //                     Color(0xFF8B97A2),
                                        //                 fontWeight:
                                        //                     FontWeight.w500,
                                        //                 fontSize: 13),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //BUTTONS
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 50, top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            final FormState form =
                                                formKey.currentState;

                                            if (form.validate()) {
                                              bool pressed = await alert(
                                                  context,
                                                  'Update Customer Details');
                                              if (pressed) {
                                                cust.reference.update({
                                                  'name': nameController.text,
                                                  'email': email.text,
                                                  'mobile': mobile.text,
                                                  'countryCode': countryCode,
                                                  'phoneCode': phoneCode,
                                                  'nationality':
                                                      nationality.text,
                                                  'whatsAppNo': whatsAppNo.text,
                                                  'address': address.text,
                                                  'place': studentPlace.text,
                                                  'companyName':
                                                      companyName.text,
                                                  'companyAddress':
                                                      companyAddress.text,
                                                  'companyEmail':
                                                      companyEmail.text,
                                                  'agentId': agentIdByNumber[
                                                      agentName.text],
                                                  'photo': uploadedFileUrl,
                                                }).then((value) {
                                                  loaded = false;
                                                  setState(() {});
                                                });
                                                showUploadMessage(context,
                                                    'Personal Details updated...');
                                              }
                                            }
                                          },
                                          text: 'Update',
                                          options: FFButtonOptions(
                                            width: 130,
                                            height: 40,
                                            color: Color(0xff0054FF),
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                ],
                              ),
                            ),
                          ),
                        )
                      : selectedIndex == 1 && subTabView == false
                          ?

                          //Project LIST TABLE
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    //heading

                                    projectsList.length == 0
                                        ? LottieBuilder.network(
                                            'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                                            height: 500,
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            child: DataTable(
                                              horizontalMargin: 10,
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    "Project Id",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text("Date",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("Project Name",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("Project Type",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("Status",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("Action",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                              ],
                                              rows: List.generate(
                                                projectsList.length,
                                                (index) {
                                                  if (projectsList.length ==
                                                      1) {
                                                    indexNum = 0;
                                                    subTabView = true;
                                                    selectedProject =
                                                        projectsList[0];
                                                  }
                                                  var datas =
                                                      projectsList[index];

                                                  return DataRow(
                                                    color: index.isOdd
                                                        ? MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50
                                                                .withOpacity(
                                                                    0.7))
                                                        : MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50),
                                                    cells: [
                                                      DataCell(Text(
                                                        datas['projectId'],
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                      DataCell(Text(
                                                        dateTimeFormat(
                                                            'd-MMM-y',
                                                            datas['date']
                                                                .toDate()),
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                      DataCell(Text(
                                                        datas['projectName'],
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                      DataCell(Text(
                                                        datas['projectType'],
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),

                                                      DataCell(Text(
                                                        datas['status'],
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: datas['status'] ==
                                                                  'Completed'
                                                              ? Color(
                                                                  0xff0054FF)
                                                              : datas['status'] ==
                                                                      'Suspended'
                                                                  ? Colors.red
                                                                  : datas['status'] ==
                                                                          'Pending'
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .teal,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                      DataCell(
                                                        Row(
                                                          children: [
                                                            FFButtonWidget(
                                                              onPressed: () {
                                                                setState(() {
                                                                  indexNum =
                                                                      index;
                                                                  subTabView =
                                                                      true;
                                                                  selectedProject =
                                                                      projectsList[
                                                                          index];
                                                                });
                                                              },
                                                              text: 'View',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: 90,
                                                                height: 30,
                                                                color: Color(
                                                                    0xff0054FF),
                                                                textStyle: FlutterFlowTheme.subtitle2.override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .transparent,
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
                                          )
                                  ],
                                ),
                              ),
                            )
                          : selectedIndex == 1 && subTabView == true

                              //PROJECT SINGLE PAGE
                              ? cProjects(projectsList[indexNum])
                              : selectedIndex == 2
                                  ?

                                  //PAYMENT DETAIL
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            //head
                                            Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(30, 5, 30, 20),
                                                child: Text(
                                                  'Payment Details',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF8B97A2),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 17),
                                                )),
                                            SizedBox(
                                              width: 30,
                                            ),

                                            //PROJECT NAMES & PRIZE DETAILS

                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.025),
                                                  Text(
                                                    'Projects & Services : ',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    child:
                                                        CustomDropdown.search(
                                                      hintText:
                                                          'Select Project or Services',
                                                      items:
                                                          customerServiceAndProjectNames,
                                                      controller: projectName,
                                                      // excludeSelected: false,

                                                      onChanged: (text) {
                                                        if (projectIdByName[
                                                                projectName
                                                                    .text] !=
                                                            null) {
                                                          service = false;
                                                          currentProject =
                                                              projectDataById[
                                                                  projectIdByName[
                                                                      projectName
                                                                          .text]];
                                                        } else {
                                                          service = true;
                                                          currentProject = {
                                                            'projectCost': serviceDataById[
                                                                    serviceIdByName[
                                                                        projectName
                                                                            .text]]
                                                                [
                                                                'serviceAmount'],
                                                            'totalPaid': serviceDataById[
                                                                    serviceIdByName[
                                                                        projectName
                                                                            .text]]
                                                                ['totalPaid'],
                                                          };
                                                        }
                                                        setState(() {
                                                          print(currentProject);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Total Amount :',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: currentProject[
                                                                          'projectCost'] !=
                                                                      null
                                                                  ? currentProject[
                                                                              'projectCost'] !=
                                                                          0
                                                                      ? Text(_formatNumber(currentProject[
                                                                              'projectCost']
                                                                          .toString()
                                                                          .replaceAll(
                                                                              ',',
                                                                              '')))
                                                                      // currentProject[
                                                                      //             'projectCost']
                                                                      //         .toString())
                                                                      : Text('')
                                                                  : Text(''),
                                                            )
                                                          ])),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Total Amount paid :',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  currentProject[
                                                                              'projectCost'] ==
                                                                          null
                                                                      ? ''
                                                                      : currentProject['projectCost'] !=
                                                                              0
                                                                          ? _formatNumber(currentProject['totalPaid'].toString().replaceAll(
                                                                              ',',
                                                                              ''))
                                                                          // (currentProject['totalPaid']
                                                                          //           .toString())
                                                                          : '',
                                                                ))
                                                          ])),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Total Due Amount :',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: currentProject[
                                                                          'projectCost'] ==
                                                                      null
                                                                  ? Text('')
                                                                  : currentProject[
                                                                              'projectCost'] !=
                                                                          0
                                                                      ? Text(_formatNumber((currentProject['projectCost'] -
                                                                              currentProject[
                                                                                  'totalPaid'])
                                                                          .toString()
                                                                          .replaceAll(
                                                                              ',',
                                                                              '')))
                                                                      // (currentProject['projectCost'] -
                                                                      //             currentProject['totalPaid'])
                                                                      //         .toString())
                                                                      : Text(
                                                                          ''),
                                                            )
                                                          ])),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(
                                              width: 30,
                                            ),

                                            SizedBox(
                                              height: 30,
                                            ),

                                            //add Payment
                                            Container(
                                                child: Form(
                                              key: formKey,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //Date Picker
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        height: 65,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          showDatePicker(context: context, locale: Locale('en', 'IN'), initialDate: selectedDate, firstDate: DateTime(1901, 1), lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59))
                                                                              .then((value) {
                                                                            setState(() {
                                                                              if (value != null) {
                                                                                selectedDate = value;
                                                                              } else {
                                                                                selectedDate = selectedDate;
                                                                              }
                                                                            });
                                                                          });
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          dateTimeFormat(
                                                                              'd-MMM-y',
                                                                              selectedDate),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            color:
                                                                                Colors.blue,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        )),
                                                              )
                                                            ])),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),

                                                    //STAFF NAME
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      height: 65,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child:
                                                          CustomDropdown.search(
                                                        hintText:
                                                            'Select Staff',
                                                        items: staffNames,
                                                        controller: staffName,
                                                        onChanged: (text) {
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),

                                                    //AMOUNT
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      height: 65,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFE6E6E6),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                16, 0, 0, 0),
                                                        child: TextFormField(
                                                          controller:
                                                              payingAmount,
                                                          obscureText: false,
                                                          onChanged: (string) {
                                                            string =
                                                                '${_formatNumber(string.replaceAll(',', ''))}';
                                                            payingAmount.value =
                                                                TextEditingValue(
                                                              text: string,
                                                              selection: TextSelection
                                                                  .collapsed(
                                                                      offset: string
                                                                          .length),
                                                            );
                                                            print(string);
                                                            String str = string
                                                                .replaceAll(
                                                                    ',', '');
                                                            print(str);
                                                          },
                                                          validator: (v) {
                                                            if (currentProject ==
                                                                    null ||
                                                                currentProject ==
                                                                    {}) {
                                                              return null;
                                                            } else {
                                                              return currentProject
                                                                          .length !=
                                                                      0
                                                                  ? double.tryParse(payingAmount.text.replaceAll(
                                                                              ',',
                                                                              '')) >
                                                                          (currentProject['projectCost'] -
                                                                              currentProject['totalPaid'])
                                                                      ? 'Amount must be less than total due amount'
                                                                      : null
                                                                  : null;
                                                            }
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            prefixText:
                                                                _currency,
                                                            labelText: 'Amount',
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
                                                                    fontSize:
                                                                        12),
                                                            hintText:
                                                                'Please Enter Amount',
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
                                                                    fontSize:
                                                                        12),
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
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),

                                                    //Description
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      height: 65,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFE6E6E6),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                16, 0, 0, 0),
                                                        child: TextFormField(
                                                          controller:
                                                              description,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Description',
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
                                                                    fontSize:
                                                                        12),
                                                            hintText:
                                                                'Please Enter Description',
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
                                                                    fontSize:
                                                                        12),
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
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),

                                                    //BANK & CASH
                                                    Text('Bank'),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                    ),
                                                    Radio(
                                                      activeColor:
                                                          Colors.yellow,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .grey[200]),
                                                      focusColor: Colors.green,
                                                      value: 'Bank',
                                                      groupValue:
                                                          paymentMethode,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          paymentMethode =
                                                              value.toString();
                                                          // paymentType = false;
                                                          // radioval = 'Bank';
                                                          // print(radioval);
                                                          // radioSelected1 =
                                                          //     value;
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),
                                                    Text('Cash'),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                    ),
                                                    Radio(
                                                      activeColor:
                                                          Colors.yellow,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .grey[200]),
                                                      focusColor: Colors.green,
                                                      value: 'Cash',
                                                      groupValue:
                                                          paymentMethode,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          paymentMethode =
                                                              value.toString();
                                                          // paymentType = false;
                                                          // radioval = 'Bank';
                                                          // print(radioval);
                                                          // radioSelected1 =
                                                          //     value;
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                    ),

                                                    //ADD BUTTON
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 8, 0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          print(
                                                              '=======================================================');
                                                          print(paymentMethode);
                                                          final FormState form =
                                                              formKey
                                                                  .currentState;
                                                          if (form.validate()) {
                                                            if (currentProject !=
                                                                    null ||
                                                                currentProject !=
                                                                    {}) {
                                                              if (service) {
                                                                if (paymentMethode ==
                                                                    'Cash') {
                                                                  if (payingAmount
                                                                              .text !=
                                                                          '' &&
                                                                      paymentMethode !=
                                                                          '' &&
                                                                      staffName
                                                                              .text !=
                                                                          '' &&
                                                                      description
                                                                              .text !=
                                                                          '') {
                                                                    DocumentSnapshot doc = await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .get();
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .update({
                                                                      'billNumber':
                                                                          FieldValue.increment(
                                                                              1),
                                                                    });

                                                                    //incrementing firebase value of totalPaid

                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'customerServices')
                                                                        .doc(serviceIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'totalPaid': FieldValue.increment(int.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              ''))),
                                                                    });

                                                                    int billNumber =
                                                                        doc['billNumber'];
                                                                    print(doc[
                                                                        'billNumber']);
                                                                    billNumber++;
                                                                    String ref =
                                                                        '${branchShortNameMap[currentBranchId]}R';
                                                                    String
                                                                        billCode =
                                                                        '$ref$billNumber';
                                                                    print(
                                                                        billCode);

                                                                    print(
                                                                        '{{{{{{{{{}}}}}}}}}}');
                                                                    double amountValue = double.tryParse(payingAmount
                                                                        .text
                                                                        .replaceAll(
                                                                            ',',
                                                                            ''));
                                                                    print(
                                                                        '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
                                                                    print(
                                                                        amountValue);
                                                                    List
                                                                        feePaid =
                                                                        [];
                                                                    feePaid
                                                                        .add({
                                                                      'amount': double.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'billCode':
                                                                          billCode,
                                                                      'totalPaid': currentProject[
                                                                              'totalPaid'] +
                                                                          double.tryParse(payingAmount.text.replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'staffName':
                                                                          staffName
                                                                              .text,
                                                                      'description':
                                                                          description
                                                                              .text,
                                                                      'datePaid':
                                                                          selectedDate,
                                                                      'paymentMethod':
                                                                          paymentMethode,
                                                                      'serviceId':
                                                                          serviceIdByName[
                                                                              projectName.text],
                                                                    });

                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'customerServices')
                                                                        .doc(serviceIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'paymentDetails':
                                                                          FieldValue.arrayUnion(
                                                                              feePaid),
                                                                    }).then((value) {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'settings')
                                                                          .doc(
                                                                              currentBranchId)
                                                                          .update({
                                                                        'cashInHand':
                                                                            FieldValue.increment(amountValue)
                                                                      });
                                                                    });

                                                                    loaded =
                                                                        false;

                                                                    showUploadMessage(
                                                                        context,
                                                                        'Fee details added successfully');

                                                                    payingAmount
                                                                        .text = '';
                                                                    staffName
                                                                        .text = '';
                                                                    description
                                                                        .text = '';
                                                                    projectName
                                                                        .text = '';
                                                                    selectedDate =
                                                                        DateTime
                                                                            .now();
                                                                    currentProject =
                                                                        {};
                                                                    paymentMethode =
                                                                        '';
                                                                    // paymentType = false;

                                                                    setState(
                                                                        () {});
                                                                  } else {
                                                                    staffName.text ==
                                                                            ''
                                                                        ? showUploadMessage(
                                                                            context,
                                                                            'Please Enter Staff Name')
                                                                        : payingAmount.text ==
                                                                                ''
                                                                            ? showUploadMessage(context,
                                                                                'Please Enter Amount')
                                                                            : description.text == ''
                                                                                ? showUploadMessage(context, 'Please Enter Description')
                                                                                : showUploadMessage(context, 'Please Choose The Payment Method');
                                                                  }
                                                                } else if (paymentMethode ==
                                                                    'Bank') {
                                                                  if (payingAmount.text != '' &&
                                                                          paymentMethode !=
                                                                              '' &&
                                                                          staffName.text !=
                                                                              '' &&
                                                                          description.text !=
                                                                              ''
                                                                      // &&
                                                                      // (urlDownload !=
                                                                      //         null &&
                                                                      //     urlDownload !=
                                                                      //         '')
                                                                      ) {
                                                                    DocumentSnapshot doc = await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .get();
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .update({
                                                                      'billNumber':
                                                                          FieldValue.increment(
                                                                              1),
                                                                    });

                                                                    //incrementing firebase value of totalPaid

                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'customerServices')
                                                                        .doc(serviceIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'totalPaid': FieldValue.increment(int.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              ''))),
                                                                    });

                                                                    int billNumber =
                                                                        doc['billNumber'];
                                                                    print(doc[
                                                                        'billNumber']);
                                                                    billNumber++;
                                                                    String ref =
                                                                        '${branchShortNameMap[currentBranchId]}R';
                                                                    String
                                                                        billCode =
                                                                        '$ref$billNumber';
                                                                    print(
                                                                        billCode);

                                                                    print(
                                                                        '{{{{{{{{{}}}}}}}}}}');
                                                                    double amountValue = double.tryParse(payingAmount
                                                                        .text
                                                                        .replaceAll(
                                                                            ',',
                                                                            ''));
                                                                    print(
                                                                        '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
                                                                    print(
                                                                        amountValue);
                                                                    List
                                                                        feePaid =
                                                                        [];
                                                                    feePaid
                                                                        .add({
                                                                      'amount': double.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'billCode':
                                                                          billCode,
                                                                      'totalPaid': currentProject[
                                                                              'totalPaid'] +
                                                                          int.tryParse(payingAmount.text.replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'paymentProof':
                                                                          urlDownload,
                                                                      'staffName':
                                                                          staffName
                                                                              .text,
                                                                      'description':
                                                                          description
                                                                              .text,
                                                                      'datePaid':
                                                                          selectedDate,
                                                                      'paymentMethod':
                                                                          paymentMethode,
                                                                      'serviceId':
                                                                          serviceIdByName[
                                                                              projectName.text],
                                                                    });
                                                                    print(feePaid
                                                                        .toString());
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'customerServices')
                                                                        .doc(serviceIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'paymentDetails':
                                                                          FieldValue.arrayUnion(
                                                                              feePaid),
                                                                    }).then((value) {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'settings')
                                                                          .doc(
                                                                              currentBranchId)
                                                                          .update({
                                                                        'cashAtBank':
                                                                            FieldValue.increment(amountValue)
                                                                      });
                                                                    });

                                                                    loaded =
                                                                        false;

                                                                    showUploadMessage(
                                                                        context,
                                                                        'Fee details added successfully');

                                                                    payingAmount
                                                                        .text = '';
                                                                    staffName
                                                                        .text = '';
                                                                    description
                                                                        .text = '';
                                                                    projectName
                                                                        .text = '';
                                                                    selectedDate =
                                                                        DateTime
                                                                            .now();
                                                                    currentProject =
                                                                        {};
                                                                    urlDownload =
                                                                        '';
                                                                    // bank = false;
                                                                    // paymentType = false;
                                                                    paymentMethode =
                                                                        '';

                                                                    setState(
                                                                        () {});
                                                                  } else {
                                                                    staffName.text ==
                                                                            ''
                                                                        ? showUploadMessage(
                                                                            context,
                                                                            'Please Enter Staff Name')
                                                                        : payingAmount.text ==
                                                                                ''
                                                                            ? showUploadMessage(context,
                                                                                'Please Enter Amount')
                                                                            : description.text == ''
                                                                                ? showUploadMessage(context, 'Please Enter Description')
                                                                                : urlDownload == null || urlDownload == ''
                                                                                    ? showUploadMessage(context, 'Please upload a document first!!')
                                                                                    : showUploadMessage(context, 'Please Choose The Payment Method');
                                                                  }
                                                                }
                                                              } else {
                                                                if (paymentMethode ==
                                                                    'Cash') {
                                                                  if (payingAmount
                                                                              .text !=
                                                                          '' &&
                                                                      paymentMethode !=
                                                                          '' &&
                                                                      staffName
                                                                              .text !=
                                                                          '' &&
                                                                      description
                                                                              .text !=
                                                                          '') {
                                                                    DocumentSnapshot doc = await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .get();
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .update({
                                                                      'billNumber':
                                                                          FieldValue.increment(
                                                                              1),
                                                                    });

                                                                    //incrementing firebase value of totalPaid

                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'projects')
                                                                        .doc(projectIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'totalPaid': FieldValue.increment(int.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              ''))),
                                                                    });

                                                                    int billNumber =
                                                                        doc['billNumber'];
                                                                    print(doc[
                                                                        'billNumber']);
                                                                    billNumber++;
                                                                    String ref =
                                                                        '${branchShortNameMap[currentBranchId]}R';
                                                                    String
                                                                        billCode =
                                                                        '$ref$billNumber';
                                                                    print(
                                                                        billCode);

                                                                    print(
                                                                        '{{{{{{{{{}}}}}}}}}}');
                                                                    double amountValue = double.tryParse(payingAmount
                                                                        .text
                                                                        .replaceAll(
                                                                            ',',
                                                                            ''));
                                                                    print(
                                                                        '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
                                                                    print(
                                                                        amountValue);
                                                                    List
                                                                        feePaid =
                                                                        [];
                                                                    feePaid
                                                                        .add({
                                                                      'amount': double.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'billCode':
                                                                          billCode,
                                                                      'totalPaid': currentProject[
                                                                              'totalPaid'] +
                                                                          double.tryParse(payingAmount.text.replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'staffName':
                                                                          staffName
                                                                              .text,
                                                                      'description':
                                                                          description
                                                                              .text,
                                                                      'datePaid':
                                                                          selectedDate,
                                                                      'paymentMethod':
                                                                          paymentMethode,
                                                                      'projectId':
                                                                          projectIdByName[
                                                                              projectName.text],
                                                                    });

                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'projects')
                                                                        .doc(projectIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'paymentDetails':
                                                                          FieldValue.arrayUnion(
                                                                              feePaid),
                                                                    }).then((value) {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'settings')
                                                                          .doc(
                                                                              currentBranchId)
                                                                          .update({
                                                                        'cashInHand':
                                                                            FieldValue.increment(amountValue)
                                                                      });
                                                                    });

                                                                    loaded =
                                                                        false;

                                                                    showUploadMessage(
                                                                        context,
                                                                        'Fee details added successfully');

                                                                    payingAmount
                                                                        .text = '';
                                                                    staffName
                                                                        .text = '';
                                                                    description
                                                                        .text = '';
                                                                    projectName
                                                                        .text = '';
                                                                    selectedDate =
                                                                        DateTime
                                                                            .now();
                                                                    currentProject =
                                                                        {};
                                                                    paymentMethode =
                                                                        '';
                                                                    // paymentType = false;

                                                                    setState(
                                                                        () {});
                                                                  } else {
                                                                    staffName.text ==
                                                                            ''
                                                                        ? showUploadMessage(
                                                                            context,
                                                                            'Please Enter Staff Name')
                                                                        : payingAmount.text ==
                                                                                ''
                                                                            ? showUploadMessage(context,
                                                                                'Please Enter Amount')
                                                                            : description.text == ''
                                                                                ? showUploadMessage(context, 'Please Enter Description')
                                                                                : showUploadMessage(context, 'Please Choose The Payment Method');
                                                                  }
                                                                } else if (paymentMethode ==
                                                                    'Bank') {
                                                                  if (payingAmount.text != '' &&
                                                                          paymentMethode !=
                                                                              '' &&
                                                                          staffName.text !=
                                                                              '' &&
                                                                          description.text !=
                                                                              ''
                                                                      // &&
                                                                      // (urlDownload !=
                                                                      //         null &&
                                                                      //     urlDownload !=
                                                                      //         '')
                                                                      ) {
                                                                    DocumentSnapshot doc = await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .get();
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'settings')
                                                                        .doc(
                                                                            currentBranchId)
                                                                        .update({
                                                                      'billNumber':
                                                                          FieldValue.increment(
                                                                              1),
                                                                    });

                                                                    //incrementing firebase value of totalPaid

                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'projects')
                                                                        .doc(projectIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'totalPaid': FieldValue.increment(int.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              ''))),
                                                                    });

                                                                    int billNumber =
                                                                        doc['billNumber'];
                                                                    print(doc[
                                                                        'billNumber']);
                                                                    billNumber++;
                                                                    String ref =
                                                                        '${branchShortNameMap[currentBranchId]}R';
                                                                    String
                                                                        billCode =
                                                                        '$ref$billNumber';
                                                                    print(
                                                                        billCode);

                                                                    print(
                                                                        '{{{{{{{{{}}}}}}}}}}');
                                                                    double amountValue = double.tryParse(payingAmount
                                                                        .text
                                                                        .replaceAll(
                                                                            ',',
                                                                            ''));
                                                                    print(
                                                                        '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
                                                                    print(
                                                                        amountValue);
                                                                    List
                                                                        feePaid =
                                                                        [];
                                                                    feePaid
                                                                        .add({
                                                                      'amount': double.tryParse(payingAmount
                                                                          .text
                                                                          .replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'billCode':
                                                                          billCode,
                                                                      'totalPaid': currentProject[
                                                                              'totalPaid'] +
                                                                          int.tryParse(payingAmount.text.replaceAll(
                                                                              ',',
                                                                              '')),
                                                                      'paymentProof':
                                                                          urlDownload,
                                                                      'staffName':
                                                                          staffName
                                                                              .text,
                                                                      'description':
                                                                          description
                                                                              .text,
                                                                      'datePaid':
                                                                          selectedDate,
                                                                      'paymentMethod':
                                                                          paymentMethode,
                                                                      'projectId':
                                                                          projectIdByName[
                                                                              projectName.text],
                                                                    });
                                                                    print(feePaid
                                                                        .toString());
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'projects')
                                                                        .doc(projectIdByName[
                                                                            projectName.text])
                                                                        .update({
                                                                      'paymentDetails':
                                                                          FieldValue.arrayUnion(
                                                                              feePaid),
                                                                    }).then((value) {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'settings')
                                                                          .doc(
                                                                              currentBranchId)
                                                                          .update({
                                                                        'cashAtBank':
                                                                            FieldValue.increment(amountValue)
                                                                      });
                                                                    });

                                                                    loaded =
                                                                        false;

                                                                    showUploadMessage(
                                                                        context,
                                                                        'Fee details added successfully');

                                                                    payingAmount
                                                                        .text = '';
                                                                    staffName
                                                                        .text = '';
                                                                    description
                                                                        .text = '';
                                                                    projectName
                                                                        .text = '';
                                                                    selectedDate =
                                                                        DateTime
                                                                            .now();
                                                                    currentProject =
                                                                        {};
                                                                    urlDownload =
                                                                        '';
                                                                    // bank = false;
                                                                    // paymentType = false;
                                                                    paymentMethode =
                                                                        '';

                                                                    setState(
                                                                        () {});
                                                                  } else {
                                                                    staffName.text ==
                                                                            ''
                                                                        ? showUploadMessage(
                                                                            context,
                                                                            'Please Enter Staff Name')
                                                                        : payingAmount.text ==
                                                                                ''
                                                                            ? showUploadMessage(context,
                                                                                'Please Enter Amount')
                                                                            : description.text == ''
                                                                                ? showUploadMessage(context, 'Please Enter Description')
                                                                                : urlDownload == null || urlDownload == ''
                                                                                    ? showUploadMessage(context, 'Please upload a document first!!')
                                                                                    : showUploadMessage(context, 'Please Choose The Payment Method');
                                                                  }
                                                                }
                                                              }
                                                            } else {
                                                              showUploadMessage(
                                                                  context,
                                                                  'Please Select A Project');
                                                            }
                                                          }
                                                        },
                                                        text: 'Add',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 80,
                                                          height: 40,
                                                          color:
                                                              Color(0xff0054FF),
                                                          textStyle:
                                                              FlutterFlowTheme
                                                                  .subtitle2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          elevation: 2,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius: 50,
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                            )),
                                            SizedBox(
                                              width: 30,
                                            ),

                                            //UPLOAD SCREENSHOT

                                            paymentMethode == 'Bank'
                                                ? Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                        //UploadButton
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                selectFileToUpload(
                                                                    'bankPaymentProof',
                                                                    context);
                                                              },
                                                              child: Text(
                                                                urlDownload ==
                                                                            null ||
                                                                        urlDownload ==
                                                                            ''
                                                                    ? 'Upload'
                                                                    : 'Edit',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )),
                                                        ),
                                                      ]))
                                                : SizedBox(
                                                    width: 30,
                                                  ),
                                            SizedBox(
                                              height: 60,
                                            ),

                                            //Sorting DROPDOWNS

                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                    //ProjectName Sort
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: CustomDropdown
                                                            .search(
                                                          hintText: 'Projects',
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          items:
                                                              customerServiceAndProjectNames,
                                                          excludeSelected: true,
                                                          controller:
                                                              projectNameSortValue,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              // getPaymentDetails();
                                                              getSortedPayments();
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),

                                                    //STAFF NAME Sort
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: CustomDropdown
                                                            .search(
                                                          hintText: 'Staffs',
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          items:
                                                              staffNamesSortList,
                                                          excludeSelected: true,
                                                          controller:
                                                              staffNameSortValue,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              staffNameSortValue
                                                                  .text = val;
                                                              // getPaymentDetails();
                                                              getSortedPayments();
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            //PAYMENT TABLE
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: payments.length == 0
                                                  ? Center(
                                                      child: Text(
                                                      'No payments yet.',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13),
                                                    ))
                                                  : DataTable(
                                                      horizontalMargin: 12,
                                                      columns: [
                                                        DataColumn(
                                                          label: Text(
                                                            "Date",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                              "Project Name",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        DataColumn(
                                                          label: Text("Amount",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                              "Description",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                              "Payment Method",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        DataColumn(
                                                          label: Text("Proof",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            "Staff Name",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Text(" ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        DataColumn(
                                                          label: Text(" ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                      ],
                                                      rows: List.generate(
                                                        projectAndServicePaymentList
                                                            .length,
                                                        (index) {
                                                          var feeDetail =
                                                              projectAndServicePaymentList[
                                                                  index];

                                                          return DataRow(
                                                            color: index.isOdd
                                                                ? MaterialStateProperty
                                                                    .all(Colors
                                                                        .blueGrey
                                                                        .shade50
                                                                        .withOpacity(
                                                                            0.7))
                                                                : MaterialStateProperty
                                                                    .all(Colors
                                                                        .blueGrey
                                                                        .shade50),
                                                            cells: [
                                                              DataCell(Text(
                                                                  dateTimeFormat(
                                                                      'd-MMM-y',
                                                                      feeDetail[
                                                                              'paidDate']
                                                                          .toDate()),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12))),
                                                              DataCell(Text(
                                                                  (feeDetail['projectName'] ??
                                                                          feeDetail[
                                                                              'serviceName'])
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12))),
                                                              DataCell(Text(
                                                                  feeDetail[
                                                                          'amount']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12))),
                                                              DataCell(Text(
                                                                  feeDetail[
                                                                          'description']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12))),
                                                              DataCell(
                                                                Text(
                                                                  feeDetail[
                                                                          'paymentMethode']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              DataCell(InkWell(
                                                                onTap: () {
                                                                  List proofs =
                                                                      feeDetail[
                                                                          'paymentProof'];
                                                                  print(
                                                                      '[[[[[[[[[[[[[[[[[PROOF]]]]]]]]]]]]]]]]]');
                                                                  print(
                                                                      feeDetail);
                                                                  print('here');
                                                                  print(proofs
                                                                      .isNotEmpty);
                                                                  print(
                                                                      'hereasdawds');
                                                                  if (proofs
                                                                      .isNotEmpty) {
                                                                    print(
                                                                        proofs);
                                                                    List<ImageProvider>
                                                                        images =
                                                                        [];

                                                                    for (var a
                                                                        in proofs) {
                                                                      images.add(
                                                                          Image.network(a)
                                                                              .image);
                                                                    }

                                                                    MultiImageProvider
                                                                        multiImageProvider =
                                                                        MultiImageProvider(
                                                                            images);
                                                                    showImageViewerPager(
                                                                      context,
                                                                      multiImageProvider,
                                                                      immersive:
                                                                          false,
                                                                      doubleTapZoomable:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      swipeDismissible:
                                                                          true,
                                                                    );
                                                                  } else {
                                                                    showUploadMessage(
                                                                        context,
                                                                        'There is no Proof to view');
                                                                  }
                                                                },
                                                                child: Text(
                                                                    'View',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .blueAccent,
                                                                        fontSize:
                                                                            12)),
                                                              )),
                                                              DataCell(Text(
                                                                  feeDetail[
                                                                          'staffName']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12))),
                                                              DataCell(
                                                                Row(
                                                                  children: [
                                                                    FlutterFlowIconButton(
                                                                      borderColor:
                                                                          Colors
                                                                              .transparent,
                                                                      borderRadius:
                                                                          30,
                                                                      borderWidth:
                                                                          1,
                                                                      buttonSize:
                                                                          50,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .print,
                                                                        color: Colors
                                                                            .teal,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        print(
                                                                            "[[[[[[[[[[[[[[[[feeDetail['billCode']]]]]]]]]]]]]]]]]");
                                                                        print(
                                                                            feeDetail);
                                                                        try {
                                                                          double projectCost = projectAndServicePaymentList[index]['projectId'] == null
                                                                              ? serviceDataById[projectAndServicePaymentList[index]['serviceId']]['serviceAmount']
                                                                              : projectDataById[projectAndServicePaymentList[index]['projectId']]['projectCost'];
                                                                          final invoice =
                                                                              paymentDetail(
                                                                            nameOfProject: projectAndServicePaymentList[index]['projectName'] == null
                                                                                ? projectAndServicePaymentList[index]['serviceName']
                                                                                : projectAndServicePaymentList[index]['projectName'],
                                                                            name:
                                                                                nameController.text,
                                                                            // selectedProjectType: projectDataById[payments[index]['projectId']]['projectType'],
                                                                            totalProjectCost:
                                                                                projectCost,
                                                                            lastPaymentAmount:
                                                                                projectAndServicePaymentList[index]['amount'],
                                                                            // totalAmountPaid: payments[index]['totalPaid'],
                                                                            totalDue:
                                                                                projectCost - projectAndServicePaymentList[index]['totalPaid'],
                                                                            paymentMethod:
                                                                                projectAndServicePaymentList[index]['paymentMethode'],
                                                                            date:
                                                                                projectAndServicePaymentList[index]['paidDate'].toDate().toString().substring(0, 10),
                                                                            customerName:
                                                                                cust['name'],
                                                                            customerPhoneNo:
                                                                                cust['mobile'],
                                                                            desc:
                                                                                feeDetail['description'],
                                                                            staff:
                                                                                feeDetail['staffName'],
                                                                            receiptNo:
                                                                                feeDetail['billCode'],
                                                                          );

                                                                          final pdfFile =
                                                                              await PrintingFunction.createPrint(invoice);
                                                                          await PdfApi.openFile(
                                                                              pdfFile);
                                                                        } catch (e) {
                                                                          print(
                                                                              e);
                                                                        }
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              DataCell(Row(
                                                                children: [
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                        Colors
                                                                            .transparent,
                                                                    borderRadius:
                                                                        30,
                                                                    borderWidth:
                                                                        1,
                                                                    buttonSize:
                                                                        50,
                                                                    fillColor:
                                                                        Colors
                                                                            .transparent,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .download,
                                                                      color: Colors
                                                                          .teal,
                                                                      size: 25,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      print(
                                                                          "[[[[[[[[[[[[[[[[feeDetail['billCode']]]]]]]]]]]]]]]]]");
                                                                      print(feeDetail[
                                                                          'billCode']);
                                                                      try {
                                                                        double projectCost = projectAndServicePaymentList[index]['projectId'] ==
                                                                                null
                                                                            ? serviceDataById[projectAndServicePaymentList[index]['serviceId']]['serviceAmount']
                                                                            : projectDataById[projectAndServicePaymentList[index]['projectId']]['projectCost'];
                                                                        final invoice =
                                                                            paymentDetail(
                                                                          nameOfProject: projectAndServicePaymentList[index]['projectName'] == null
                                                                              ? projectAndServicePaymentList[index]['serviceName']
                                                                              : projectAndServicePaymentList[index]['projectName'],
                                                                          name:
                                                                              nameController.text,
                                                                          // selectedProjectType: projectDataById[payments[index]['projectId']]['projectType'],
                                                                          totalProjectCost:
                                                                              projectCost,
                                                                          lastPaymentAmount:
                                                                              projectAndServicePaymentList[index]['amount'],
                                                                          // totalAmountPaid: payments[index]['totalPaid'],
                                                                          totalDue:
                                                                              projectCost - projectAndServicePaymentList[index]['totalPaid'],
                                                                          paymentMethod:
                                                                              projectAndServicePaymentList[index]['paymentMethode'],
                                                                          date: projectAndServicePaymentList[index]['paidDate']
                                                                              .toDate()
                                                                              .toString()
                                                                              .substring(0, 10),
                                                                          customerName:
                                                                              cust['name'],
                                                                          customerPhoneNo:
                                                                              cust['mobile'],
                                                                          desc:
                                                                              feeDetail['description'],
                                                                          staff:
                                                                              feeDetail['staffName'],
                                                                          receiptNo:
                                                                              feeDetail['billCode'],
                                                                        );

                                                                        await GeneratePdf.downloadPdf(
                                                                            invoice);

                                                                        // final pdfFile =
                                                                        //     await PrintingFunction.createPrint(
                                                                        //         invoice);
                                                                        // await PdfApi
                                                                        //     .openFile(
                                                                        //         pdfFile);
                                                                      } catch (e) {
                                                                        print(
                                                                            e);
                                                                        // return showDialog(
                                                                        //     context: context,
                                                                        //     builder: (context) {
                                                                        //       return AlertDialog(
                                                                        //         title: Text('error'),
                                                                        //         content: Text(e.toString()),
                                                                        //
                                                                        //         actions: <Widget>[
                                                                        //           new FlatButton(
                                                                        //             child: new Text('ok'),
                                                                        //             onPressed: () {
                                                                        //               Navigator.of(context).pop();
                                                                        //             },
                                                                        //           )
                                                                        //         ],
                                                                        //       );
                                                                        //     });

                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              ))
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            payments.length != 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 15,
                                                                left: 30),
                                                        child: TextButton(
                                                            child: const Text(
                                                                'Generate Excel'),
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff0054FF),
                                                              disabledForegroundColor:
                                                                  Colors.grey
                                                                      .withOpacity(
                                                                          0.38),
                                                            ),
                                                            onPressed: () {
                                                              try {
                                                                importData(cust[
                                                                    'name']);
                                                              } catch (e) {
                                                                print(e);

                                                                return showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'error'),
                                                                        content:
                                                                            Text(e.toString()),
                                                                        actions: <
                                                                            Widget>[
                                                                          ElevatedButton(
                                                                            child:
                                                                                new Text('ok'),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          )
                                                                        ],
                                                                      );
                                                                    });
                                                              }
                                                            }),
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : selectedIndex == 3
                                      ?

                                      //UPLOAD DOCUMENTS
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: Column(
                                              children: [
                                                //head
                                                Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                30, 5, 30, 20),
                                                    child: Text(
                                                      'Documents',
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
                                                              fontSize: 17),
                                                    )),
                                                SizedBox(
                                                  width: 30,
                                                ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.25,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        //Add Document Title
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .only(
                                                                      top: 20,
                                                                      bottom:
                                                                          20),
                                                          child: Text(
                                                            'Add Document',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),

                                                        //Add Fields
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      30,
                                                                      10,
                                                                      30,
                                                                      5),
                                                          child: Container(
                                                            child: Form(
                                                              key: formKey,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    // //Date Picker
                                                                    // Container(
                                                                    //     width: MediaQuery.of(
                                                                    //         context)
                                                                    //         .size
                                                                    //         .width *
                                                                    //         0.1,
                                                                    //     height: 65,
                                                                    //     decoration:
                                                                    //     BoxDecoration(
                                                                    //       color: Colors.white,
                                                                    //       borderRadius:
                                                                    //       BorderRadius
                                                                    //           .circular(8),
                                                                    //       border: Border.all(
                                                                    //         color: Colors.black,
                                                                    //       ),
                                                                    //     ),
                                                                    //     child: Column(
                                                                    //         mainAxisAlignment:
                                                                    //         MainAxisAlignment
                                                                    //             .spaceAround,
                                                                    //         crossAxisAlignment:
                                                                    //         CrossAxisAlignment
                                                                    //             .start,
                                                                    //         children: [
                                                                    //           Padding(
                                                                    //             padding:
                                                                    //             const EdgeInsets
                                                                    //                 .only(
                                                                    //                 left:
                                                                    //                 10),
                                                                    //             child:
                                                                    //             TextButton(
                                                                    //                 onPressed:
                                                                    //                     () {
                                                                    //                   showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(1901, 1), lastDate: DateTime(2100, 1))
                                                                    //                       .then((value) {
                                                                    //                     setState(() {
                                                                    //                       selectedDate = value;
                                                                    //                     });
                                                                    //                   });
                                                                    //                 },
                                                                    //                 child:
                                                                    //                 Text(
                                                                    //                   dateTimeFormat(
                                                                    //                       'd-MMM-y',
                                                                    //                       selectedDate),
                                                                    //                   style:
                                                                    //                   TextStyle(
                                                                    //                     fontFamily:
                                                                    //                     'Poppins',
                                                                    //                     color:
                                                                    //                     Colors.blue,
                                                                    //                     fontSize:
                                                                    //                     17,
                                                                    //                     fontWeight:
                                                                    //                     FontWeight.w600,
                                                                    //                   ),
                                                                    //                 )),
                                                                    //           )
                                                                    //         ])),

                                                                    //PROJECT PICKER
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.2,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      child: CustomDropdown
                                                                          .search(
                                                                        hintText:
                                                                            'Select Project',
                                                                        items:
                                                                            projectNames,
                                                                        controller:
                                                                            projectNameInDocuments,
                                                                        // excludeSelected: false,
                                                                        onChanged:
                                                                            (text) {
                                                                          setState(
                                                                              () {
                                                                            projectNameInDocuments.text =
                                                                                text;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.02,
                                                                    ),

                                                                    //DOCUMENT NAME
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.19,
                                                                      height:
                                                                          65,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Color(0xFFE6E6E6),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              documentName,
                                                                          obscureText:
                                                                              false,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            labelText:
                                                                                'Document Name',
                                                                            labelStyle: FlutterFlowTheme.bodyText2.override(
                                                                                fontFamily: 'Montserrat',
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 12),
                                                                            hintText:
                                                                                'Please Enter Document Name',
                                                                            hintStyle: FlutterFlowTheme.bodyText2.override(
                                                                                fontFamily: 'Montserrat',
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 12),
                                                                            enabledBorder:
                                                                                UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.transparent,
                                                                                width: 1,
                                                                              ),
                                                                              borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(4.0),
                                                                                topRight: Radius.circular(4.0),
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                UnderlineInputBorder(
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
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.02,
                                                                    ),

                                                                    //Description
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.19,
                                                                      height:
                                                                          65,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Color(0xFFE6E6E6),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              documentDescription,
                                                                          obscureText:
                                                                              false,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            labelText:
                                                                                'Description',
                                                                            labelStyle: FlutterFlowTheme.bodyText2.override(
                                                                                fontFamily: 'Montserrat',
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 12),
                                                                            hintText:
                                                                                'Please Enter Description',
                                                                            hintStyle: FlutterFlowTheme.bodyText2.override(
                                                                                fontFamily: 'Montserrat',
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 12),
                                                                            enabledBorder:
                                                                                UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.transparent,
                                                                                width: 1,
                                                                              ),
                                                                              borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(4.0),
                                                                                topRight: Radius.circular(4.0),
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                UnderlineInputBorder(
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
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.02,
                                                                    ),

                                                                    //UPLOAD  DOCUMENT
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10),
                                                                      child: TextButton(
                                                                          onPressed: () {
                                                                            if (documentName.text !=
                                                                                '') {
                                                                              selectFileToUpload(documentName.text, context);
                                                                            } else {
                                                                              showUploadMessage(context, 'Please Enter Document Name');
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            urlDownload == null || urlDownload == ''
                                                                                ? 'Upload'
                                                                                : 'Edit',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              color: Colors.blue,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.02,
                                                                    ),

                                                                    //ADD BUTTON
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                      child:
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          if (documentName.text != '' && documentDescription.text != '' && projectNameInDocuments.text != ''
                                                                              // &&
                                                                              // (urlDownload != '' &&
                                                                              //     urlDownload != null)
                                                                              ) {
                                                                            addToFireBaseDocument('Document ${documentName.text}',
                                                                                context);
                                                                          } else {
                                                                            projectNameInDocuments.text == ''
                                                                                ? showUploadMessage(context, 'Please Select Project')
                                                                                : documentName.text == ''
                                                                                    ? showUploadMessage(context, 'Please Enter Document Name')
                                                                                    : documentDescription.text == ''
                                                                                        ? showUploadMessage(context, 'Please Enter Document Description')
                                                                                        : showUploadMessage(context, 'Please Upload Document');
                                                                          }
                                                                        },
                                                                        text:
                                                                            'Add',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              80,
                                                                          height:
                                                                              40,
                                                                          color:
                                                                              Color(0xff0054FF),
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Lexend Deca',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          elevation:
                                                                              2,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              50,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                //add Document

                                                SizedBox(
                                                  width: 30,
                                                ),

                                                //Sorting DROPDOWNS

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                        //ProjectName Sort
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child:
                                                                CustomDropdown
                                                                    .search(
                                                              hintText:
                                                                  'Projects',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              items:
                                                                  projectNamesSortList,
                                                              excludeSelected:
                                                                  true,
                                                              controller:
                                                                  projectNameSortInDocuments,
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  getUploadedDocuments()();
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ])),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),

                                                //Document TABLE
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  child:
                                                      customerDocumentList
                                                                  .length ==
                                                              0
                                                          ? Center(
                                                              child: Text(
                                                              'No Documents yet.',
                                                              style: FlutterFlowTheme.bodyText2.override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: Color(
                                                                      0xFF8B97A2),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ))
                                                          : DataTable(
                                                              horizontalMargin:
                                                                  12,
                                                              columns: [
                                                                DataColumn(
                                                                  label: Text(
                                                                    "Date",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "Project Name",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "Document",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "Description",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      " ",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                              ],
                                                              rows:
                                                                  List.generate(
                                                                customerDocumentList
                                                                    .length,
                                                                (index) {
                                                                  var feeDetail =
                                                                      customerDocumentList[
                                                                          index];

                                                                  return DataRow(
                                                                    color: index
                                                                            .isOdd
                                                                        ? MaterialStateProperty.all(Colors
                                                                            .blueGrey
                                                                            .shade50
                                                                            .withOpacity(
                                                                                0.7))
                                                                        : MaterialStateProperty.all(Colors
                                                                            .blueGrey
                                                                            .shade50),
                                                                    cells: [
                                                                      DataCell(SelectableText(
                                                                          dateTimeFormat(
                                                                              'd-MMM-y',
                                                                              feeDetail['dateSubmitted']
                                                                                  .toDate()),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12))),
                                                                      DataCell(SelectableText(
                                                                          projectDataById[feeDetail['projectId']]
                                                                              [
                                                                              'projectName'],
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12))),
                                                                      DataCell(Text(
                                                                          feeDetail[
                                                                              'docName'],
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12))),
                                                                      DataCell(Text(
                                                                          feeDetail[
                                                                              'docDescription'],
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12))),
                                                                      DataCell(
                                                                          Row(
                                                                        children: [
                                                                          FlutterFlowIconButton(
                                                                            borderColor:
                                                                                Colors.transparent,
                                                                            borderRadius:
                                                                                30,
                                                                            borderWidth:
                                                                                1,
                                                                            buttonSize:
                                                                                50,
                                                                            fillColor:
                                                                                Colors.transparent,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.download,
                                                                              color: Colors.teal,
                                                                              size: 25,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              try {
                                                                                await downloadUrl(feeDetail['url'].toString());
                                                                              } catch (e) {
                                                                                print(e);
                                                                              }
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ))
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )

                                      //ADD SERVICES
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                //head
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(30, 5, 30, 20),
                                                  child: Text(
                                                    'Services',
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF8B97A2),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 17),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),

                                                //add SERVICES

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    // height:
                                                    //     MediaQuery.of(context)
                                                    //             .size
                                                    //             .height *
                                                    //         0.25,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        //Add Document Title
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .only(
                                                                      top: 20,
                                                                      bottom:
                                                                          20),
                                                          child: Text(
                                                            'Add Service',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),

                                                        //Add Fields
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                            30,
                                                            10,
                                                            30,
                                                            10,
                                                          ),
                                                          child: Container(
                                                            child: Form(
                                                              key: formKey,
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                      30,
                                                                      10,
                                                                      30,
                                                                      10,
                                                                    ),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          //Date Picker
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width * 0.1,
                                                                              height: 65,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                border: Border.all(
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 10),
                                                                                    child: TextButton(
                                                                                        onPressed: () {
                                                                                          showDatePicker(context: context, initialDate: serviceStartingDate ?? DateTime.now(), firstDate: DateTime(1901, 1), lastDate: DateTime(2100, 1)).then((value) {
                                                                                            setState(() {
                                                                                              if (value != null) {
                                                                                                serviceStartingDate = value;
                                                                                              }
                                                                                            });
                                                                                          });
                                                                                        },
                                                                                        child: Text(
                                                                                          serviceStartingDate == null ? 'Please Choose Starting Date' : dateTimeFormat('d-MMM-y', serviceStartingDate),
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Poppins',
                                                                                            color: Colors.blue,
                                                                                            fontSize: 17,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        )),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.02,
                                                                          ),

                                                                          //Date Picker
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width * 0.1,
                                                                              height: 65,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                border: Border.all(
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 10),
                                                                                    child: TextButton(
                                                                                        onPressed: () {
                                                                                          showDatePicker(context: context, initialDate: serviceStartingDate ?? DateTime.now(), firstDate: DateTime(1901, 1), lastDate: DateTime(2100, 1)).then((value) {
                                                                                            setState(() {
                                                                                              if (value != null) {
                                                                                                serviceEndingDate = value;
                                                                                              }
                                                                                            });
                                                                                          });
                                                                                        },
                                                                                        child: Text(
                                                                                          serviceEndingDate == null ? 'Please Choose Ending Date' : dateTimeFormat('d-MMM-y', serviceEndingDate),
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Poppins',
                                                                                            color: Colors.blue,
                                                                                            fontSize: 17,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        )),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.02,
                                                                          ),

                                                                          // PROJECT PICKER
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width * 0.2,
                                                                              height: 65,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                border: Border.all(
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              child: CustomDropdown.search(
                                                                                hintText: 'Select Project',
                                                                                items: projectNames,
                                                                                controller: projectNameInServices,
                                                                                // excludeSelected: false,
                                                                                onChanged: (text) {
                                                                                  setState(() {
                                                                                    projectNameInDocuments.text = text;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.02,
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                      30,
                                                                      10,
                                                                      30,
                                                                      10,
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        // SERVICE PICKER
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.2,
                                                                            height:
                                                                                65,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              border: Border.all(
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                CustomDropdown.search(
                                                                              hintText: 'Select Service',
                                                                              items: servicesList,
                                                                              controller: serviceName,
                                                                              // excludeSelected: false,
                                                                              onChanged: (text) {
                                                                                setState(() {
                                                                                  serviceName.text = text;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.02,
                                                                        ),

                                                                        //SERVICE Amount
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.19,
                                                                            height:
                                                                                65,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              border: Border.all(
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                                                              child: TextFormField(
                                                                                controller: serviceAmount,
                                                                                obscureText: false,
                                                                                onChanged: (string) {
                                                                                  string = '${_formatNumber(string.replaceAll(',', ''))}';
                                                                                  serviceAmount.value = TextEditingValue(
                                                                                    text: string,
                                                                                    selection: TextSelection.collapsed(offset: string.length),
                                                                                  );
                                                                                  print(string);
                                                                                  String str = string.replaceAll(',', '');
                                                                                  print(str);
                                                                                },
                                                                                decoration: InputDecoration(
                                                                                  prefixText: _currency,
                                                                                  labelText: 'Amount',
                                                                                  labelStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
                                                                                  hintText: 'Please Enter Amount',
                                                                                  hintStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
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
                                                                                style: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Color(0xFF8B97A2), fontWeight: FontWeight.w500, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.02,
                                                                        ),

                                                                        //Description
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.19,
                                                                            height:
                                                                                65,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              border: Border.all(
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                                                              child: TextFormField(
                                                                                controller: serviceDescription,
                                                                                obscureText: false,
                                                                                decoration: InputDecoration(
                                                                                  labelText: 'Description',
                                                                                  labelStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
                                                                                  hintText: 'Please Enter Description',
                                                                                  hintStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
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
                                                                                style: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Color(0xFF8B97A2), fontWeight: FontWeight.w500, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                      30,
                                                                      10,
                                                                      30,
                                                                      10,
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        //ADD BUTTON
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              if (serviceName.text != '' && serviceAmount.text != '' && serviceDescription.text != '' && serviceStartingDate != null && serviceEndingDate != null
                                                                                  // &&
                                                                                  // (urlDownload != '' &&
                                                                                  //     urlDownload != null)
                                                                                  ) {
                                                                                FirebaseFirestore.instance.collection('customerServices').add({
                                                                                  'project': projectIdByName[projectName.text] ?? '',
                                                                                  'branch': currentBranchId,
                                                                                  'serviceName': serviceName.text,
                                                                                  'createdDate': FieldValue.serverTimestamp(),
                                                                                  'serviceStartingDate': serviceStartingDate,
                                                                                  'serviceEndingDate': serviceEndingDate,
                                                                                  'description': serviceDescription.text,
                                                                                  'delete': false,
                                                                                  'serviceAmount': double.tryParse(serviceAmount.text.replaceAll(',', '')),
                                                                                  'customerId': widget.id,
                                                                                  'paymentDetails': [],
                                                                                  'totalPaid': 0,
                                                                                }).then((value) {
                                                                                  value.update({
                                                                                    'serviceId': value.id,
                                                                                  });
                                                                                  showUploadMessage(context, 'services added successfully');
                                                                                });
                                                                              } else {
                                                                                serviceName.text == ''
                                                                                    ? showUploadMessage(context, 'Please Choose Service')
                                                                                    : serviceAmount.text == ''
                                                                                        ? showUploadMessage(context, 'Please Enter Service Amount')
                                                                                        : serviceDescription.text == ''
                                                                                            ? showUploadMessage(context, 'Please Enter Service Description')
                                                                                            : showUploadMessage(context, 'Please Choose Date');
                                                                              }
                                                                            },
                                                                            text:
                                                                                'Add',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 100,
                                                                              height: 40,
                                                                              color: Color(0xff0054FF),
                                                                              textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                fontFamily: 'Lexend Deca',
                                                                                color: Colors.white,
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              elevation: 2,
                                                                              borderSide: BorderSide(
                                                                                color: Colors.transparent,
                                                                                width: 1,
                                                                              ),
                                                                              borderRadius: 50,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
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
                                                ),

                                                SizedBox(
                                                  width: 30,
                                                ),

                                                // //Sorting DROPDOWNS
                                                //
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.all(8.0),
                                                //   child: Container(
                                                //       child: Row(
                                                //           mainAxisAlignment:
                                                //               MainAxisAlignment
                                                //                   .center,
                                                //           children: [
                                                //         //ProjectName Sort
                                                //         Container(
                                                //           width: MediaQuery.of(
                                                //                       context)
                                                //                   .size
                                                //                   .width *
                                                //               0.19,
                                                //           height: 30,
                                                //           decoration:
                                                //               BoxDecoration(
                                                //             color: Colors.white,
                                                //             borderRadius:
                                                //                 BorderRadius
                                                //                     .circular(
                                                //                         8),
                                                //             border: Border.all(
                                                //               color:
                                                //                   Colors.black,
                                                //             ),
                                                //           ),
                                                //           child: Center(
                                                //             child:
                                                //                 CustomDropdown
                                                //                     .search(
                                                //               hintText:
                                                //                   'Projects',
                                                //               hintStyle: TextStyle(
                                                //                   color: Colors
                                                //                       .black),
                                                //               items:
                                                //                   projectNamesSortList,
                                                //               excludeSelected:
                                                //                   true,
                                                //               controller:
                                                //                   projectNameSortInServices,
                                                //               onChanged: (val) {
                                                //                 setState(() {
                                                //                   getUploadedDocuments();
                                                //                 });
                                                //               },
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ])),
                                                // ),
                                                // SizedBox(
                                                //   height: 30,
                                                // ),

                                                //Document TABLE
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  child:
                                                      selectedServicesList
                                                              .isEmpty
                                                          ? Center(
                                                              child: Text(
                                                              'No Services yet.',
                                                              style: FlutterFlowTheme.bodyText2.override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: Color(
                                                                      0xFF8B97A2),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ))
                                                          : DataTable(
                                                              horizontalMargin:
                                                                  12,
                                                              columns: [
                                                                DataColumn(
                                                                  label: Text(
                                                                    "Starting Date",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    "Ending Date",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "Project Name",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "Service Name",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "Description",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "Amount",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                      "",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                              ],
                                                              rows:
                                                                  List.generate(
                                                                selectedServicesList
                                                                    .length,
                                                                (index) {
                                                                  var feeDetail =
                                                                      selectedServicesList[
                                                                          index];

                                                                  return DataRow(
                                                                    color: index
                                                                            .isOdd
                                                                        ? MaterialStateProperty.all(Colors
                                                                            .blueGrey
                                                                            .shade50
                                                                            .withOpacity(
                                                                                0.7))
                                                                        : MaterialStateProperty.all(Colors
                                                                            .blueGrey
                                                                            .shade50),
                                                                    cells: [
                                                                      DataCell(
                                                                        SelectableText(
                                                                            dateTimeFormat('d-MMM-y',
                                                                                feeDetail['serviceStartingDate'].toDate()),
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                                      ),
                                                                      DataCell(
                                                                        SelectableText(
                                                                            dateTimeFormat('d-MMM-y',
                                                                                feeDetail['serviceEndingDate'].toDate()),
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                                      ),
                                                                      DataCell(
                                                                        SelectableText(
                                                                            projectDataById[feeDetail['project']][
                                                                                'projectName'],
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                            feeDetail[
                                                                                'serviceName'],
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                            feeDetail[
                                                                                'description'],
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                            feeDetail['serviceAmount']
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                                      ),
                                                                      DataCell(
                                                                        FlutterFlowIconButton(
                                                                          borderColor:
                                                                              Colors.transparent,
                                                                          borderRadius:
                                                                              30,
                                                                          borderWidth:
                                                                              1,
                                                                          buttonSize:
                                                                              50,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Color(0xFFEE0000),
                                                                            size:
                                                                                25,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            bool
                                                                                pressed =
                                                                                await alert(context, 'Do you want Delete');

                                                                            if (pressed) {
                                                                              FirebaseFirestore.instance.collection('customerServices').doc(feeDetail['serviceId']).update({
                                                                                'delete': true,
                                                                              });

                                                                              showUploadMessage(context, 'Details Deleted...');
                                                                              setState(() {});
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                ],
              ),
            ),
            floatingActionButton: selectedIndex == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 250),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (buildContext) {
                              return CreateProject(
                                id: widget.id,
                              );
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff0054FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Add Project',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ),
                  )
                : null,
          );
        });
  }

  Widget cProjects(var work) {
    projectType.text = work['projectType'];
    projectname.text = work['projectName'];
    topic.text = work['description'];
    projectStatus.text = work['status'].toString();
    projectCost.text =
        _formatNumber(work['projectCost'].toString().replaceAll(',', ''));
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //heading
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                projectsList.length == 1
                    ? SizedBox()
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            subTabView = false;
                          });
                        },
                        icon: Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Center(
                  child: Text(
                    'Project Details',
                    style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 30,
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //PROJECT DETAILS
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6ED),
                                  ),
                                ),
                                child: CustomDropdown.search(
                                  hintText: 'Select Project Type',
                                  items: projectTypeList,
                                  controller: projectType,
                                  // excludeSelected: false,
                                  onChanged: (text) {
                                    setState(() {
                                      work['projectType'] = text;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: projectname,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Project Name',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Project Name',
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6ED),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: topic,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Project Description',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Project Topic',
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: CustomDropdown.search(
                                  hintText: 'Select Project Status',
                                  items: projectStatusList,
                                  controller: projectStatus,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  // excludeSelected: false,
                                  onChanged: (text) {
                                    setState(() {
                                      work['status'] = text;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: projectCost,
                                    obscureText: false,
                                    onChanged: (string) {
                                      string =
                                          '${_formatNumber(string.replaceAll(',', ''))}';
                                      projectCost.value = TextEditingValue(
                                        text: string,
                                        selection: TextSelection.collapsed(
                                            offset: string.length),
                                      );
                                      print(string);
                                      String str = string.replaceAll(',', '');
                                      print(str);
                                    },
                                    decoration: InputDecoration(
                                      prefixText: _currency,
                                      labelText: 'Project Cost',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Project Cost',
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    if (projectType.text != '' &&
                                        projectname.text != '' &&
                                        // topic.text != '' &&
                                        projectCost.text != '') {
                                      projectCost.text =
                                          projectCost.text.replaceAll(',', '');
                                      FirebaseFirestore.instance
                                          .collection('projects')
                                          .doc(work['projectId'])
                                          .update({
                                        'status': projectStatus.text,
                                        'projectType': projectType.text,
                                        'projectName': projectname.text,
                                        'description': topic.text,
                                        'projectCost':
                                            double.tryParse(projectCost.text),
                                      });
                                      setState(() {});

                                      showUploadMessage(context,
                                          'project details addes successfully');
                                    } else {
                                      projectType.text == ''
                                          ? showUploadMessage(context,
                                              'Please Enter Project Type')
                                          : projectname.text == ''
                                              ? showUploadMessage(context,
                                                  'Please Enter Project Name')
                                              : topic.text == ''
                                                  ? showUploadMessage(context,
                                                      'Please Enter Project Description')
                                                  : showUploadMessage(context,
                                                      'Please Enter Project Cost');
                                    }
                                  },
                                  text: 'Update',
                                  options: FFButtonOptions(
                                    width: 80,
                                    height: 40,
                                    color: Color(0xff0054FF),
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    elevation: 2,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 50,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),

                  //DELIVERABLES TABLE
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    //DELIVERABLES
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 5, 30, 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                width: 350,
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
                                                  child: CustomDropdown.search(
                                                    hintText: 'Select domain',
                                                    hintStyle: TextStyle(
                                                        color: Colors.black),
                                                    items: listOfDomain,
                                                    controller: Domain,
                                                    // excludeSelected: false,
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                width: 350,
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
                                                    controller: deliverable,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Deliverables',
                                                      labelStyle: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                      hintText:
                                                          'Please Enter Deliverable',
                                                      hintStyle: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                width: 350,
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
                                                  child: CustomDropdown.search(
                                                    hintText: 'Select Platform',
                                                    hintStyle: TextStyle(
                                                        color: Colors.black),
                                                    items: platforms,
                                                    controller: platform,
                                                    // excludeSelected: false,
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            child: FFButtonWidget(
                                              onPressed: () {
                                                if (Domain.text != '' &&
                                                    deliverable.text != '' &&
                                                    platform.text != '') {
                                                  List abc = [];
                                                  abc.add({
                                                    'domain': Domain.text,
                                                    'deliverable':
                                                        deliverable.text,
                                                    'platform': platform.text,
                                                  });
                                                  print(abc.toString());
                                                  FirebaseFirestore.instance
                                                      .collection('projects')
                                                      .doc(work['projectId'])
                                                      .update({
                                                    'projectDetails':
                                                        FieldValue.arrayUnion(
                                                            abc),
                                                  });
                                                  showUploadMessage(context,
                                                      'Project details added successfully');

                                                  Domain.text = '';
                                                  deliverable.text = '';
                                                  platform.text = '';
                                                } else {
                                                  Domain.text == ''
                                                      ? showUploadMessage(
                                                          context,
                                                          'Please Select Domain')
                                                      : deliverable.text == ''
                                                          ? showUploadMessage(
                                                              context,
                                                              'Please Enter Deliverable')
                                                          : showUploadMessage(
                                                              context,
                                                              'Please Enter Platform');
                                                }
                                              },
                                              text: 'Add',
                                              options: FFButtonOptions(
                                                width: 80,
                                                height: 40,
                                                color: Color(0xff0054FF),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                elevation: 2,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 50,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: work['projectDetails'].length == 0
                                          ? Center(
                                              child: Text(
                                              'No Details Added yet',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                            ))
                                          : DataTable(
                                              horizontalMargin: 12,
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    "Sl No",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text("Domain",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("Deliverables",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("Platform",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                              rows: List.generate(
                                                work['projectDetails'].length,
                                                (index) {
                                                  final data =
                                                      work['projectDetails']
                                                          [index];
                                                  project.add(data);
                                                  return DataRow(
                                                    color: index.isOdd
                                                        ? MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50
                                                                .withOpacity(
                                                                    0.7))
                                                        : MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50),
                                                    cells: [
                                                      DataCell(Text(
                                                          (index + 1)
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12))),
                                                      DataCell(Text(
                                                          data['domain'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12))),
                                                      DataCell(Text(
                                                          data['deliverable'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12))),
                                                      DataCell(Text(
                                                          data['platform'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12))),
                                                      DataCell(
                                                        Row(
                                                          children: [
                                                            FlutterFlowIconButton(
                                                              borderColor: Colors
                                                                  .transparent,
                                                              borderRadius: 30,
                                                              borderWidth: 1,
                                                              buttonSize: 50,
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color: Color(
                                                                    0xFFEE0000),
                                                                size: 25,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                bool pressed =
                                                                    await alert(
                                                                        context,
                                                                        'Do you want Delete');

                                                                if (pressed) {
                                                                  project
                                                                      .removeAt(
                                                                          index);

                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'projects')
                                                                      .doc(work[
                                                                          'projectId'])
                                                                      .update({
                                                                    'projectDetails':
                                                                        project,
                                                                  });

                                                                  showUploadMessage(
                                                                      context,
                                                                      'Details Deleted...');
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.010,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
