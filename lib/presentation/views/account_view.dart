import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/features/post/presentation/providers/post_provider.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  AccountViewState createState() => AccountViewState();
}

String username = 'unkwnown';
String name = 'unkwnown';
String lastname = 'unkwnown';
String email = 'unkwnown';
String image = '';
String id = '';
List<PostEntity> posts = [];
late TextEditingController nameController;
late TextEditingController lastnameController;
late TextEditingController usernameController;
late TextEditingController emailController;
late TextEditingController imageController;

class AccountViewState extends ConsumerState<AccountView> {
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    lastnameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    imageController = TextEditingController();
    final BuildContext currentContext = context;
    Future.delayed(Duration.zero, () {
      if (mounted) {
        try {
          authUserId(currentContext);
        } catch (e) {
          print('Error en authUserUid ${e.toString()}');
        }
      }
    });
  }

  Future<void> authUserId(BuildContext currentContext) async {
    final userIdResource =
        await ref.read(userProvider.notifier).getCurrentUserId();
    if (userIdResource is Success<String>) {
      final currentUserId = userIdResource.data;
      ref.read(userProvider.notifier).getUserById(currentUserId).listen(
        (result) {
          if (result is Success<UserEntity>) {
            if (mounted) {
              setState(() {
                final resultData = result.data;
                username = resultData.username;
                name = resultData.name;
                lastname = resultData.lastname;
                email = resultData.email;
                image = resultData.image;
                id = resultData.id;

                nameController.text = name;
                lastnameController.text = lastname;
                usernameController.text = username;
                emailController.text = email;
                imageController.text = image;
              });
            }
          } else if (result is Error<dynamic>) {
            showSnackBar(context, (result as Error).getErrorMessage());
          }
        },
      );
      ref.read(postProvider.notifier).getAllPostsByUserId(currentUserId).listen(
        (result) {
          if (result is Success<List<PostEntity>>) {
            if (mounted) {
              setState(() {
                final resultData = result.data;
                posts = resultData;
              });
            }
          } else if (result is Error<dynamic>) {
            showSnackBar(context, (result as Error).getErrorMessage());
          }
        },
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Tooltip(
            message: 'Log out',
            child: IconButton(
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                ref.watch(authProvider.notifier).logout().then((_) {
                  context.go(Strings.loginUrl);
                });
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name $lastname',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '$username ( $email )',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileImage(
                    height: 70,
                    width: 70,
                    borderRadius: 70,
                    urlFileImage: image,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: CustomElevatedButton(
                          text: 'Edit profile',
                          onPressed: () => context.push(Strings.accountEditUrl),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: CustomElevatedButton(text: 'Share profile'),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              if (posts.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final postIndex = posts.reversed.toList()[index];
                      return PostContent(
                        profileUsername: username,
                        createdAt: timeago.format(postIndex.createdAt),
                        title: postIndex.title,
                        description: postIndex.description,
                        profileImage: image,
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
