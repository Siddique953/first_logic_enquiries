import 'package:fl_erp/app/tabs/Branch/SelectBranches.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_erp/app/tabs/Human%20Resources/PayRoll_Slip/addExcelSheet.dart';
import 'package:fl_erp/app/tabs/Human%20Resources/hrHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../Login/login.dart';
import '../auth/firebase_user_provider.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'pages/home_page/home.dart';

User? currentUserModel;
String currentBranchId = '';
String currentbranchName = '';
String currentbranchAddress = '';
String currentbranchShortName = '';
String currentbranchphoneNumber = '';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double currentSize = 0;
  //  LeadzFirebaseUser? initialUser;
  //
  // Stream<LeadzFirebaseUser>? userStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userStream = leadzFirebaseUserStream()
    //   ..listen((user) => initialUser ?? setState(() => initialUser = user));
    //
    // print('"""""""initialUser"""""""');
    // print(initialUser);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('de', 'DE'),
          Locale('en', 'IN'),
          Locale('in', 'IN'),
        ],
        locale: Locale('en'),
        theme: ThemeData(
          backgroundColor: Colors.blueGrey[900],
          brightness: Brightness.light,
          canvasColor: Colors.transparent,
          // primarySwatch: Colors.blueGrey[900],
          fontFamily: "Montserrat",
        ),
        debugShowCheckedModeBanner: false,
        title: 'FIRST LOGIC ERP',
        home:
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {


            if (snapshot.hasData) {
              currentUserUid= snapshot.data!.uid;
            currentUserEmail=snapshot.data!.email??'';
              return const BranchesWidget();
            }
            return const LoginPageWidget();
          },
        ),
            // // AddEmployee()
            // // HrDashBoard()
            // initialUser == null || currentBranchId == null
            //     ? Center(
            //         child: Image.asset('assets/images/loading.gif'),
            //       )
            //     : currentUser!.loggedIn && currentBranchId != null
            //         ? BranchesWidget()
            //         : LoginPageWidget()
        // // home:

        // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Colors.black, //Color(0xFF3c8dbc),
        //     elevation: 0,
        //     title: Text(
        //       ' Dashboard',
        //       style: TextStyle(
        //         fontSize: 15,
        //       ),
        //     ),
        //     actions: [
        //       IconButton(icon: Icon(Icons.person), onPressed: () {}),
        //       IconButton(icon: Icon(Icons.lock), onPressed: () {}),
        //       IconButton(icon: Icon(Icons.mail_outline), onPressed: () {})
        //     ],
        //   ),
        //   drawerEdgeDragWidth: 200,
        //   body: Home(),
        // ),
        );
  }
}
