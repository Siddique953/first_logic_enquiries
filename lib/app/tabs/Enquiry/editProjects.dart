import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/upload_media.dart';

class EnquiryProjectsTable extends StatefulWidget {
  final List projects;
  const EnquiryProjectsTable({Key key, this.projects}) : super(key: key);

  @override
  State<EnquiryProjectsTable> createState() => _EnquiryProjectsTableState();
}

class _EnquiryProjectsTableState extends State<EnquiryProjectsTable> {
  @override
  Widget build(BuildContext context) {
    var projects = widget.projects;
    return AlertDialog(
      title: Center(child: Text('Projects List')),
      content: Container(
        width: 600,
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            horizontalMargin: 12,
            columns: [
              DataColumn(
                label: Text(
                  "Sl No",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              DataColumn(
                label: Text("Project Name",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              DataColumn(
                label: Text("Type",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              DataColumn(
                label: Text("", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
            rows: List.generate(
              projects.length,
              (index) {
                final data = projects[index];

                return DataRow(
                  color: index.isOdd
                      ? MaterialStateProperty.all(
                          Colors.blueGrey.shade50.withOpacity(0.7))
                      : MaterialStateProperty.all(Colors.blueGrey.shade50),
                  cells: [
                    DataCell(Text((index + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))),
                    DataCell(Text(data['projectName'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))),
                    DataCell(Text(data['projectType'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))),
                    DataCell(
                      Row(
                        children: [
                          // Generated code for this Button Widget...
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 50,
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xFFEE0000),
                              size: 25,
                            ),
                            onPressed: () async {
                              bool pressed =
                                  await alert(context, 'Do you want Delete');

                              if (pressed) {
                                projects.removeAt(index);

                                showUploadMessage(
                                    context, 'Project Deleted...');
                                setState(() {});
                              }
                            },
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
        ),
      ),
    );
  }
}
