import 'package:flutter/material.dart';
import 'package:global_state_manage/list_map_provider.dart';
import 'package:provider/provider.dart';

class AddDataPage extends StatelessWidget {
  const AddDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD DATA"),
      ),
      body: Center(
        child: Consumer<ListMapProvider>(
          builder: (ctx, provider, child) {
            return IconButton(
              onPressed: () {
                ctx.read<ListMapProvider>().addData(
                    {
                      "Name" : "Global State Manage",
                      "Mobile": "8888888888"
                    }
                );
              },
              icon: Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}
