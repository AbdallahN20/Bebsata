import 'package:flutter/material.dart';

class setting_page extends StatefulWidget{
  const setting_page({super.key});
  @override
  State<StatefulWidget> createState() => _setting_pageState();
}

class _setting_pageState extends State<setting_page> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {


    void _showSnack () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Button tapped'),
    duration: Duration(milliseconds: 500),
    ),
    );
   return Scaffold(
     appBar: AppBar(
       title: const Text('Bebsata'),
       centerTitle: true,
       backgroundColor: Colors.teal,
       foregroundColor: Colors.white,
     ),
     body:ListView(
       padding: const EdgeInsets.all(16.0),
       children: <Widget>[
         OverflowBar(
           alignment: MainAxisAlignment.spaceEvenly,
           children: [
             ElevatedButton(onPressed: _showSnack, child: const Text("KHATTAB")),
             const ElevatedButton(
                 onPressed: null,
                 child: Text('KHATTAB'))
           ],
         )
       ],
     )



   );
  }

}