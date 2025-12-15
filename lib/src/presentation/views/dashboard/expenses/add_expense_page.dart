import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/storage/database/mapper/category_icon_mapper.dart';
import 'package:money_scope/src/domain/entities/category_entity.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';
import 'package:money_scope/src/presentation/providers/category_provider/category_provider.dart';
import 'package:money_scope/src/presentation/providers/expenses_provider/expenses_provider.dart';
import 'package:money_scope/src/presentation/views/dashboard/expenses/widgets/confirm_expense_dialog.dart';
import 'package:money_scope/src/presentation/views/dashboard/expenses/widgets/date_tile.dart';
import 'package:uuid/uuid.dart';

class AddExpensePage extends ConsumerStatefulWidget {
  const AddExpensePage({super.key});

  @override
  ConsumerState<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<AddExpensePage> {
  final _amountTextEditingController = TextEditingController();
  final _notesTextEditingController = TextEditingController();

  CategoryEntity? _selectedCategory;
  DateTime? _selectedDate;

  void _onCategoryTap(CategoryEntity category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _addExpense() {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    if (_amountTextEditingController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter an amount')));
      return;
    }

    final expense = ExpenseEntity(
      id: const Uuid().v4(),
      amount: double.parse(_amountTextEditingController.text),
      categoryId: _selectedCategory!.id,
      note: _notesTextEditingController.text,
      date: _selectedDate!,
      name: _selectedCategory!.name,
    );

    showConfirmExpenseDialog(
      context,
      amount: expense.amount,
      category: _selectedCategory!.name,
      notes: expense.note ?? '',
      onConfirm: () {
        if (_selectedDate != null) {
          ref.read(expenseProvider.notifier).addExpense(expense);
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryAsyncProvider = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: categoryAsyncProvider.when(
        data: (data) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: _amountTextEditingController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.currency_rupee),
                      counter: const Offstage(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 9,
                  ),
                  child: Text(
                    "Categories",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 380,
                  child: GridView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      bool isSelectedCategory =
                          _selectedCategory?.id == data[index].id;

                      return GestureDetector(
                        onTap: () => _onCategoryTap(data[index]),
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  color: Color(data[index].color),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(
                                      CategoryIconMapper.get(data[index].icon),
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (isSelectedCategory)
                                  const Positioned(
                                    right: 1,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.green,
                                      child: Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              data[index].name,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 9,
                  ),
                  child: DateTile(
                    onDateSelected: (date) {
                      _selectedDate = date;
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _notesTextEditingController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Add a note (optional)',
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _addExpense,
                      child: const Text('Save Expense'),
                    ),
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.all(10)),
            ],
          );
        },
        error: (error, stacktrace) =>
            const Center(child: Text("Something went wrong")),
        loading: () => const SizedBox.shrink(),
      ),
    );
  }
}
