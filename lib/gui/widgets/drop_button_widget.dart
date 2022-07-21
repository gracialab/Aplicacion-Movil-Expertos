import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/data/models/list_options_model/list_options_model.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({
    Key? key,
    this.title = 'Selecciona una opción',
    this.initialValue,
    required this.onChanged,
    required this.listOptions,
  }) : super(key: key);

  final String? title;
  final ListOptionsModel? initialValue;
  final List<ListOptionsModel> listOptions;
  final Function(ListOptionsModel) onChanged;

  @override
  _DropDownButtonWidgetState createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  ListOptionsModel? _selectValue;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      _selectValue = widget.initialValue;
    } else {
      _selectValue = widget.listOptions.first;
      widget.onChanged.call(widget.listOptions.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isAndroid ? _duesAndroid(context) : _duesIOS(context),
    );
  }

  Widget _duesAndroid(BuildContext context) => PopupMenuButton(
        child: SizedBox(
          width: 40,
          child: Row(
            children: [
              Text(_selectValue!.label),
              const SizedBox(height: 5),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
        color: Colors.white,
        itemBuilder: (context) => List.generate(
          widget.listOptions.length,
          (index) => PopupMenuItem<ListOptionsModel>(
            value: widget.listOptions[index],
            child: Text(
              widget.listOptions[index].label,
            ),
          ),
        ),
        enabled: true,
        onSelected: (ListOptionsModel value) {
          setState(() {
            _selectValue = value;
          });
          widget.onChanged.call(value);
        },
      );

  Widget _duesIOS(BuildContext context) => SizedBox(
        width: 40,
        child: GestureDetector(
          onTap: () => _showPicker(context),
          child: Row(
            children: [
              Text(_selectValue!.label),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
      );

  void _showPicker(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(
        data: List.generate(
          widget.listOptions.length,
          (index) => PickerItem(
            text: Text(
              widget.listOptions[index].label,
            ),
          ),
        ),
      ),
      cancelText: 'Cancelar',
      cancelTextStyle: const TextStyle(
        color: ColorsAppTheme.redColor,
        fontSize: 14,
      ),
      confirmText: 'Confirmar',
      confirmTextStyle: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 14,
      ),
      title: Text(
        widget.title!,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      onConfirm: (Picker _, List value) {
        setState(() {
          _selectValue = widget.listOptions[value[0]];
        });
        widget.onChanged.call(widget.listOptions[value.first]);
      },
    ).showModal(context);
  }
}
