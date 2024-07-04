import 'package:calling_app/utility/database_services.dart';
import 'package:calling_app/utility/phone_numbar_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/widget/custom_call_button.dart';

class Demo2 extends StatefulWidget {
  const Demo2({super.key});

  @override
  State<Demo2> createState() => _Demo2State();
}
List<PhoneNumbarModel> _contacts = [];
class _Demo2State extends State<Demo2> {
  late SharedPreferences _sharedPreferances;
  String key="key";
  final DatabaseServices _databaseServices = DatabaseServices();


  @override
  void initState() {
    super.initState();
    loading();
  }
  firstTimeUser()async{
    // getTheValOfSharedPref();
    bool r=await getTheValOfSharedPref();
    print(r);
    if(r){
      _sharedPreferances.setBool(key, false);
      print("okok");
      return true;
    }
    return false;
  }
  getTheValOfSharedPref()async{
    return  _sharedPreferances.getBool(key)??true;
  }

  Future<void> _fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    //Object to Object an modalclass ++List of Object
    List<PhoneNumbarModel> contactModels = contacts
        .map((contact) => PhoneNumbarModel.fromContact(contact))
        .toList();

    for (var contact in contactModels) {
      await _databaseServices.insertContact(contact);
    }

    _loadContacts();
  }

  Future<void> _loadContacts() async {
    List<PhoneNumbarModel> contacts = await _databaseServices.fetchContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchContactOnText(),));
            },

            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(26))),
              child: Stack(
                children: [
                  IconButton(onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchContactOnText(),));

                  }, icon: Icon(Icons.search_sharp)),
                  const Positioned(
                      left: 49,
                      top: 10,
                      child: Text(
                        "Enter Name",
                        style: TextStyle(fontSize: 15),
                      )),
                  Positioned(
                      right: 10,
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {},
                      )),
                  Positioned(
                      right: 40,
                      child: IconButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchContactOnText(),));
                        },
                        icon: Icon(Icons.mic),
                      ))
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
            firstTimeUser();
          // print(r);
        },
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ElevatedButton(
            //   onPressed: _fetchContacts,
            //   child: Text('ok'),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  print(_contacts[0].image?.isEmpty);
                  return CustomCallButton.custonListTile(
                    // obj: _contacts[index],
                      displayName: _contacts[index].displayName,
                      givenName: _contacts[index].displayName,
                      context: context,
                      phone: _contacts[index].phone,
                      avtar: _contacts[index].image!.isEmpty?true:_contacts[index].image,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loading() async {
     _sharedPreferances=await SharedPreferences.getInstance();
    DatabaseServices d = DatabaseServices();
    await d.database;
    bool result= await firstTimeUser();
    if(result){
      await _fetchContacts();
    }else{
      await _loadContacts();
    }
  }
}
/*

import 'package:contacts_service/contacts_service.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';

class ContactModel {
  int? id;
  String displayName;

  ContactModel({this.id, required this.displayName});

  // Convert a ContactModel object to a Map
  Map<String, dynamic> toMap() {
    return {'id': id,'displayName': displayName,};
  }

  // Convert a Map to a ContactModel object
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      displayName: map['displayName'],
    );
  }

  // Convert a Contact object to ContactModel
  factory ContactModel.fromContact(Contact contact) {
    return ContactModel(
      displayName: contact.displayName ?? 'No Name',
    );
  }
}
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const contactTable = '''
    CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      displayName TEXT NOT NULL
    )
    ''';

    await db.execute(contactTable);
  }

  Future<void> insertContact(ContactModel contact) async {
    final db = await instance.database;
    await db.insert('contacts', contact.toMap());
  }

  Future<List<ContactModel>> fetchContacts() async {
    final db = await instance.database;
    final result = await db.query('contacts');
    return result.map((json) => ContactModel.fromMap(json)).toList();
  }


}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ContactModel> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    List<ContactModel> contactModels = contacts.map((contact) => ContactModel.fromContact(contact)).toList();

    // Insert contacts in batches
    for (var contact in contactModels) {
      await DatabaseHelper.instance.insertContact(contact);
    }

    _loadContacts();
  }

  Future<void> _loadContacts() async {
    List<ContactModel> contacts = await DatabaseHelper.instance.fetchContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _fetchContacts,
              child: Text('Fetch and Save Contacts'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_contacts[index].displayName),
                    // subtitle: Text(_contacts[index].id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
