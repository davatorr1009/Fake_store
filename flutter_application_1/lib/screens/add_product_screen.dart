import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/api_services.dart';



class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _categoryController = TextEditingController();
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false); // Inicializa el provider aquí
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'URL de la Imagen'),
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Categoría'),
                validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
              ),
              ElevatedButton(
                onPressed: _addProduct,           
                
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: 0,
        title: _titleController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        image: _imageController.text,
        category: _categoryController.text,
      );

      try {
        final apiService = ApiServices();
        final addedProduct = await apiService.addProduct(newProduct);
        productProvider.updateProducts(addedProduct);
        Navigator.pop(context); 
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar el producto: $error')),
        );
      }
    }
  }
}

