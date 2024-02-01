import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/presentation/providers/user_provider.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/features/post/presentation/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

List<PostEntity> posts = [];
List<UserEntity> users = [];
String userId = '';
String ownerPostUsernameUser = '';
String ownerPostImageUser = '';

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      if (mounted) {
        try {
          await ref.read(postProvider.notifier).getAllPosts();
          await ref.read(userProvider.notifier).getCurrentUserId();
          final userProv = await ref.watch(userProvider).user;
          if (userProv is Success<String>) {
            userId = userProv.data;
          }

          final postState = ref.watch(postProvider).post;
          if (postState != null && postState is Success) {
            //Set posts
            posts = postState.data as List<PostEntity>;
            for (final post in posts) {
              //Get users by post
              ref.read(userProvider.notifier).getUserById(post.userId!).listen(
                (result) {
                  if (mounted) {
                    if (result is Success<UserEntity>) {
                      users.add(result.data);
                    }
                  }
                },
              );
            }
          }
        } catch (e) {
          print('Error ${e.toString()}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Divider(),
              if (posts.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final postIndex = posts.toList()[index];
                      if (users.isNotEmpty && index < users.length) {
                  
                          ownerPostUsernameUser = users[index].username;
                          ownerPostImageUser = users[index].image;
                     
                      }
                      return PostContent(
                        isOwner: PostHelper.isPostCreatedByUser(
                          postIndex.userId!,
                          userId,
                        ),
                        onPressedDelete: () {
                          ref
                              .read(postProvider.notifier)
                              .deletePost(postIndex.postId!);
                        },
                        profileUsername: ownerPostUsernameUser,
                        createdAt: timeago.format(postIndex.createdAt),
                        title: postIndex.title,
                        description: postIndex.description,
                        profileImage: ownerPostImageUser,
                        image: postIndex.image,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
