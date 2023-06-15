import 'package:fl_erp/flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';
import 'PayRoll_Slip/addExcelSheet.dart';
import 'dashbordSingleGridView/grid.dart';

class HrDashBoard extends StatefulWidget {
  final TabController _tabController;
  const HrDashBoard({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<HrDashBoard> createState() => _HrDashBoardState();
}

class _HrDashBoardState extends State<HrDashBoard> {
  List dashboardItems = [
    {
      'name': 'Employee',
      'image': 'assets/HR Dashboard/employee.png',
    },
    {
      'name': 'Attendance',
      'image': 'assets/HR Dashboard/attendance.png',
    },
    {
      'name': 'Leave',
      'image': 'assets/HR Dashboard/leave.png',
    },
    {
      'name': 'Pay Slip',
      'image': 'assets/HR Dashboard/paySlip.png',
    },{
      'name': 'Send Mail',
      'image': 'assets/HR Dashboard/mail.png',
    },
    {
      'name': 'Settings',
      'image': 'assets/HR Dashboard/settings.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: dashboardItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                // childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      // setState(() {
                      widget._tabController.animateTo((6));
                      // });
                    } else if (index == 1) {
                      // setState(() {

                      widget._tabController.animateTo((9));
                      // });
                    } else if (index == 2) {
                      // setState(() {

                      widget._tabController.animateTo((10));
                      // });
                    } else if (index == 3) {
                      // setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAttendance(),
                          ));
                      // widget._tabController.animateTo((21));
                      // });
                    } else if (index == 4) {
                      // setState(() {

                      widget._tabController.animateTo((35));
                      // });
                    }else if (index == 5) {
                      // setState(() {

                      widget._tabController.animateTo((11));
                      // });
                    } else {
                      showUploadMessage(context, 'Coming Soon...');
                    }
                  },
                  child: Container(
                    child: SingleGrid(
                      content: dashboardItems[index],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
