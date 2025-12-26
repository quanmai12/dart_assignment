// lib/services/order_manager.dart
import 'dart:convert';
import 'dart:io';
import '../models/order.dart'; // Import file model (đường dẫn tương đối)

class OrderManager {
  List<Order> _orders = []; // Biến private chứa danh sách đơn hàng

  // Hàm load dữ liệu mẫu ban đầu
  void loadSampleData(String jsonString) {
    List<dynamic> parsedJson = jsonDecode(jsonString);
    _orders = parsedJson.map((json) => Order.fromJson(json)).toList();
  }

  // 1. Hiển thị danh sách
  void displayOrders([List<Order>? listToDisplay]) {
    // Nếu không truyền list cụ thể thì in list mặc định
    final list = listToDisplay ?? _orders; 

    print('\n--- DANH SÁCH ĐƠN HÀNG ---');
    print('${"Mã SP".padRight(10)} | ${"Tên Sản Phẩm".padRight(20)} | ${"Giá".padRight(10)} | ${"Tiền".padRight(5)} | SL');
    print('-' * 60);
    if (list.isEmpty) {
      print("Danh sách trống.");
    } else {
      for (var order in list) {
        print(order.toString());
      }
    }
    print('-' * 60);
  }

  // 2. Thêm đơn hàng
  void addOrder() {
    print('\n--- THÊM ĐƠN HÀNG MỚI ---');
    stdout.write('Nhập mã sản phẩm (Item): ');
    String item = stdin.readLineSync() ?? '';

    stdout.write('Nhập tên sản phẩm (ItemName): ');
    String itemName = stdin.readLineSync() ?? '';

    double price = 0.0;
    while (true) {
      stdout.write('Nhập giá (Price): ');
      try {
        price = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print('Lỗi: Giá phải là số.');
      }
    }

    stdout.write('Nhập đơn vị tiền tệ (Currency - mặc định USD): ');
    String currency = stdin.readLineSync() ?? 'USD';
    if (currency.trim().isEmpty) currency = 'USD';

    int quantity = 0;
    while (true) {
      stdout.write('Nhập số lượng (Quantity): ');
      try {
        quantity = int.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print('Lỗi: Số lượng phải là số nguyên.');
      }
    }

    Order newOrder = Order(
      item: item,
      itemName: itemName,
      price: price,
      currency: currency,
      quantity: quantity,
    );

    _orders.add(newOrder);
    print('-> Đã thêm thành công!');
  }

  // 3. Tìm kiếm
  void searchOrder() {
    stdout.write('\n--- TÌM KIẾM SẢN PHẨM ---\nNhập tên cần tìm: ');
    String keyword = stdin.readLineSync()?.toLowerCase() ?? '';

    List<Order> results = _orders
        .where((o) => o.itemName.toLowerCase().contains(keyword))
        .toList();

    if (results.isEmpty) {
      print('Không tìm thấy sản phẩm nào chứa "$keyword".');
    } else {
      print('-> Tìm thấy ${results.length} kết quả:');
      displayOrders(results); // Tái sử dụng hàm hiển thị
    }
  }

  // 4. Lưu file
  void saveToFile(String fileName) {
    try {
      List<Map<String, dynamic>> jsonList = _orders.map((o) => o.toJson()).toList();
      JsonEncoder encoder = JsonEncoder.withIndent('  ');
      String jsonString = encoder.convert(jsonList);

      File file = File(fileName);
      file.writeAsStringSync(jsonString);
      print('\n[SYSTEM] Đã lưu dữ liệu vào file "$fileName" thành công.');
    } catch (e) {
      print('\n[ERROR] Không thể ghi file: $e');
    }
  }
}