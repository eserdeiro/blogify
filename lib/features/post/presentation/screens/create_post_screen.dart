import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/infrastructure/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});
  static String name = Strings.addPostScreenName;

  @override
  CreatePostScreenState createState() => CreatePostScreenState();
}

class CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                ? () async {
                    createPostNotifier.onCreatedAtChange(DateTime.now());
                    await createPostNotifier.onSubmit();
                    createPostNotifier.reset();

                    _titleController.clear();
                    _descriptionController.clear();
                    //After
                    // await Future.delayed(Duration.zero, () {
                    //   context.push(Strings.homeViewUrl);
                    // });
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
                    controller: _titleController,
                    onChanged: createPostNotifier.onTitleChange,
                    maxLenght: 300,
                    hintText: 'Title',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  PostTextFormField(
                    controller: _descriptionController,
                    onChanged: createPostNotifier.onDescriptionChange,
                    maxLenght: 1000,
                    hintText: 'Add a description',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 12),
                  if (image.isNotEmpty)
                    ImagePost(
                      clearButton: true,
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
