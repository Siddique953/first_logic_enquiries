import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_erp/auth/auth_util.dart';

import '../../../../Login/login.dart';
import '../../../components/colapseItem.dart';
import '../home.dart';
import 'user_profile.dart';

class SideMenu extends StatefulWidget {
  final TabController _tabController;
  const SideMenu({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

int selectedTab = 0;
int subTab = 0;

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff231F20),
      width: 240,
      child: Theme(
        data: ThemeData(
          highlightColor: Color(0xff231F20),
        ),
        child: Scrollbar(
          child: ListView(
            children: [
              SizedBox(height: 10),
              UserProfile(),
              currentUserRole == 'Super Admin' ||
                      currentUserRole == 'Branch Admin'
                  ? Column(
                      children: [
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //dashboard
                        Container(
                          height: 30,

                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: selectedTab == 0
                                ? Border(
                                    left: BorderSide(
                                      color: Color(0xff0054FF),
                                      width: 3,
                                    ),
                                  )
                                : null,
                          ),
                          // color: Color(0xFF1a2226),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget._tabController.animateTo((0));
                                selectedTab = 0;
                                subTab = 0;
                              });
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Dashboard",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //0,0

                        //ENQUIRY
                        ExpandablePanel(
                          theme: ExpandableThemeData(
                            iconColor: Colors.white,
                            iconSize: 14,
                          ),
                          header: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              border: selectedTab == 1
                                  ? Border(
                                      left: BorderSide(
                                        color: Color(0xff0054FF),
                                        width: 3,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.category,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Enquiry",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget._tabController.animateTo((1));
                                      selectedTab = 1;
                                      subTab = 1;
                                    });
                                  },
                                  child: ColaspeItem(
                                    label: "Add Enquiry",
                                    icon: Icons.stop_rounded,
                                    style: TextStyle(
                                        color: subTab == 1
                                            ? Color(0xff0054FF)
                                            : Colors.grey,
                                        fontWeight: subTab == 1
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget._tabController.animateTo((2));
                                        selectedTab = 1;
                                        subTab = 2;
                                      });
                                    },
                                    child: ColaspeItem(
                                      label: "Enquiry List",
                                      icon: Icons.stop_rounded,
                                      style: TextStyle(
                                          color: subTab == 2
                                              ? Color(0xff0054FF)
                                              : Colors.grey,
                                          fontWeight: subTab == 2
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    )),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget._tabController.animateTo((3));
                                        selectedTab = 1;
                                        subTab = 3;
                                      });
                                    },
                                    child: ColaspeItem(
                                      label: "FollowUp",
                                      icon: Icons.stop_rounded,
                                      style: TextStyle(
                                          color: subTab == 3
                                              ? Color(0xff0054FF)
                                              : Colors.grey,
                                          fontWeight: subTab == 3
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //1,3
                        //Customer
                        ExpandablePanel(
                          theme: ExpandableThemeData(
                            iconColor: Colors.white,
                            iconSize: 14,
                          ),
                          header: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              border: selectedTab == 2
                                  ? Border(
                                      left: BorderSide(
                                        color: Color(0xff0054FF),
                                        width: 3,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.group,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Customer",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget._tabController.animateTo((4));
                                        selectedTab = 2;
                                        subTab = 4;
                                      });
                                    },
                                    child: ColaspeItem(
                                      label: "Customer List",
                                      icon: Icons.stop_rounded,
                                      style: TextStyle(
                                          color: subTab == 4
                                              ? Color(0xff0054FF)
                                              : Colors.grey,
                                          fontWeight: subTab == 4
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    )),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget._tabController.animateTo((30));
                                        selectedTab = 2;
                                        subTab = 30;
                                      });
                                    },
                                    child: ColaspeItem(
                                      label: "Project List",
                                      icon: Icons.stop_rounded,
                                      style: TextStyle(
                                          color: subTab == 30
                                              ? Color(0xff0054FF)
                                              : Colors.grey,
                                          fontWeight: subTab == 30
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //2,4
                        //HR
                        Container(
                          height: 30,

                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: selectedTab == 3
                                ? Border(
                                    left: BorderSide(
                                      color: Color(0xff0054FF),
                                      width: 3,
                                    ),
                                  )
                                : null,
                          ),
                          // color: Color(0xFF1a2226),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget._tabController.animateTo((5));
                                selectedTab = 3;
                                subTab = 0;
                              });
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.manage_accounts,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Human Resources",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //3,4
                        //ACCOUNTS
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget._tabController.animateTo((0));
                            });
                          },
                          child: ExpandablePanel(
                              theme: ExpandableThemeData(
                                iconColor: Colors.white,
                                iconSize: 14,
                              ),
                              header: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  border: selectedTab == 4
                                      ? Border(
                                          left: BorderSide(
                                            color: Color(0xff0054FF),
                                            width: 3,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.account_balance_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "Accounts",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              expanded: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((12));
                                            selectedTab = 4;
                                            subTab = 5;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Add Expense",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 5
                                                  ? Color(0xff0054FF)
                                                  : Colors.grey,
                                              fontWeight: subTab == 5
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),

                                    //4,5
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((13));
                                            selectedTab = 4;
                                            subTab = 6;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Deposit / Withdrawal",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 6
                                                  ? Color(0xff0054FF)
                                                  : Colors.grey,
                                              fontWeight: subTab == 6
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),
                                  ],
                                ),
                              )),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        // 4,6
                        // AGENT
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget._tabController.animateTo((0));
                            });
                          },
                          child: ExpandablePanel(
                              theme: ExpandableThemeData(
                                iconColor: Colors.white,
                                iconSize: 14,
                              ),
                              header: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  border: selectedTab == 5
                                      ? Border(
                                          left: BorderSide(
                                            color: Color(0xff0054FF),
                                            width: 3,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.support_agent_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "Agents",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              expanded: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((14));
                                          selectedTab = 5;
                                          subTab = 7;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Create Agent",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 7
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 7
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((15));
                                          selectedTab = 5;
                                          subTab = 8;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Agent List",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 8
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 8
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //5,9
                        //REPORT
                        InkWell(
                          onTap: () {},
                          child: ExpandablePanel(
                            theme: ExpandableThemeData(
                              iconColor: Colors.white,
                              iconSize: 14,
                            ),
                            header: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: selectedTab == 6
                                    ? Border(
                                        left: BorderSide(
                                          color: Color(0xff0054FF),
                                          width: 3,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.inbox,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "Reports",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            expanded: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((17));
                                          selectedTab = 6;
                                          subTab = 10;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Customer Statement",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 10
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 10
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((19));
                                          selectedTab = 6;
                                          subTab = 11;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Project Payment Report",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 11
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 11
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((20));
                                          selectedTab = 6;
                                          subTab = 12;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Project Report",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 12
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 12
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((21));
                                          selectedTab = 6;
                                          subTab = 13;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Receipt Report",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 12
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 12
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((22));
                                          selectedTab = 6;
                                          subTab = 14;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Expense Report",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 14
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 14
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((23));
                                          selectedTab = 6;
                                          subTab = 15;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Contra Entry Report",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 15
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 15
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget._tabController.animateTo((24));
                                          selectedTab = 6;
                                          subTab = 16;
                                        });
                                      },
                                      child: ColaspeItem(
                                        label: "Income & Expenditure",
                                        icon: Icons.stop_rounded,
                                        style: TextStyle(
                                            color: subTab == 16
                                                ? Color(0xff0054FF)
                                                : Colors.grey,
                                            fontWeight: subTab == 16
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //6,16
                        //LEADZ
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget._tabController.animateTo((0));
                            });
                          },
                          child: ExpandablePanel(
                              theme: ExpandableThemeData(
                                iconColor: Colors.white,
                                iconSize: 14,
                              ),
                              header: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  border: selectedTab == 7
                                      ? Border(
                                          left: BorderSide(
                                            color: Color(0xff0087cd),
                                            width: 3,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.person_pin_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "Leadz",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              expanded: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((32));
                                            selectedTab = 7;
                                            subTab = 17;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Add Leadz",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 17
                                                  ? Colors.blue.shade300
                                                  : Colors.grey,
                                              fontWeight: subTab == 17
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((31));
                                            selectedTab = 7;
                                            subTab = 18;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Lead List",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 18
                                                  ? Colors.blue.shade300
                                                  : Colors.grey,
                                              fontWeight: subTab == 18
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),
                                  ],
                                ),
                              )),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //7,18
                        //Settings
                        InkWell(
                          onTap: () {},
                          child: ExpandablePanel(
                              theme: ExpandableThemeData(
                                iconColor: Colors.white,
                                iconSize: 14,
                              ),
                              header: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  border: selectedTab == 8
                                      ? Border(
                                          left: BorderSide(
                                            color: Color(0xff0054FF),
                                            width: 3,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "Settings",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              expanded: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((25));
                                            selectedTab = 8;
                                            subTab = 19;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Add Project Type",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 19
                                                  ? Color(0xff0054FF)
                                                  : Colors.grey,
                                              fontWeight: subTab == 19
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((26));
                                            selectedTab = 8;
                                            subTab = 20;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Add Services",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 20
                                                  ? Color(0xff0054FF)
                                                  : Colors.grey,
                                              fontWeight: subTab == 20
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((27));
                                            selectedTab = 8;
                                            subTab = 21;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Add User",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 21
                                                  ? Color(0xff0054FF)
                                                  : Colors.grey,
                                              fontWeight: subTab == 21
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),
                                    currentUserRole == 'Super Admin'
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((28));
                                                selectedTab = 8;
                                                subTab = 22;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "Add Branch",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 22
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 22
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            ))
                                        : Container(),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget._tabController
                                                .animateTo((29));
                                            selectedTab = 8;
                                            subTab = 23;
                                          });
                                        },
                                        child: ColaspeItem(
                                          label: "Add Expense Head",
                                          icon: Icons.stop_rounded,
                                          style: TextStyle(
                                              color: subTab == 23
                                                  ? Color(0xff0054FF)
                                                  : Colors.grey,
                                              fontWeight: subTab == 23
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )),
                                  ],
                                ),
                              )),
                        ),
                        Divider(
                          color: Colors.blueGrey.shade800,
                        ),

                        //LogOut

                        InkWell(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Logout !'),
                                  content: Text('Do you Want to Logout ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        subTab = 0;
                                        selectedTab = 0;
                                        Navigator.pop(alertDialogContext);
                                        await signOut();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPageWidget()),
                                            (route) => false);
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CustomSideMenuItem(
                            title: 'Logout',
                            icon: Icons.logout,
                          ),
                        )
                      ],
                    )
                  : currentUserRole == 'Accountant'
                      ? Column(
                          children: [
                            Divider(
                              color: Colors.blueGrey.shade800,
                            ),

                            //dashboard
                            Container(
                              height: 30,

                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: selectedTab == 0
                                    ? Border(
                                        left: BorderSide(
                                          color: Color(0xff0054FF),
                                          width: 3,
                                        ),
                                      )
                                    : null,
                              ),
                              // color: Color(0xFF1a2226),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    widget._tabController.animateTo((0));
                                    selectedTab = 0;
                                    subTab = 0;
                                  });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.dashboard,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "Dashboard",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade800,
                            ),

                            //0,0

                            //ACCOUNTS
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget._tabController.animateTo((0));
                                });
                              },
                              child: ExpandablePanel(
                                  theme: ExpandableThemeData(
                                    iconColor: Colors.white,
                                    iconSize: 14,
                                  ),
                                  header: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: selectedTab == 1
                                          ? Border(
                                              left: BorderSide(
                                                color: Color(0xff0054FF),
                                                width: 3,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.account_balance_outlined,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "Accounts",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  expanded: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((12));
                                              selectedTab = 1;
                                              subTab = 1;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Add Expense",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 1
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 1
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          ),
                                        ),

                                        //1,1
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((13));
                                                selectedTab = 1;
                                                subTab = 2;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "Deposit / Withdrawal",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 6
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 6
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            )),
                                      ],
                                    ),
                                  )),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade800,
                            ),

                            // 1,2
                            //REPORT
                            InkWell(
                              onTap: () {},
                              child: ExpandablePanel(
                                theme: ExpandableThemeData(
                                  iconColor: Colors.white,
                                  iconSize: 14,
                                ),
                                header: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: selectedTab == 2
                                        ? Border(
                                            left: BorderSide(
                                              color: Color(0xff0054FF),
                                              width: 3,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.inbox,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "Reports",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                expanded: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((17));
                                              selectedTab = 2;
                                              subTab = 3;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Customer Statement",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 3
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 3
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((19));
                                              selectedTab = 2;
                                              subTab = 4;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Project Payment Report",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 4
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 4
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((20));
                                              selectedTab = 2;
                                              subTab = 5;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Project Report",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 5
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 5
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((21));
                                              selectedTab = 2;
                                              subTab = 6;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Receipt Report",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 6
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 6
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((22));
                                              selectedTab = 2;
                                              subTab = 7;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Expense Report",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 7
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 7
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((23));
                                              selectedTab = 2;
                                              subTab = 8;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Contra Entry Report",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 8
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 8
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((24));
                                              selectedTab = 2;
                                              subTab = 9;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Income & Expenditure",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 9
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 9
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade800,
                            ),

                            //2,9
                            //Settings
                            InkWell(
                              onTap: () {},
                              child: ExpandablePanel(
                                  theme: ExpandableThemeData(
                                    iconColor: Colors.white,
                                    iconSize: 14,
                                  ),
                                  header: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: selectedTab == 3
                                          ? Border(
                                              left: BorderSide(
                                                color: Color(0xff0054FF),
                                                width: 3,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "Settings",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  expanded: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((26));
                                                selectedTab = 3;
                                                subTab = 10;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "Add Services",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 10
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 10
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((29));
                                                selectedTab = 3;
                                                subTab = 11;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "Add Expense Head",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 11
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 11
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            )),
                                      ],
                                    ),
                                  )),
                            ),
                            Divider(
                              color: Colors.blueGrey.shade800,
                            ),

                            //LogOut

                            InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Logout !'),
                                      content: Text('Do you Want to Logout ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            subTab = 0;
                                            selectedTab = 0;
                                            Navigator.pop(alertDialogContext);
                                            await signOut();
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPageWidget()),
                                                (route) => false);
                                          },
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: CustomSideMenuItem(
                                title: 'Logout',
                                icon: Icons.logout,
                              ),
                            )
                          ],
                        )
                      : currentUserRole == 'HR'
                          ? Column(
                              children: [
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                //dashboard
                                Container(
                                  height: 30,

                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: selectedTab == 0
                                        ? Border(
                                            left: BorderSide(
                                              color: Color(0xff0054FF),
                                              width: 3,
                                            ),
                                          )
                                        : null,
                                  ),
                                  // color: Color(0xFF1a2226),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget._tabController.animateTo((0));
                                        selectedTab = 0;
                                        subTab = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.dashboard,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "Dashboard",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                //2,4
                                //HR
                                Container(
                                  height: 30,

                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: selectedTab == 3
                                        ? Border(
                                            left: BorderSide(
                                              color: Color(0xff0054FF),
                                              width: 3,
                                            ),
                                          )
                                        : null,
                                  ),
                                  // color: Color(0xFF1a2226),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget._tabController.animateTo((5));
                                        selectedTab = 3;
                                        subTab = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.manage_accounts,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "Human Resources",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                //LogOut

                                InkWell(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Logout !'),
                                          content:
                                              Text('Do you Want to Logout ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                subTab = 0;
                                                selectedTab = 0;
                                                Navigator.pop(
                                                    alertDialogContext);
                                                await signOut();
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPageWidget()),
                                                    (route) => false);
                                              },
                                              child: Text('Confirm'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: CustomSideMenuItem(
                                    title: 'Logout',
                                    icon: Icons.logout,
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                //dashboard
                                Container(
                                  height: 30,

                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: selectedTab == 0
                                        ? Border(
                                            left: BorderSide(
                                              color: Color(0xff0054FF),
                                              width: 3,
                                            ),
                                          )
                                        : null,
                                  ),
                                  // color: Color(0xFF1a2226),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget._tabController.animateTo((0));
                                        selectedTab = 0;
                                        subTab = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.dashboard,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "Dashboard",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                //0,0
                                //ENQUIRY
                                ExpandablePanel(
                                  theme: ExpandableThemeData(
                                    iconColor: Colors.white,
                                    iconSize: 14,
                                  ),
                                  header: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: selectedTab == 1
                                          ? Border(
                                              left: BorderSide(
                                                color: Color(0xff0054FF),
                                                width: 3,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.category,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "Enquiry",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  expanded: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget._tabController
                                                  .animateTo((1));
                                              selectedTab = 1;
                                              subTab = 1;
                                            });
                                          },
                                          child: ColaspeItem(
                                            label: "Add Enquiry",
                                            icon: Icons.stop_rounded,
                                            style: TextStyle(
                                                color: subTab == 1
                                                    ? Color(0xff0054FF)
                                                    : Colors.grey,
                                                fontWeight: subTab == 1
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((2));
                                                selectedTab = 1;
                                                subTab = 2;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "Enquiry List",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 2
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 2
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((3));
                                                selectedTab = 1;
                                                subTab = 3;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "FollowUp",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 3
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 3
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                //1,3
                                //Customer
                                ExpandablePanel(
                                  theme: ExpandableThemeData(
                                    iconColor: Colors.white,
                                    iconSize: 14,
                                  ),
                                  header: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: selectedTab == 2
                                          ? Border(
                                              left: BorderSide(
                                                color: Color(0xff0054FF),
                                                width: 3,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.group,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "Customer",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  expanded: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((4));
                                                selectedTab = 2;
                                                subTab = 4;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "Customer List",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 4
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 4
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget._tabController
                                                    .animateTo((30));
                                                selectedTab = 2;
                                                subTab = 30;
                                              });
                                            },
                                            child: ColaspeItem(
                                              label: "Project List",
                                              icon: Icons.stop_rounded,
                                              style: TextStyle(
                                                  color: subTab == 30
                                                      ? Color(0xff0054FF)
                                                      : Colors.grey,
                                                  fontWeight: subTab == 30
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                // 4,6
                                // AGENT
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget._tabController.animateTo((0));
                                    });
                                  },
                                  child: ExpandablePanel(
                                      theme: ExpandableThemeData(
                                        iconColor: Colors.white,
                                        iconSize: 14,
                                      ),
                                      header: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: selectedTab == 5
                                              ? Border(
                                                  left: BorderSide(
                                                    color: Color(0xff0054FF),
                                                    width: 3,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.support_agent_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              "Agents",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      expanded: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget._tabController
                                                      .animateTo((14));
                                                  selectedTab = 5;
                                                  subTab = 7;
                                                });
                                              },
                                              child: ColaspeItem(
                                                label: "Create Agent",
                                                icon: Icons.stop_rounded,
                                                style: TextStyle(
                                                    color: subTab == 7
                                                        ? Color(0xff0054FF)
                                                        : Colors.grey,
                                                    fontWeight: subTab == 7
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Divider(
                                  color: Colors.blueGrey.shade800,
                                ),

                                //LogOut

                                InkWell(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Logout !'),
                                          content:
                                              Text('Do you Want to Logout ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                subTab = 0;
                                                selectedTab = 0;
                                                Navigator.pop(
                                                    alertDialogContext);
                                                await signOut();
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPageWidget()),
                                                    (route) => false);
                                              },
                                              child: Text('Confirm'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: CustomSideMenuItem(
                                    title: 'Logout',
                                    icon: Icons.logout,
                                  ),
                                )
                              ],
                            ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSideMenuItem extends StatelessWidget {
  const CustomSideMenuItem({
    Key key,
    this.icon,
    this.iconSize = 18,
    this.iconColor = Colors.white,
    this.title,
    this.titleStyle,
    this.onTap,
    this.backColor,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color backColor;
  final String title;
  final TextStyle titleStyle;

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        color: backColor,
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: titleStyle ??
                  TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
