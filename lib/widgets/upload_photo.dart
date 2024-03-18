import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/services/camera_gallery_service.dart';

class UploadPhoto extends ConsumerWidget {
  const UploadPhoto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoState = ref.watch(photoProvider);
    late ImageProvider imageProvider;
    imageProvider = FileImage(File(photoState.image));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Para terminar, por favor',
            style: TextStyle(
                color: Color(0xff5A4361),
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        const Text('Sube una fotografía tuya ',
            style: TextStyle(
                color: Color(0xff5A4361),
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 20,
        ),
        photoState.image.isEmpty
            ? Container()
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: 250,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                    placeholder: const AssetImage('assets/loaders/loading.gif'),
                  ),
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            final photoPath = await CameraGalleryService().selectPhoto();
            if (photoPath == null) return;
            ref.read(photoProvider.notifier).onImageChanged(photoPath);
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff5A4361)),
          ),
          child: const Icon(
            Icons.photo_camera,
            color: Color(0xffffffff),
          ),
        ),
        photoState.image.isEmpty
            ? Container()
            : ElevatedButton(
                onPressed: ref.read(photoProvider.notifier).onFormSubmit,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff5A4361)),
                ),
                child: const Icon(
                  Icons.navigate_next,
                  color: Color(0xffffffff),
                ),
              ),
      ],
    );
  }
}
