class BudgetModel {
  double amount; //aylık belirlenen bütçe
  int month; //ayı benzersiz temsil etmek için ayrı yazdık
  int year;
  double spent; //O ay harcanan toplam(provider hesaplayacak)

  BudgetModel({
    required this.amount,
    required this.month,
    required this.year,
    required this.spent,
  });
}
