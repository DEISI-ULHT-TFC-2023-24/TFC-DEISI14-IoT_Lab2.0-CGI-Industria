import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tfc_industria/navigationBarPages/main_page.dart';

import 'navigationBarPages/home.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final _formKey = GlobalKey<FormState>(); // Chave para identificar o formulário

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final snapshot = await _databaseReference.child('listNode').get();
      if (snapshot.exists) {
        print(snapshot.value);
      } else {
        print('No data available.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60),
                  Image.asset('images/img.png'),
                  const Text(
                    'IOT - IndusTria',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                  SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please login to your account',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),


                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o Username';
                      } else if (value != "U4567") {
                        return 'Username incorreto';
                      }
                      return null;
                    },
                  ),


                  SizedBox(height: 25),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),


                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira Password';
                      } else if (value != "12345") {
                        return 'Password incorreta';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // Background color
                      minimumSize: Size.fromHeight(50), // Button size
                    ),
                    onPressed: () {
                      // Validate retorna true se o formulário é válido, ou seja, todos os campos passaram pelas validações
                      if (_formKey.currentState!.validate()) {
                        // Ir para outro ecra sem conseguir voltar atras
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => MainPages()),
                        );
                      }
                    },
                    child: const Text('Sign In', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password? Contact Your Manager'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
