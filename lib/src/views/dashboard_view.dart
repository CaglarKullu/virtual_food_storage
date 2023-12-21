import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/food_item.dart';
import '../providers/food_item_provider.dart';
import '../providers/user_provider.dart';
import '../state/user_state.dart';
import 'item_management_view.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItems = ref.watch(foodItemControllerProvider);
    final userState = ref.watch(userProvider);

    log(userState.status.toString());

    return _buildUIBasedOnState(context, ref, userState, foodItems.items!);
  }

  Widget _buildUIBasedOnState(BuildContext context, WidgetRef ref,
      UserState userState, List<FoodItem> foodItems) {
    switch (userState.status) {
      case UserStateStatus.initial:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.popAndPushNamed(context, '/login');
        });
        return const Scaffold(body: Center(child: CircularProgressIndicator()));

      case UserStateStatus.loading:
        return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()));

      case UserStateStatus.success:
        return _buildDashboard(context, ref, foodItems);

      case UserStateStatus.error:
        return Scaffold(
            body: Center(child: Text(userState.errorMessage.toString())));

      default:
        return const Scaffold(
            body: Center(child: Text('Unexpected state encountered')));
    }
  }

  Scaffold _buildDashboard(
      BuildContext context, WidgetRef ref, List<FoodItem> foodItems) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          _buildRefreshButton(ref),
          _buildLogoutButton(context, ref),
        ],
      ),
      body: _buildItemList(context, ref, foodItems),
    );
  }

  IconButton _buildRefreshButton(WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () {
        ref.refresh(foodItemControllerProvider.notifier);
      },
    );
  }

  IconButton _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout_outlined),
      onPressed: () async {
        await ref.read(userProvider.notifier).signOut();
        if (!context.mounted) return;
        Navigator.popAndPushNamed(context, '/login');
      },
    );
  }

  ListView _buildItemList(
      BuildContext context, WidgetRef ref, List<FoodItem> foodItems) {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final item = foodItems[index];
        return _buildItemTile(context, ref, item);
      },
    );
  }

  ListTile _buildItemTile(BuildContext context, WidgetRef ref, FoodItem item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('Expires on: ${item.expirationDate.toIso8601String()}'),
      trailing: _buildItemActions(context, ref, item),
    );
  }

  Row _buildItemActions(BuildContext context, WidgetRef ref, FoodItem item) {
    return Row(
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
            ref.read(foodItemControllerProvider.notifier).deleteItem(item.id);
          },
        ),
      ],
    );
  }
}
