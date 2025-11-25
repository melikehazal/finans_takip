class ExpenseModel {
  int id;
  double amount; //harcama tutarı
  String categoryId;
  String? description;
  DateTime date;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.categoryId,
    this.description,
    required this.date,
  });
}
