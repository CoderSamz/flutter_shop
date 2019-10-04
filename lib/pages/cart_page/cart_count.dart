import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartCount extends StatelessWidget {

  var item;
  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12
        ),
      ),
      child: Row(

        children: <Widget>[

          _reduceButton(context),
          _countArea(),
          _addButton(context)

        ],

      ),
    );
  }

  // 减少按钮
  Widget _reduceButton(context) {
    return InkWell(
      onTap: (){

        Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');

      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? Colors.white : Colors.black12,
          border: Border(
            right: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  // 添加按钮
  Widget _addButton(context) {
    return InkWell(
      onTap: (){
        //--------------新增加代码------------start--------
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
        //--------------新增加代码------------end--------
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: Text('+'),
      ),
    );
  }

  // 中间数量显示区域
  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      //--------------修改代码------------start--------
      child: Text('${item.count}'),
      //--------------修改代码------------end--------
    );
  }


}
