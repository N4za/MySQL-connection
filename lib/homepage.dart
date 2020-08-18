import 'dart:convert';
import 'package:http/http.dart' as http;
import 'student.dart';
import 'package:flutter/material.dart';
import 'bd_connections.dart';
import 'insert.dart';
import 'update.dart';
import 'delete.dart';
import 'convertidor.dart';
import 'select.dart';

class homepage extends StatefulWidget {
  homepage() : super();
  final String title = "MySQL Connection";

  @override
  homepageState createState() => homepageState();
}

class homepageState extends State<homepage> {
  List<Student> _Students;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstnameConroller;
  TextEditingController _lastname1Conroller;
  TextEditingController _lastname2Conroller;
  TextEditingController _emailConroller;
  TextEditingController _phoneConroller;
  TextEditingController _matriculaConroller;
  TextEditingController _fotoConroller;

  Student _selectStudent;
  bool _isUpdating;
  String imagen;

  @override
  void initState() {
    super.initState();
    _Students = [];
    _isUpdating = false;
    Student _selectedStudent;
    _scaffoldKey = GlobalKey();
    _firstnameConroller = TextEditingController();
    _lastname1Conroller = TextEditingController();
    _lastname2Conroller = TextEditingController();
    _emailConroller = TextEditingController();
    _phoneConroller = TextEditingController();
    _matriculaConroller = TextEditingController();
    _fotoConroller = TextEditingController();
    //Llamar al método que llena la DataTable
    _selectData;
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  //CREATE TABLE
  _createTable() {
    BDConnections.createTable().then((result) {
      if ('sucess' == result) {
        _showSnackBar(context, result);
      }
    });
  }

  //INSERT DATA
  _insertData() {
    if (_firstnameConroller.text.isEmpty || _lastname1Conroller.text.isEmpty || _lastname2Conroller.text.isEmpty || _emailConroller.text.isEmpty || _phoneConroller.text.isEmpty || _matriculaConroller.text.isEmpty) {
      print("Empy fields");
      return;
    }
    BDConnections.insertData(_firstnameConroller.text, _lastname1Conroller.text, _lastname2Conroller.text, _emailConroller.text, _phoneConroller.text, _matriculaConroller.text, _fotoConroller.text)
        .then((result) {
      if ('sucess' == result) {
        _showSnackBar(context, result);
        _firstnameConroller.text = "";
        _lastname1Conroller.text = "";
        _lastname2Conroller.text = "";
        _emailConroller.text = "";
        _phoneConroller.text = "";
        _matriculaConroller.text = "";
        _fotoConroller.text = "";
        _selectData;
        _clearValues();
      }
    });
  }

  //SELECT DATA
  get _selectData {
    BDConnections.selectData().then((students) {
      setState(() {
        _Students = students;
      });
      _showSnackBar(context, "Data Acquired");
      print("size of Students ${students.length}");
    });
  }

  //DELETE DATA
  _deleteData(Student student){
    BDConnections.deleteData(student.id).then((result){
      if('success' == result){
        _selectData;
      }
    });
  }

  //CLEAR TEXTFIELD VALUES
  _clearValues(){
    _firstnameConroller.text = "";
    _lastname1Conroller.text = "";
    _lastname2Conroller.text = "";
    _emailConroller.text = "";
    _phoneConroller.text = "";
    _matriculaConroller.text = "";
    _fotoConroller.text = "";
  }

  _showValues(Student student){
    _firstnameConroller.text = student.firstName;
    _lastname1Conroller.text = student.lastName1;
    _lastname2Conroller.text = student.lastName2;
    _emailConroller.text = student.email;
    _phoneConroller.text = student.phone;
    _matriculaConroller.text = student.matricula;
    imagen = student.foto;
  }

  //CREATING DATA TABLE
  SingleChildScrollView _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Last Name 1')),
          DataColumn(label: Text('Last Name 2')),
          DataColumn(label: Text('E-mail')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Matricula')),
          DataColumn(label: Text('Fotografía')),
        ],
        rows: _Students.map((student) => DataRow(
            cells: [

              DataCell(Text(student.firstName.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    _selectStudent = student;
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.lastName1.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    _selectStudent = student;
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.lastName2.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    _selectStudent = student;
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.email.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    _selectStudent = student;
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.phone.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    _selectStudent = student;
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.matricula.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    _selectStudent = student;
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Convertir.imageFromBase64sString(student.foto)),

            ]),
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      //MENU
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/imagen.jpg"),
                      fit: BoxFit.cover
                  )
              ),
              padding: EdgeInsets.all(60),
              child: Text("   OPERATIONS:",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.teal),
              title: Text("Home",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new homepage()
                    ));
              },),
            ListTile(
              leading: Icon(Icons.add_to_photos, color: Colors.teal[800]),
              title: Text("Insert Data",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new Insert()
                    ));
              },),
            ListTile(
              leading: Icon(Icons.update, color: Colors.teal[300]),
              title: Text("Update Data",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new Update()
                    ));
              },),
            ListTile(
              leading: Icon(Icons.delete_forever, color: Colors.teal[600]),
              title: Text("Delete Data",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new Delete()
                    ));
              },),
            ListTile(
                leading: Icon(Icons.person, color: Colors.teal[200]),
                title: Text("Select Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(
                          builder: (context)
                          => new Select()
                      ));
                }
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text("MYSQL REMOTE BD OPERATIONS"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              BDConnections.createTable();
            },),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              BDConnections.selectData();
            },)
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          _insertData();
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}