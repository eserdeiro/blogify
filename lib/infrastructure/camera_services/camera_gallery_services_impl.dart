import 'package:blogify/infrastructure/camera_services/camera_gallery_services.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryServicesImpl extends CameraGalleryService {
  final ImagePicker picker = ImagePicker();
  @override
  Future<String?> selectPhoto() async {
    final photo = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (photo == null) return null;
    return photo.path;
  }

  @override
  Future<String?> takephoto() async {
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      preferredCameraDevice: CameraDevice.front,
    );
    if (photo == null) return null;
    return photo.path;
  }
}
