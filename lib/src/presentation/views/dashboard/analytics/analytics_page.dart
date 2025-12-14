import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/presentation/providers/category_provider/category_provider.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics")),
      body: ref
          .watch(categoryProvider)
          .when(
            data: (data) {
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        print(
                          "id: ${data[index].id}, name: ${data[index].name}",
                        );

                        return ListTile(
                          title: Text(data[index].id),
                          subtitle: Text(data[index].name),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            error: (error, stacktrace) => Text("Error"),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
