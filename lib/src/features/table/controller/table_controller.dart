import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser; // Import the HTML parser

class TableController extends GetxController {
  var tableData = <List<dynamic>>[]; // Holds the table data
  var isLoading = false;

  // HTML data as a string
  final String htmlData = '''
<html>
  <head></head>
  <body>
    <figure class="table">
      <table>
        <tbody>
          <tr>
            <td>EditText</td>
            <td>105</td>
          </tr>
          <tr>
            <td>203</td>
            <td>EditText</td>
          </tr>
          <tr>
            <td>EditText</td>
            <td>EditText</td>
          </tr>
          <tr>
            <td>EditText</td>
            <td>406</td>
          </tr>
        </tbody>
      </table>
    </figure>
  </body>
</html>
''';

  // Parse HTML to extract table data
  List<List<dynamic>> parseHtmlToTable(String htmlResponse) {
    final document = html_parser.parse(htmlResponse); // Parse the HTML string
    final tableRows = document.getElementsByTagName('tr'); // Get all table rows

    return tableRows.map((row) {
      final cells = row.getElementsByTagName('td'); // Get cells in each row
      return cells.map((cell) {
        final text = cell.text.trim(); // Extract cell text
        return text == "EditText" ? "Editable" : int.tryParse(text) ?? text;
      }).toList();
    }).toList();
  }

  // Initialize the table data from the HTML string
  void initializeTableData() {
    try {
      isLoading = true;
      update(); // Notify GetBuilder to rebuild
      tableData = parseHtmlToTable(htmlData); // Parse the HTML string
    } catch (e) {
      Get.snackbar("Error", "Failed to parse data");
    } finally {
      isLoading = false;
      update(); // Notify GetBuilder to rebuild
    }
  }

  // Validate and update editable fields
  void validateAndUpdate(int row, int column, String value) {
    if (int.tryParse(value) == null || int.parse(value) < 100 || int.parse(value) > 999) {
      Get.snackbar("Invalid Input", "Enter a number between 100 and 999");
      return;
    }

    if (tableData.any((rowData) => rowData.contains(int.parse(value)))) {
      Get.snackbar("Duplicate Value", "This number already exists in the table");
      return;
    }

    tableData[row][column] = int.parse(value);
    update(); // Notify GetBuilder to rebuild the widget
  }

  // Calculate the sum of all integers in the table
  int calculateSum() {
    return tableData.fold(
      0,
          (sum, row) => sum + row.whereType<int>().fold(0, (subtotal, value) => subtotal + value),
    );
  }
}
