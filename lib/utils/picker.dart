import 'package:image_picker/image_picker.dart';

pickImage() async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
  if (file != null) {
    return file.readAsBytes();
  }
}
