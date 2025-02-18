import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/complaints/presentation/providers/complaints_provider.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/complaints/data/repositories/complaints_repository_impl.dart';
import 'features/complaints/domain/services/complaint_service.dart';
import 'features/complaints/domain/services/status_tracking_service.dart';
import 'features/complaints/presentation/providers/search_provider.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/presentation/providers/profile_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    SpeakUpApp(
      sharedPreferences: prefs,
    ),
  );
}

class SpeakUpApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const SpeakUpApp({
    super.key,
    required this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthRepositoryImpl(),
        ),
        Provider(
          create: (context) => ComplaintsRepositoryImpl(),
        ),
        Provider(
          create: (context) => ComplaintService(
            context.read<ComplaintsRepositoryImpl>(),
          ),
        ),
        Provider(
          create: (context) => StorageService(sharedPreferences),
        ),
        Provider(
          create: (context) => ProfileRepositoryImpl(
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            context.read<AuthRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ComplaintsProvider(
            context.read<ComplaintService>(),
          ),
        ),
        Provider(
          create: (context) => StatusTrackingService(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(
            context.read<ComplaintService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            context.read<ProfileRepositoryImpl>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Speak Up',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.initial,
        routes: AppRoutes.routes,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome to\nSpeak Up!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Log in to get started',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialLoginButton(
                    icon: 'assets/images/google.png',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  _SocialLoginButton(
                    icon: 'assets/images/apple.png',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Phone number input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '+82',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          icon,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeTab(),
          HistoryTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Placeholder widgets for tabs
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Tab'));
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('History Tab'));
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Tab'));
  }
}
