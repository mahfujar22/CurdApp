
class ProductModel {
  String? Id;
  String? productName;
  String? productCode;
  String? image;
  String? unitPrice;
  String? quantity;
  String? totalPrice;
  String? createdDate;

  ProductModel.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    image = json['Img'];
    unitPrice = json['UnitPrice'];
    quantity = json['Qty'];
    totalPrice = json['TotalPrice'];
    createdDate = json['CreatedDate'];
  }
}

