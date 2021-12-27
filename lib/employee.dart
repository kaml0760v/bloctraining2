class Employee {
  int _id;
  String _name;
  double _salary;
  Employee(
    this._id,
    this._name,
    this._salary,
  );

  set id(int id) => _id = id;
  set name(String name) => _name = name;
  set salary(double salary) => _salary = salary;

  int get id => _id;
  String get name => _name;
  double get salary => _salary;
}
