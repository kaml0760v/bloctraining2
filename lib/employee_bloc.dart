import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  final List<Employee> _employee = [
    Employee(1, "Employee One", 10000),
    Employee(2, "Employee Two", 20000),
    Employee(3, "Employee Three", 30000),
    Employee(4, "Employee Four", 40000),
    Employee(5, "Employee Five", 50000),
  ];

  final _empStreamController = StreamController<List<Employee>>();
  final _empSalaryIncStreamController = StreamController<Employee>();
  final _empSalaryDecStreamController = StreamController<Employee>();

  Stream<List<Employee>> get empListStream => _empStreamController.stream;

  StreamSink<List<Employee>> get emplistSink => _empStreamController.sink;
  StreamSink<Employee> get empSalaryDecSink =>
      _empSalaryDecStreamController.sink;
  StreamSink<Employee> get empSalaryIncSink =>
      _empSalaryIncStreamController.sink;

  EmployeeBloc() {
    _empStreamController.add(_employee);
    _empSalaryIncStreamController.stream.listen(_incrementSalary);
    _empSalaryDecStreamController.stream.listen(_decrementSalary);
  }

  void _incrementSalary(Employee e) {
    double salary = e.salary;
    double incrementedSalary = salary * 20 / 100;
    _employee[e.id - 1].salary = salary + incrementedSalary;

    emplistSink.add(_employee);
  }

  void _decrementSalary(Employee e) {
    double salary = e.salary;
    double decrementedSalary = salary * 10 / 100;
    _employee[e.id - 1].salary = salary - decrementedSalary;
    emplistSink.add(_employee);
  }

  void dispose() {
    _empSalaryIncStreamController.close();
    _empSalaryDecStreamController.close();
    _empStreamController.close();
  }
}
