import 'package:blogify/config/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});
  static String name = Strings.addPostScreenName;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create post'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLines: null,
                    maxLength: 300,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Title',
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextFormField(
                    maxLength: 1000,
                    maxLines: null,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Text on body',
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox.fromSize(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          child: ImageViewer(
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FofaCrM?alt=media&token=881fe538-e0a8-48f1-80b4-62270c23360d',
                            ),
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(12),
                        child: ClipOval(
                          child: Material(
                            color: colors.background,
                            child: const InkWell(
                              //onTap: () => Navigator.of(context).pop(),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(Icons.clear_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: ColoredBox(
          //     color: colors.background,
          //     child: const Padding(
          //       padding: EdgeInsets.symmetric(vertical: 8),
          //       child: Column(
          //         children: [
          //           Text('¿What do you want to add?'),
          //           SizedBox(height: 12),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               ClipOval(
          //                 child: Material(
          //                   color: Color(0xFF2F2C3F),
          //                   child: InkWell(
          //                     //onTap: () => Navigator.of(context).pop(),
          //                     child: SizedBox(
          //                       width: 50,
          //                       height: 50,
          //                       child: Icon(Icons.play_arrow_outlined),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(width: 32),
          //               ClipOval(
          //                 child: Material(
          //                   color: Color(0xFF2F2C3F),
          //                   child: InkWell(
          //                     //onTap: () => Navigator.of(context).pop(),
          //                     child: SizedBox(
          //                       width: 50,
          //                       height: 50,
          //                       child: Icon(Icons.image_outlined),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(width: 32),
          //               ClipOval(
          //                 child: Material(
          //                   color: Color(0xFF2F2C3F),
          //                   child: InkWell(
          //                     //onTap: () => Navigator.of(context).pop(),
          //                     child: SizedBox(
          //                       width: 50,
          //                       height: 50,
          //                       child: Icon(Icons.link_outlined),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
