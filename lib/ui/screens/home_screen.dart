import 'package:authorised_image_picker/providers/image_list_provider.dart';
import 'package:authorised_image_picker/ui/widgets/common_button.dart';
import 'package:authorised_image_picker/ui/widgets/image_item_widget.dart';
import 'package:authorised_image_picker/ui/widgets/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String id = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarTitle: 'Images',

      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              padding: EdgeInsets.zero,

              itemCount: ref.watch(imageListProvider).value?.length ?? 0,
              controller: _scrollController
                ..addListener(() async {
                  if (_scrollController.position.atEdge) {
                    bool isTop = _scrollController.position.pixels == 0;
                    if (!isTop) {
                      await ref.watch(imageListProvider.notifier).loadImages(isNext: true);
                    }
                  }
                }),
              itemBuilder: (ctx, i) {
                return ImageItemWidget(details: ref.watch(imageListProvider).value![i]);
              },
            ),
          ),
          if (ref.watch(imageListProvider).isLoading) Center(child: CircularProgressIndicator()),
          Divider(),
          CommonButton(
            label: 'Load from gallery',
            loading: false,
            onTap: () async {
              await ref.read(imageListProvider.notifier).pickImage();
            },
          ),
        ],
      ),
    );
  }
}
