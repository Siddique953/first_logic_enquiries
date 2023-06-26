class FollowUpModel {
  String? dId;
  String? followUpDetail;
  String? eId;
  DateTime? date;
  DateTime? next;
  String? branchId;
  String? assignee;
  bool? done;
  String? email;
  String? name;
  String? workName;
  String? phone;

  FollowUpModel(
      {this.dId,
      this.followUpDetail,
      this.eId,
      this.date,
      this.next,
      this.branchId,
      this.assignee,
      this.done,
      this.email,
      this.name,
      this.workName,
      this.phone});

  FollowUpModel.fromJson(Map<String, dynamic> json) {
    dId = json['dId'];
    followUpDetail = json['followUpDetail'];
    eId = json['eId'];
    date = json['date'];
    next = json['next'];
    branchId = json['branchId'];
    assignee = json['assignee'];
    done = json['done'];
    email = json['email'];
    name = json['name'];
    workName = json['workName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dId'] = this.dId ?? '';
    data['followUpDetail'] = this.followUpDetail ?? '';
    data['eId'] = this.eId ?? '';
    data['date'] = this.date ?? DateTime.now();
    data['next'] = this.next ?? DateTime.now();
    data['branchId'] = this.branchId ?? '';
    data['assignee'] = this.assignee ?? '';
    data['done'] = this.done ?? '';
    data['email'] = this.email ?? '';
    data['name'] = this.name ?? '';
    data['workName'] = this.workName ?? '';
    data['phone'] = this.phone ?? '';
    return data;
  }
}
