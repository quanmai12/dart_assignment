// bin/main.dart
import 'dart:io';
import '../lib/services/order_manager.dart'; // Import Manager logic

void main() {
  // Khởi tạo đối tượng quản lý
  final manager = OrderManager();

  // Dữ liệu mẫu ban đầu
  String initialJson = '[{"Item": "A1000","ItemName": "Iphone 15","Price": 1200,"Currency": "USD","Quantity": 1},{"Item": "A1001","ItemName": "Iphone 16","Price": 1500,"Currency": "USD","Quantity": 1}]';
  
  // Nạp dữ liệu
  manager.loadSampleData(initialJson);

  // Vòng lặp Menu
  while (true) {
    print('\n====== QUẢN LÝ ĐƠN HÀNG (MODULAR) ======');
    print('1. Hiển thị danh sách');
    print('2. Thêm đơn hàng mới');
    print('3. Tìm kiếm đơn hàng');
    print('4. Lưu và Thoát');
    stdout.write('Chọn chức năng (1-4): ');
    
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        manager.displayOrders();
        break;
      case '2':
        manager.addOrder();
        manager.displayOrders();
        break;
      case '3':
        manager.searchOrder();
        break;
      case '4':
        manager.saveToFile('order.json');
        print('Kết thúc chương trình.');
        return;
      default:
        print('Lựa chọn không hợp lệ!');
    }
  }
}