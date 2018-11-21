import 'package:flutter/material.dart';
import 'package:sqlexample/Database/Model.dart';
import 'package:sqlexample/Database/database_helper.dart';
import 'package:sqlexample/list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo', 
      theme: new ThemeData( 
        primarySwatch: Colors.blue,
      ),
      
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    String firstname; 
    String lastname;
    String emailID;
    String phone;
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title), 
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'next',
            onPressed: () { navigateToEmployeeList(); },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: new Form(
          key:formKey,
          child: Column(
            children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text, 
                  decoration: new InputDecoration(labelText: 'Firstname',prefixIcon: Icon(Icons.person_add),),
                  validator: (val) => val.length == 0 ? "Enter Firstname" : null,
                  onSaved: (val) =>this.firstname=val,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Last Name',prefixIcon: Icon(Icons.person)),
                  validator: (val) =>
                      val.length ==0 ? 'Enter LastName' : null,
                  onSaved: (val) => this.lastname = val,
                ),
                new TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(labelText: 'Mobile No',prefixIcon: Icon(Icons.phone)),
                  validator: (val) =>
                      val.length ==0 ? 'Enter Mobile No' : null,
                  onSaved: (val) => this.phone = val,
                ),
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(labelText: 'Email Id',prefixIcon: Icon(Icons.email)),
                  validator: (val) =>
                      val.length ==0 ? 'Enter Email Id' : null,
                  onSaved: (val) => this.emailID = val,
                ),
                new Padding(padding: EdgeInsets.only(top:20.0),),
                new RaisedButton( shape: Border.all(),
                  color: Colors.amberAccent,
                  child: Text('Login'),
                  onPressed: _submit, 
                ),
            ],
          ),
        ),
      )    
    );
  }
  
    void _submit() 
   {
     
         if (this.formKey.currentState.validate()) 
        {
          formKey.currentState.save(); 
        }
          var employee = Employee(firstname,lastname,phone,emailID);
          var dbHelper = DBHelper();
          dbHelper.saveEmployee(employee);
          _showSnackBar("Data saved successfully");
 }
    void _showSnackBar(String text) 
   {
         scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
   }

    void navigateToEmployeeList()
   {
        Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new MyEmployeeList()),
       );
   }

}
