import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/api_service.dart';

class EditExpenseScreen extends StatefulWidget {
  final Expense expense;

  const EditExpenseScreen({super.key, required this.expense});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  late TextEditingController _dateController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.expense.title);
    _amountController =
        TextEditingController(text: widget.expense.amount.toString());
    _categoryController =
        TextEditingController(text: widget.expense.category);
    _dateController =
        TextEditingController(text: widget.expense.date);
  }

  Future<void> _updateExpense() async {
    final updatedExpense = Expense(
      id: widget.expense.id,
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      category: _categoryController.text,
      date: _dateController.text,
    );

    setState(() => _isLoading = true);

    await ApiService.updateExpense(updatedExpense);

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: "Date"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _updateExpense,
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
