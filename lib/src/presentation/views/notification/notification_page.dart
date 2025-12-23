import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/core/config/helper/time_formater.dart';
import 'package:money_scope/src/core/storage/database/mapper/category_icon_mapper.dart';
import 'package:money_scope/src/domain/entities/notification_entity.dart';
import 'package:money_scope/src/presentation/providers/notification/notification_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:money_scope/src/presentation/views/widgets/no_data_available.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  late final PagingController<int, NotificationEntity> _pagingController =
      PagingController<int, NotificationEntity>(
        getNextPageKey: (state) =>
            state.lastPageIsEmpty ? null : state.nextIntPageKey,
        fetchPage: (pageKey) =>
            ref.read(notificationProvider.notifier).fetchData(pageKey),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: PagingListener(
        controller: _pagingController,
        builder: (context, state, fetchNextPage) {
          return PagedListView<int, NotificationEntity>(
            state: state,
            fetchNextPage: fetchNextPage,
            padding: const EdgeInsets.all(12),
            builderDelegate: PagedChildBuilderDelegate(
              animateTransitions: true,
              noItemsFoundIndicatorBuilder: (context) =>
                  Center(child: const NoDataAvailable()),
              newPageProgressIndicatorBuilder: (context) => Padding(
                padding: const EdgeInsets.all(6),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              ),
              itemBuilder: (context, notification, index) {
                return _content(theme, notification);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _content(ThemeData theme, NotificationEntity notification) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(6),
        ),
        elevation: 1,
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  spacing: 6,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(
                        notification.color,
                      ).withValues(alpha: 0.2),
                      child: Icon(
                        CategoryIconMapper.get(notification.icon),
                        color: Color(notification.color),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        spacing: 2,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            notification.message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  getDayLabel(notification.date),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.grey.shade600,
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
