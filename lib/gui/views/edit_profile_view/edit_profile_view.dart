import 'package:flutter/material.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/views/edit_profile_view/edit_profile_controller.dart';
import 'package:mr_fix_expert/gui/views/edit_profile_view/edit_profile_widgets/form_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final EditProfileController _controller;

  bool isLoading = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _controller = EditProfileController(context);
    await _controller.init();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Editar Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: isLoading
            ? const ActivityIndicator()
            : FormEditProfile(controller: _controller),
      ),
    );
  }
}
