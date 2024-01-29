import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/infrastructure/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostScreen extends ConsumerWidget {
  const CreatePostScreen({super.key});
  static String name = Strings.addPostScreenName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createPostForm = ref.watch(createPostFormProvider);
    final createPostNotifier = ref.read(createPostFormProvider.notifier);
    final image = createPostForm.image;
    Future<void> handleImageSelection(
      BuildContext context,
      Future<String?> Function() selectImageFunction,
    ) async {
      try {
        final photo = await selectImageFunction();
        if (photo == null) return;
        createPostNotifier.onImageChange(photo);
      } catch (e) {
        print('Catch $e');
      }
    }

    final colors = Theme.of(context).colorScheme;

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
          IconButton(
            tooltip: 'Send post',
            icon: const Icon(Icons.send_outlined),
            onPressed: createPostForm.title.isNotEmpty &&
                    createPostForm.description.isNotEmpty
                ? () {
                    createPostNotifier
                      ..onCreatedAtChange(DateTime.now())
                      ..onSubmit()
                      ..reset();
                  }
                : null,
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
                  //Clear text when post
                  PostTextFormField(
                    onChanged: createPostNotifier.onTitleChange,
                    maxLenght: 300,
                    hintText: 'Title',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  PostTextFormField(
                    onChanged: createPostNotifier.onDescriptionChange,
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
                      onTapClear: () {
                        createPostNotifier.onImageChange('');
                      },
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
