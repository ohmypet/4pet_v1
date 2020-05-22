import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit My Profile'),
      ),
      body: _buildEditProfile(),
    );
  }

  Widget _buildEditProfile() {
    return SizedBox();
  }
}
