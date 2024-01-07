import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_event.dart';
import 'main_state.dart';
import 'main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  StreamSubscription<MainEvent>? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<MainViewModel>();
      _subscription = viewModel.eventStream.listen((event) {
        switch (event) {
          case DataLoadingError():
            const snackBar = SnackBar(
              content: Text('네트워크 에러'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final MainViewModel viewModel = context.watch<MainViewModel>();
    final MainState state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        leading: const FlutterLogo(),
        title: const Text('이미지 검색 앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: '검색',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.cyan,
                    ),
                    onPressed: () {
                      viewModel.fetchImages(_textEditingController.text);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 32,
                                mainAxisSpacing: 32),
                        itemCount: state.imageItems.length,
                        itemBuilder: (context, index) {
                          final imageItem = state.imageItems[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              imageItem.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
