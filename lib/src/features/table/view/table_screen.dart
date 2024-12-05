import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/table_controller.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final TableController tableController = Get.put(TableController());

  @override
  void initState() {
    super.initState();
    // Initialize the table data when the screen loads.
    tableController.initializeTableData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Dynamic Table"),
        ),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.all(),
                    children: controller.tableData.map((row) {
                      return TableRow(
                        children: row.map((cell) {
                          return TableCell(
                            child: cell == 'Editable'
                                ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                onSubmitted: (value) {
                                  controller.validateAndUpdate(
                                    controller.tableData.indexOf(row),
                                    row.indexOf(cell),
                                    value,
                                  );
                                },
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cell.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final sum = controller.calculateSum();
                Get.snackbar("Sum Result", "The sum of the table is $sum");
              },
              child: const Text("Calculate Sum"),
            ),
          ],
        ),
      );
    });
  }
}
