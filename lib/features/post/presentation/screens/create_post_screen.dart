import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/infrastructure/index.dart';
import 'package:flutter/material.dart';
//import 'package:timeago/timeago.dart' as timeago;

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});
  static String name = Strings.addPostScreenName;

  @override
  Widget build(BuildContext context) {
    Future<void> handleImageSelection(
      BuildContext context,
      Future<String?> Function() selectImageFunction,
    ) async {
      try {
        final photo = await selectImageFunction();
        if (photo == null) return;
        print('Photo $photo');
        //  userEditNotifier.onImageChange(photo);
      } catch (e) {
        print('Catch $e');
        //  ref.read(userProvider.notifier)
        // .setError('photo-could-not-be-selected');
      }
    }

    //print(' ${timeago.format(threeWeeksAgo)}');
    final colors = Theme.of(context).colorScheme;
    //final size = MediaQuery.of(context).size;
    const image =
        'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FofaCrM?alt=media&token=881fe538-e0a8-48f1-80b4-62270c23360d';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create post'),
        actions: [
          IconButton(
            tooltip: 'Select photo',
            icon: const Icon(Icons.image_outlined),
            onPressed: () async {
              await handleImageSelection(context, () async {
                return CameraGalleryServicesImpl().selectPhoto();
              });
            },
          ),
          IconButton(
            tooltip: 'Take photo',
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () async {
              await handleImageSelection(context, () async {
                return CameraGalleryServicesImpl().takePhoto();
              });
            },
          ),
          const IconButton(
            tooltip: 'Send post',
            icon: Icon(Icons.send_outlined),
            //Sends activates when have title and description
            onPressed: null,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const PostTextFormField(
                    maxLenght: 300,
                    hintText: 'Title',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  const PostTextFormField(
                    maxLenght: 1000,
                    hintText: 'Add a description',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 12),
                  if (image.isNotEmpty)
                    ImagePost(
                      colors: colors,
                      image: image,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
