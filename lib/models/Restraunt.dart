class Restraunt{
  final String Num;
  final String amount;

  Restraunt({this.Num, this.amount});

  factory Restraunt.fromJson(Map<String, dynamic> json) {
    return Restraunt(
        Num: json["Num"],
        amount: json["amount"]
    );
  }
}