import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix_expert/core/utils/hooks/bottom_sheet_image_picker.dart';

const double radiusCircle = 10;
const double sizeContainer = 125;

const optionsPhoto = [
  {
    "label": 'Tomar Foto',
    "icon": Icons.photo_camera,
    "value": ImageSource.camera,
    "isCancel": false,
  },
  {
    "label": 'Cancelar',
    "icon": Icons.close,
    "value": null,
    "color": ColorsAppTheme.primaryColor,
    "isCancel": true,
  }
];

class AvatarImageRegister extends StatefulWidget {
  const AvatarImageRegister({
    Key? key,
    this.file,
    this.label = '',
    this.sizeIcon = 50,
    this.isActive = true,
    required this.onClick,
  }) : super(key: key);

  final String? file;
  final String? label;
  final bool? isActive;
  final double? sizeIcon;
  final void Function(XFile)? onClick;

  @override
  _AvatarImageRegisterState createState() => _AvatarImageRegisterState();
}

class _AvatarImageRegisterState extends State<AvatarImageRegister> {
  XFile? file;
  final bottomSheetImagePicker = BottomSheetImagePicker(items: optionsPhoto);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Column(
        children: [
          file != null || widget.file != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(radiusCircle),
                  child: Image(
                    image: file != null
                        ? FileImage(File(file!.path)) as ImageProvider
                        : NetworkImage(widget.file!),
                    fit: BoxFit.cover,
                    width: sizeContainer,
                    height: sizeContainer,
                  ),
                )
              : Container(
                  width: sizeContainer,
                  height: sizeContainer,
                  decoration: BoxDecoration(
                    color: ColorsAppTheme.greyAppPalette[50],
                    borderRadius: BorderRadius.circular(radiusCircle),
                    border: Border.all(
                      color: ColorsAppTheme.greyAppPalette[100]!,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    MaterialCommunityIcons.camera_outline,
                    size: widget.sizeIcon,
                    color: ColorsAppTheme.primaryColor,
                  ),
                ),
          SizedBox(height: widget.label!.isEmpty ? 0 : 15),
          widget.label!.isEmpty
              ? const SizedBox()
              : Text(
                  widget.label!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
        ],
      ),
    );
  }

  void _pickImage() async {
    if (widget.isActive!) {
      final ImagePicker _picker = ImagePicker();

      final imageSource = await bottomSheetImagePicker.show(context);
      if (imageSource != null) {
        final XFile? _file = await _picker.pickImage(source: imageSource);
        if (_file != null) {
          setState(() {
            file = _file;
          });
          widget.onClick?.call(_file);
        }
      }
      return null;
    }
  }
}
