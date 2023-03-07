import 'package:flutter/material.dart';

class HrLeavePage extends StatefulWidget {
  final TabController _tabController;
  const HrLeavePage({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<HrLeavePage> createState() => _HrLeavePageState();
}

class _HrLeavePageState extends State<HrLeavePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
