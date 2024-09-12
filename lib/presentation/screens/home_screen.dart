// ignore_for_file: library_private_types_in_public_api
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:repository_pattern/domain/models/user.dart';
import 'package:repository_pattern/domain/repositories/user_repository.dart';
import 'package:repository_pattern/presentation/widgets/simmer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  final UserRepository userRepository;

  const HomeScreen({super.key, required this.userRepository});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<User> _userFuture;
  String _userId = '1';

  @override
  void initState() {
    super.initState();
    _userFuture = widget.userRepository.getUser(_userId);
  }

  Future<void> _refreshUser() async {
    final randomId = (Random().nextInt(10) + 1).toString();
    setState(() {
      _userId = randomId;
      _userFuture = widget.userRepository.getUser(_userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshUser,
            tooltip: 'Refresh User',
          ),
        ],
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "${user.id.toString()}. ${user.name}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'tekan refresh untuk melihat nama pengguna lain',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CardShimmerLoading(
                width: 200,
                height: 40,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
