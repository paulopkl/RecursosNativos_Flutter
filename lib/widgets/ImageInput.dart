import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takeAPicture() async {
    final ImagePicker _picker = ImagePicker();

    XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (photo == null) return;

    setState(() {
      _storedImage = File(photo.path);
    });

    // Diretório para armazenar a imagem
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // Nome do Arquivo
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(appDir.path + "/" + fileName);
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text("Nenhuma imagem!"),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text(
              "Tirar Foto",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: _takeAPicture,
          ),
        ),
      ],
    );
  }
}
