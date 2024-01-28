import 'package:flutter_riverpod/flutter_riverpod.dart';

final createPostFormProvider =
    StateNotifierProvider.autoDispose<CreatePostNotifier, CreatePostState>(
        (ref) {
  Future<void> createPostCallback(
    String title,
    String description,
    String image,
    DateTime? dateTime,
  ) async {
    // Lógica del callback
  }

  return CreatePostNotifier(
    createPostCallback: createPostCallback,
  );
});

class CreatePostNotifier extends StateNotifier<CreatePostState> {
  final Function(String, String, String, DateTime?) createPostCallback;

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
    print(state.toString());
    await createPostCallback(
      state.title,
      state.description,
      state.image,
      state.createdAt,
    );
  }

    void reset() {
    state = state.copyWith(
      title: '',
      description: '',
      image: '',
    );
  }

  // void validateEveryone() {
  //   final title = state.title;
  //   final description = state.description;
  //   final image = state.image;
  //   final createdAt = state.createdAt;

  //   state = state.copyWith(
  //     isFormPosted: true,
  //     title: title,
  //     description: description,
  //     image: image,
  //     createdAt: createdAt,
  //   );
  // }
}

class CreatePostState {
  final bool isPosting;
  final bool isFormPosted;
  final String title;
  final String description;
  final String image;
  final DateTime? createdAt;

  CreatePostState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.title = '',
    this.description = '',
    this.image = '',
    this.createdAt,
  });

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
        createdAt: createdAt,
      );

  @override
  String toString() {
    return '''
LoginFormState: 
  isPosting: $isPosting
  isFormPosted: $isFormPosted
  title: $title
  description: $description
  image: $image
  createdAt: $createdAt
''';
  }
}
