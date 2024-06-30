import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/products_screen.dart';
import 'package:flutter_application_1/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final user = await ApiServices().authenticateUser(
        _usernameController.text,
        _passwordController.text,
      );

      if (user != null) {
      //final cartProducts = await ApiServices().fetchCartByUserId(user.id); // Obtén el carrito del usuario
      final products = await ApiServices().fetchProducts(); // Obtén todos los productos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductsScreen(products: products), // Pasa ambos al ProductScreen
        ),
      );
      } else  {
        // Credenciales incorrectas: Muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('')),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '../../assets/logo.png',
                  height: 100,
                ),
                SizedBox(height: 16),
                Text(
                  'FakeStore',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Form( // Formulario de login
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: 'User'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ), // Cierra el Form aquí
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  