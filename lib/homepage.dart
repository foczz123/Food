import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> food = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Food'),
      ),
      body:
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _handleClickButton,
              child: const Text('LOAD FOODS DATA'),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: food.length,
                    itemBuilder: (BuildContext context,int index){
                      return ListTile(
                          leading: Image.network(food[index].image),
                          trailing: Text( '${food[index].price} บาท',
                            style: TextStyle(
                                color: Colors.green,fontSize: 15),),
                          title:Text(food[index].name)
                      );
                    }
                ),),
          ],
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _handleClickButton() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    var result = await http.get(url);
    var json = jsonDecode(result.body);
    food = json['data'];
    var food_length = food.length;
    print("Length of List: $food_length ");
    print(food);
  }
}
