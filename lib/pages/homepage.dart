import 'dart:convert';

import 'package:Minima.list/models/item.dart';
import 'package:Minima.list/pages/developer.dart';
import 'package:Minima.list/pages/donate.dart';
import 'package:Minima.list/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  var items = new List<Item>();

  HomePage() {
    items = [];
    // items.add(Item(title: "Item 1", done: true));
    // items.add(Item(title: "Item 2", done: true));
    // items.add(Item(title: "Item 3", done: true));
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  //Método que adiciona novo item a lista pelo FloatingActionButton
  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(
        Item(
          title: newTaskCtrl.text,
          done: false,
        ),
      );
      newTaskCtrl.text = "";
      save();
    });
  }

  // Método que remove itens da lista pelo Dismissible
  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  // Método para carregar dados do item.dart Json
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      //Cria lista de strings iteraveis
      Iterable decoded = jsonDecode(data);
      //Converte itens do Json para Lista
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  // Método para salvar itens da lista
  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: "Add Item:",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<String>( 
            icon: Icon(Icons.menu),        
                  onSelected: choiceAction,       
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(                     
                        value: choice,                 
                        child: Text(choice),                         
                      );
                    }).toList();
                  },
                ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF212121),
            const Color(0xFF424242),],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )
        ),
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (ctxt, index) {
            final item = widget.items[index];
            return Dismissible(
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (value) {
                  setState(() {
                    item.done = value;      
                    save();
                  });
                },
              ),
              key: Key(item.title),
              background: Container(
                color: Colors.white.withOpacity(0.2),
              ),
              onDismissed: (direction) {
                remove(index);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
    );
  }

  void choiceAction(String choice) {
    setState(() {
      if(choice == Constants.DeveloperPage){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DeveloperPage()));
      } else if(choice == Constants.DonatePage){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DonatePage()));
      }
    });
  }
}
