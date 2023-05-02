class PaySlipModel {
  String name;
  String code;
  String designation;
  String pan;
  String accNumber;
  String bankName;
  int workingDays;
  int attended;
  String leaves;
  int leavesTaken;
  int balanceLeaves;
  String basicPay;
  String dearnessAllo;
  String hra;
  String spAllowance;
  String cityAllow;
  String incentives;
  String medicalAlowance;
  String advance;
  String total;
  String month;
  String netSalary;
  String totalDeduction;

  PaySlipModel(
      {this.name,
      this.code,
      this.designation,
      this.pan,
      this.accNumber,
      this.bankName,
      this.workingDays,
      this.attended,
      this.leaves,
      this.leavesTaken,
      this.balanceLeaves,
      this.basicPay,
      this.dearnessAllo,
      this.hra,
      this.spAllowance,
      this.cityAllow,
      this.incentives,
      this.medicalAlowance,
      this.advance,
      this.month,
      this.totalDeduction,
      this.netSalary,
      this.total});
}
