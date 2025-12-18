class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String date;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  /// Convert JSON → Dart object
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'].toString(),
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      category: json['category'],
      date: json['date'],
    );
  }

  /// Convert Dart object → JSON (for POST / PUT)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
    };
  }
}
