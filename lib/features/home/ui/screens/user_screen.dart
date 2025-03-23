import 'package:flutter/material.dart';
import 'package:furniture_shopping/core/constants/api_link.dart';
import 'package:get/get.dart';

import '../../../../core/class/my_services.dart';
import '../../../../core/constants/routes/AppRoute/routersName.dart';
import '../../logic/home_screen_controller.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImpl());
    final MyServices myServices = Get.find();
    final String username =
        myServices.sharedPreferences.getString('username') ?? 'No Name';
    final String email =
        myServices.sharedPreferences.getString('email') ?? 'No Email';
    final String avatarPath =
        myServices.sharedPreferences.getString('avatar') ?? '';
    final String avatarUrl = avatarPath.contains('http')
        ? avatarPath
        : "${AppLink.kBaseUrl}/$avatarPath";

    return Scaffold(
      backgroundColor: Color(0xffEFF0F2),
      appBar: AppBar(
        backgroundColor: Color(0xffEFF0F2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.black),
            onPressed: () {
              Get.find<HomePageControllerImpl>().logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            ProfileItem(
              title: "My orders",
              subtitle: "Already have 10 orders",
              onTap: () {
                Get.toNamed(AppRouter.orders);
              },
            ),
            ProfileItem(
              title: "Shipping Addresses",
              subtitle: "03 Addresses",
              onTap: () {},
            ),
            ProfileItem(
              title: "Payment Method",
              subtitle: "You have 2 cards",
              onTap: () {},
            ),
            ProfileItem(
              title: "My reviews",
              subtitle: "Reviews for 5 items",
              onTap: () {},
            ),
            ProfileItem(
              title: "Setting",
              subtitle: "Notification, Password, FAQ, Contact",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 16, color: Colors.black),
          onTap: onTap),
    );
  }
}
