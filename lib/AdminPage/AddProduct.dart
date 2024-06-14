import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../Api_Connections/Api_Connections.dart';
import '../Constants/stylingConstants.dart' as style;

class ProductUploader extends StatefulWidget {
  @override
  _ProductUploaderState createState() => _ProductUploaderState();
}

class _ProductUploaderState extends State<ProductUploader> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedImageBase64;
  File imageFile = File('');

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImageBase64 = null;
      });
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _selectedImageBase64 = base64Image;
      });
    }
  }

  Future<void> _uploadProduct() async {
    try {
      if (_selectedImageBase64 == null) {
        _showAlertDialog('Error', 'Please select an image.');
        return;
      }

      final String name = _nameController.text;
      final double price = double.tryParse(_priceController.text) ?? 0.0;

      final url = Uri.parse(API.AddProduct);
      final request = http.MultipartRequest('POST', url);
      request.fields['name'] = name;
      request.fields['price'] = price.toString();
      request.fields['image'] = _selectedImageBase64!;

      final response = await request.send();
      if (response.statusCode == 200) {
        print(response.toString());
        final responseString = await response.stream.bytesToString();
        print(responseString);
        _showAlertDialog('Success', 'Product uploaded successfully!');
            Navigator.pop(context);

      } else {
        throw Exception('Failed to upload product: ${response.statusCode}');
      }
    } catch (e) {
      _showAlertDialog('Error', 'An error occurred: $e');
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Delivery Person', style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: style.superColor,

        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image', style: TextStyle(color: Colors.black),),
              ),
              SizedBox(height: 20),
              _selectedImageBase64 != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Image.memory(
                        base64Decode(_selectedImageBase64!),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadProduct,
                child: Text('Upload Product', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProductUploader(),
  ));
}
