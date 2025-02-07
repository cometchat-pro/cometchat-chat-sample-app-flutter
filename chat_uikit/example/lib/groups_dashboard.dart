import 'package:flutter/material.dart';
import 'package:master_app/group_members/group_members_dashboard.dart';
import 'package:master_app/groups/groups_module.dart';

class GroupsDashboard extends StatelessWidget {
  const GroupsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 10, 2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "Groups",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // WidgetCard(
              //   widgets: moduleList,
              // ),
              const GroupsModule(),
              const GroupMembersModule(),

            ],
          ),
        ),
      ),
    );
  }
}
