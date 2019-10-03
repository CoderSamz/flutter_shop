class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  //------新添加代码----start
  bool isCheck;
  //------新添加代码----end

  CartInfoModel(
      //需要修改---------start-----
      {this.goodsId, this.goodsName, this.count, this.price, this.images, this.isCheck});
      //需要修改---------end-----

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
    //------新添加代码----start
    isCheck = json['isCheck'];
    //------新添加代码----end
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    //------新添加代码----start
    data['isCheck'] = this.isCheck;
    //------新添加代码----end
    return data;
  }
}
