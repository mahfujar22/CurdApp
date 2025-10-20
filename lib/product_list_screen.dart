
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project/product_class.dart';
import 'add_product_screen.dart';
import 'update_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getProductListInProgress = false;
  List<ProductModel> productList = [];

  @override
  void initState() {
    _getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductListInProgress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _buildProductItem(productList[index]);
            },
            separatorBuilder: (_, __) => Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    productList.clear();
    String productListUrl = "https://crud.teamrabbil.com/api/v1/ReadProduct";
    Uri uri = Uri.parse(productListUrl);
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      final jsonProductList = decodeData["data"];

      for(Map<String,dynamic>json in jsonProductList){
        ProductModel productModel = ProductModel.fromJson(json);
        productList.add(productModel);
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Get product list failed! Try again')),
      );
    }
    _getProductListInProgress = false;
    setState(() {});
  }


  Widget _buildProductItem(ProductModel product) {
    return ListTile(
      /*leading: Image.network(
       "${product.image}",
        height: 60,
        width: 60,
      ),*/
      title: Text(product.productName?? "Unknown"),
      subtitle: Wrap(
        spacing: 62,
        children: [
          Text("Unit price : ${product.unitPrice}"),
          Text("Quantity : ${product.quantity}"),
          Text("Total price : ${product.totalPrice}"),
        ],
      ),

      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProductScreen(
                      product: product
                  ),
                ),
              );
              if (result == true) {
                _getProductList();
              }
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(product.Id!);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(String productId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are you sure that you want to delete this product"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(productId);
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(String ProductId) async {
    _getProductListInProgress = true;
    setState(() {});
    String deleteProductUel = "https://crud.teamrabbil.com/api/v1/DeleteProduct/$ProductId";
    Uri uri = Uri.parse(deleteProductUel);
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _getProductListInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete product failed! Try again')),
      );
    }

  }
}
