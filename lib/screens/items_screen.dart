import 'package:flutter/material.dart';
import '../core/utils/database_helper.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});
  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> _items = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  Future<void> _loadItems() async {
    final items = await _databaseHelper.getAllItems();
    setState(() {
      _items = items;
    });
  }
  Future<void> _addItem() async {
    await _databaseHelper.insertItem({
      'name': nameController.text,
      'barcode': barcodeController.text,
      'price': double.tryParse(priceController.text) ?? 0.0,
    });
    _clearFields();
    _loadItems();
  }
  Future<void> _updateItem(int id) async {
    await _databaseHelper.updateItem({
      'id': id,
      'name': nameController.text,
      'barcode': barcodeController.text,
      'price': double.tryParse(priceController.text) ?? 0.0,
    });
  }
  Future<void> _deleteItem(int id) async {
    await _databaseHelper.deleteItem(id);
  }
  void _clearFields() {
    nameController.clear();
    barcodeController.clear();
    priceController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "name"),
            ),
            SizedBox(height: h * 0.01),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "price"),
            ),
            SizedBox(height: h * 0.01),
            TextField(
              controller: barcodeController,
              decoration: InputDecoration(labelText: "barcode"),
            ),
            SizedBox(height: h * 0.01),
            ElevatedButton(onPressed: _addItem, child: Text('Add Item')),
            SizedBox(height: h * 0.01),
            Divider(),
            SizedBox(height: h * 0.01),
            SizedBox(
              height: h*0.4,
              child: Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item['name']),
                          Text('Barcode: ${item['barcode']} \n Price: ${item['price']}'),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                              IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
