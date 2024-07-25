import 'package:get/get.dart';
import '../Models/income_model.dart';
import 'package:hive/hive.dart';

class IncomeController extends GetxController {
  var incomeList = <IncomeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchIncomeData();
  }

  Future<void> fetchIncomeData() async {
    var box = await Hive.openBox<IncomeModel>('incomes');
    incomeList.value = box.values.toList();
  }
}
