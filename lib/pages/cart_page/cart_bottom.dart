import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          //修改部分--------start----------
          selectAllButton(context),
          allPriceArea(context),
          goButton(context)
          //修改部分--------end----------
        ],
      ),
    );
  }

  // 全选按钮
  Widget selectAllButton(context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {},
          ),
          Text('全选')
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(context) {
    //修改代码---------------start------------
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    //修改代码---------------end------------
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36)
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                //修改代码---------------start------------
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: Colors.red
                  ),
                ),
                //修改代码---------------end------------
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22)
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 结算按钮
  Widget goButton(context) {
    //修改代码---------------start------------
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    //修改代码---------------end------------
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0)
          ),
          //修改代码---------------start------------
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          //修改代码---------------end------------
        ),

      ),
    );
  }
}
