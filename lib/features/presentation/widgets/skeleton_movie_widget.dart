import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonMovieWidget extends StatelessWidget {
  const SkeletonMovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _avatarsView(),
    );
  }

  Widget _avatarsView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(right: 10),
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(height: 250, width: 150),
          ),
        );
      },
    );
  }
}
