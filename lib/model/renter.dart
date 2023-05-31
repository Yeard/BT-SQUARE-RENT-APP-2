class Renter {
  String name;
  String number;
  DateTime date;
  double amount;
  String note;
  int id;

  Renter(
      {required this.name,
      required this.number,
      required this.date,
      required this.amount,
      required this.note,
      required this.id});

  factory Renter.fromJson(Map<String, dynamic> json) {
    return Renter(
      name: json['name'] as String,
      number: json['number'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: double.parse(json['amount'] as String),
      note: json['note'] as String,
      id: int.parse(json['id'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'number': number,
        'date': date.toIso8601String(),
        'amount': amount,
        'note': note,
        'id': id,
      };
}
