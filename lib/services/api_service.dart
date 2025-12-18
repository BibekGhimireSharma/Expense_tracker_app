import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense_model.dart';
import '../utils/constants.dart';

class ApiService {
  // GET
  static Future<List<Expense>> fetchExpenses() async {
    final response =
    await http.get(Uri.parse(AppConstants.expensesUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Expense.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load expenses");
    }
  }

  // POST
  static Future<void> addExpense(Expense expense) async {
    final response = await http.post(
      Uri.parse(AppConstants.expensesUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(expense.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add expense");
    }
  }
  // PUT (update)
  static Future<void> updateExpense(Expense expense) async {
    final response = await http.put(
      Uri.parse("${AppConstants.expensesUrl}/${expense.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(expense.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update expense");
    }
  }

  // DELETE
  static Future<void> deleteExpense(String id) async {
    final response = await http.delete(
      Uri.parse("${AppConstants.expensesUrl}/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete expense");
    }
  }


}
