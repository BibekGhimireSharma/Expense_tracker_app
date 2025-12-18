import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/api_service.dart';
import 'add_expense_screen.dart';
import 'edit_expense_screen.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  late Future<List<Expense>> _expensesFuture;

  bool selectionMode = false;
  final Set<String> selectedIds = {};

  @override
  void initState() {
    super.initState();
    _expensesFuture = ApiService.fetchExpenses();
  }

  void _reloadExpenses() {
    setState(() {
      selectionMode = false;
      selectedIds.clear();
      _expensesFuture = ApiService.fetchExpenses();
    });
  }

  Future<void> _deleteSelected() async {
    for (final id in selectedIds) {
      await ApiService.deleteExpense(id);
    }
    _reloadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          selectionMode
              ? "${selectedIds.length} selected"
              : "Expense Tracker",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: selectionMode
            ? IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              selectionMode = false;
              selectedIds.clear();
            });
          },
        )
            : null,
        actions: selectionMode
            ? [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: selectedIds.isEmpty
                ? null
                : () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Delete expenses"),
                  content: Text(
                      "Delete ${selectedIds.length} selected expenses?"),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, true),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await _deleteSelected();
              }
            },
          )
        ]
            : [],
      ),

      floatingActionButton: selectionMode
          ? null
          : FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddExpenseScreen(),
            ),
          );

          if (result == true) {
            _reloadExpenses();
          }
        },
      ),

      body: FutureBuilder<List<Expense>>(
        future: _expensesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final expenses = snapshot.data!;

          if (expenses.isEmpty) {
            return const Center(child: Text("No expenses yet"));
          }

          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final e = expenses[index];
              final isSelected = selectedIds.contains(e.id);

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  if (selectionMode) {
                    setState(() {
                      isSelected
                          ? selectedIds.remove(e.id)
                          : selectedIds.add(e.id);
                    });
                  } else {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditExpenseScreen(expense: e),
                      ),
                    );

                    if (result == true) {
                      _reloadExpenses();
                    }
                  }
                },
                onLongPress: () {
                  setState(() {
                    selectionMode = true;
                    selectedIds.add(e.id);
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.indigo.withOpacity(0.15)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // CATEGORY COLOR BAR
                      Container(
                        width: 6,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _categoryColor(e.category),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // TITLE + CATEGORY
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              e.category,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // AMOUNT + DATE
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹${e.amount}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            e.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),

                      if (selectionMode)
                        Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              value == true
                                  ? selectedIds.add(e.id)
                                  : selectedIds.remove(e.id);
                            });
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // CATEGORY → COLOR MAPPING
  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Colors.orange;
      case "travel":
        return Colors.blue;
      case "shopping":
        return Colors.pink;
      case "health":
        return Colors.red;
      case "education":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
