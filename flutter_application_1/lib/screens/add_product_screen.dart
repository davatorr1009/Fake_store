/*import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_services.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Product) onAddProduct; // Callback para agregar el producto

  AddProductScreen({required this.onAddProduct});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  void _addProduct() async { // Marca la función como async
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: 0, // ID temporal, se ignorará
        title: _titleController.text,
        price: double.parse(_priceController.text),
        category: _categoryController.text,
        description: _descriptionController.text,
        image: _imageController.text,
      );

      try {
        final addedProduct = await ApiServices().addProduct(newProduct);
        widget.onAddProduct(addedProduct); // Llama al callback con el producto actualizado
        Navigator.pop(context); 
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar el producto: $error')),
        );
      }
    }
  }

  // ... (Formulario con TextFormFields para los datos del producto)

 @override
  Widget build(BuildContext context) { // Implementa el método build
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Título'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el título del producto';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Precio'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el precio del producto';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor ingresa un número válido';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Categoría'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa la categoría del producto';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Descripción'),
            maxLines: null, // Permite múltiples líneas
          ),
          TextFormField(
            controller: _imageController,
            decoration: InputDecoration(labelText: 'URL de la Imagen'),
            keyboardType: TextInputType.url,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _addProduct,
            child: Text('Guardar Producto'),
          ),
        ],
      ),
    ),
  ),
),

);
    
  }
}*/