import 'package:flutter/material.dart';
import 'Employee.dart';
import 'employee_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _employeeBloc = EmployeeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee App'),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.empListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Text(
                        "${snapshot.data!.elementAt(index).id}.",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.elementAt(index).name,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              "${snapshot.data!.elementAt(index).salary}.",
                              style: const TextStyle(fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: const Icon(
                            Icons.thumb_up,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _employeeBloc.empSalaryIncSink
                                .add(snapshot.data!.elementAt(index));
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.thumb_down,
                            color: Colors.red[300],
                          ),
                          onPressed: () {
                            _employeeBloc.empSalaryDecSink
                                .add(snapshot.data![index]);
                          },
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                );
              },
              itemCount: snapshot.data?.length,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _employeeBloc.dispose();
  }
}
