import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:blogify/features/post/presentation/providers/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createPostFormProvider =
    StateNotifierProvider.autoDispose<CreatePostNotifier, CreatePostState>(
        (ref) {
  final createPostCallback = ref.watch(postProvider.notifier).publish;
  return CreatePostNotifier(createPostCallback: createPostCallback);
});

class CreatePostNotifier extends StateNotifier<CreatePostState> {
  final Function(PostEntity) createPostCallback;

  CreatePostNotifier({
    required this.createPostCallback,
  }) : super(CreatePostState());

  void onTitleChange(String title) {
    state = state.copyWith(
      title: title,
    );
  }

  void onDescriptionChange(String description) {
    state = state.copyWith(
      description: description,
    );
  }

  void onImageChange(String image) {
    state = state.copyWith(
      image: image,
    );
  }

  void onCreatedAtChange(DateTime createdAt) {
    state = state.copyWith(
      createdAt: createdAt,
    );
  }

  Future<void> onSubmit() async {
    //login firebase working
    await createPostCallback(
      PostEntity(
        title: state.title,
        description: state.description,
        edited: false,
        createdAt: state.createdAt,
        image: state.image,
      ),
    );
  }

  void reset() {
    state = state.copyWith(
      title: '',
      description: '',
      image: '',
    );
  }

}

class CreatePostState {
  final bool isPosting;
  final bool isFormPosted;
  final String title;
  final String description;
  final String image;
  final DateTime createdAt;

  CreatePostState({
        DateTime? createdAt,
    this.isPosting = false,
    this.isFormPosted = false,
    this.title = '',
    this.description = '',
    this.image = '',

  }) : createdAt = createdAt ?? DateTime.now();

  CreatePostState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    String? title,
    String? description,
    String? image,
    DateTime? createdAt,
  }) =>
      CreatePostState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  String toString() {
    return '''
CreatePostFormState: 
  isPosting: $isPosting
  isFormPosted: $isFormPosted
  title: $title
  description: $description
  image: $image
  createdAt: $createdAt
''';
  }
}
