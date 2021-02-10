
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/order_history.dart';
import 'package:sto_app/pages/order/order_history_item.dart';
import "package:sto_app/widgets/app_widgets.dart";
import 'package:http/http.dart' as http;


class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({Key key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  gethistory() async {
    var token = await getToken();
     http.Response  response =  await http.get("${AppConstants.baseUrl}order/history/",
        headers: {'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"});

     if (response.statusCode == 200) {

     }else {
       // If the server did not return a 200 OK response,
       // then throw an exception.
       throw Exception('Failed to load historyorder');
     }
  }

  final List<OrderHistory> historyList = <OrderHistory>[
    new OrderHistory(
        time: "7 янв. 2021г",
        location: "Алматы",
        carName: "Mercedes Benz C55 AMG",
        repairs: "Ремонт ходовой/подвески...",
        ctoName: "СТО “Denso Service”",
        price: "16500 KZT",
        isPerformed: "Выполнено"),
    new OrderHistory(
        time: "7 янв. 2021г",
        location: "Алматы",
        carName: "Mercedes Benz C55 AMG",
        repairs: "Ремонт ходовой/подвески...",
        ctoName: "СТО “Denso Service”",
        price: "16500 KZT",
        isPerformed: "Выполнено"),
    new OrderHistory(
        time: "7 янв. 2021г",
        location: "Алматы",
        carName: "Mercedes Benz C55 AMG",
        repairs: "Ремонт ходовой/подвески...",
        ctoName: "СТО “Denso Service”",
        price: "16500 KZT",
        isPerformed: "Выполнено"),
  ];

  @override
  void initState() {
    gethistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("История заказов"),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
            itemCount: historyList.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderHistoryItem(orderHistory: historyList[index]);
            }),
      ),
    );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      historyList.removeAt(0);
    });
    return null;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }


  // getHistory() async {
  //   var token = await getToken();
  //   await Dio().get(
  //     "${AppConstants.baseUrl}order/history/",
  //     options: Options(
  //         headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "Accept": "application/json",
  //         "Authorization": "Token $token"
  //       },
  //       followRedirects: false,
  //       validateStatus: (status) {
  //         return status < 500;
  //       },
  //     ),
  //     ).then((response) {
  //       print(response);
  //     }).catchError((error) => print(error));
  // }
}
