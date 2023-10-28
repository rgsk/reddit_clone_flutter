import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/common/error_text.dart';
import 'package:reddit_clone_flutter/core/common/loader.dart';
import 'package:reddit_clone_flutter/core/constants/constants.dart';
import 'package:reddit_clone_flutter/features/community/controller/community_controller.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String communityName;
  const EditCommunityScreen({
    super.key,
    required this.communityName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.communityName)).when(
          data: (community) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Edit Community',
                ),
                centerTitle: false,
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Save'),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        dashPattern: [10, 4],
                        strokeCap: StrokeCap.round,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (community.banner.isEmpty ||
                                  community.banner == Constants.bannerDefault)
                              ? Center(
                                  child: Icon(Icons.camera_alt_outlined),
                                )
                              : Image.network(community.banner),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(community.avatar),
                          radius: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return ErrorText(error: error.toString());
          },
          loading: () => Loader(),
        );
  }
}
