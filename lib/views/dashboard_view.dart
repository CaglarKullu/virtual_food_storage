import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_food_storage/providers/food_item_provider.dart';
import 'package:virtual_food_storage/state/user_state.dart';
import '../providers/user_provider.dart';
import 'item_management_view.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItems = ref.watch(foodItemControllerProvider);
    final userController = ref.read(userProvider.notifier);
    final userState = ref.watch(userProvider);
    log(userState.status.toString());
    return switch (userState.status) {
      UserStateStatus.initial => Navigator.pushNamed(context, '/login'),
      UserStateStatus.loading => const Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()),
        ),
      UserStateStatus.success => Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref.refresh(foodItemControllerProvider);
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () async {
                  await userController.signOut();
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              final item = foodItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                    'Expires on: ${item.expirationDate.toIso8601String()}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItemManagementView(item: item),
                        ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(foodItemControllerProvider.notifier)
                            .deleteItem(item.id);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      UserStateStatus.error =>
        Scaffold(body: Text(userState.errorMessage.toString())),
    } as Widget;
  }
}
