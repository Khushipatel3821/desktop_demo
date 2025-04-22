import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:global_state_manage/add_data_page.dart';
import 'package:global_state_manage/list_map_provider.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: Consumer<ListMapProvider>(
        builder: (mContext, provider, child) {
          var allData = mContext.watch<ListMapProvider>().getData();
          return allData.isNotEmpty
              ? ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text("${allData[index]["Name"]}"),
                      subtitle: Text("${allData[index]["Mobile"]}"),
                      trailing: SizedBox(
                        width: 80,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    mContext.read<ListMapProvider>().updateData({
                                      "Name": "Global State Manage Update",
                                      "Mobile": "7777777777"
                                    }, index);
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    provider.deleteData(index);
                                  }, icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("No Data Found"),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (mContext) => AddDataPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
