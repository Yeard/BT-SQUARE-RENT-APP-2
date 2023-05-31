class SubTransRenter {
  int rentetId;
  int iD;
  DateTime date;
  double amount;
  String note;
  String type;
  SubTransRenter(
      {required this.rentetId,
      required this.iD,
      required this.date,
      required this.amount,
      required this.note,
      required this.type});
  factory SubTransRenter.fromJson(Map<String, dynamic> json) {
    return SubTransRenter(
      rentetId: int.parse(json['renters_id'] as String),
      iD: int.parse(json['id'] as String),
      date: DateTime.parse(json['date'] as String),
      amount: double.parse(json['amount'] as String),
      note: json['note'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'rentetId': rentetId,
        'id': iD,
        'date': date.toIso8601String(),
        'amount': amount,
        'note': note,
        'type': type,
      };
}
