import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../../domain/entities/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../../../../core/layouts/main_layout.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../complaints/presentation/providers/complaints_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profile;
    _nameController = TextEditingController(text: profile?.name);
    _emailController = TextEditingController(text: profile?.email);
    _phoneController = TextEditingController(text: profile?.phoneNumber);
    _addressController = TextEditingController(text: profile?.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && mounted) {
      // In a real app, you would upload this file to storage
      // and get back a URL
      final profile = context.read<ProfileProvider>().profile;
      if (profile != null) {
        await context.read<ProfileProvider>().updateProfile(
              profile.copyWith(
                avatarUrl: pickedFile.path,
              ),
            );
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final profile = context.read<ProfileProvider>().profile;
      if (profile != null) {
        await context.read<ProfileProvider>().updateProfile(
              profile.copyWith(
                name: _nameController.text,
                email: _emailController.text,
                phoneNumber: _phoneController.text,
                address: _addressController.text,
              ),
            );
        setState(() => _isEditing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Add user information fields here
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, UserProfile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(profile),
            const SizedBox(height: 24),
            _buildProfileForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, UserProfile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildAvatar(profile),
                  const SizedBox(height: 24),
                  _buildProfileStats(profile),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 3,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildProfileForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, UserProfile profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildAvatar(profile),
                const SizedBox(height: 24),
                _buildProfileStats(profile),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildProfileForm(),
                ),
              ),
            ),
          ),
        ),
        if (ResponsiveLayout.isWeb(context))
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildActivityLog(profile),
                  const SizedBox(height: 24),
                  _buildPreferences(),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatar(UserProfile profile) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: profile.avatarUrl != null
              ? FileImage(File(profile.avatarUrl!))
              : null,
          child: profile.avatarUrl == null
              ? Text(
                  profile.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 32),
                )
              : null,
        ),
        if (_isEditing)
          Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 18,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, size: 18),
                color: Colors.white,
                onPressed: _pickImage,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileForm() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
            prefixIcon: Icon(Icons.person),
          ),
          enabled: _isEditing,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          enabled: _isEditing,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your email';
            }
            if (!value!.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone),
          ),
          enabled: _isEditing,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Address',
            prefixIcon: Icon(Icons.location_on),
          ),
          enabled: _isEditing,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildProfileStats(UserProfile profile) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Member Since'),
              subtitle: Text(
                DateFormat('MMMM yyyy').format(profile.createdAt),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Total Complaints'),
              subtitle: const Text('12'), // Replace with actual data
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Resolved'),
              subtitle: const Text('8'), // Replace with actual data
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityLog(UserProfile profile) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Add activity log items here
          ],
        ),
      ),
    );
  }

  Widget _buildPreferences() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Add preference settings here
          ],
        ),
      ),
    );
  }
} 