import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/data/dtos/upload_img_req_dto.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/signUpUser.dart';

// ignore: must_be_immutable
class PreviewImage extends ConsumerStatefulWidget {
  String? imagePath;
  PreviewImage({super.key, required this.imagePath});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return PreviewImageState();
  }
}

class PreviewImageState extends ConsumerState<PreviewImage> {
  @override
  build(context) {
    String imagePath = widget.imagePath!;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              File file = File(imagePath);
              String fileExtension = file.path.split('.').last.toLowerCase();
              ProfilePicUploadReq profilePicture = ProfilePicUploadReq(
                  companyId: 1046, //
                  category: "picture", //
                  companyName: "Assocy", //
                  createdBy: "user", //
                  fileType: fileExtension, //
                  keyId: 15, //
                  keyValue: "person picture", //
                  path: "imagePath", //
                  unitId: '17', //
                  fileName:
                      'dummyname.jpg', //TODO: get the image name and modify here
                  uploadFile: file);
              ref.read(profilePictureProvider.notifier).state = profilePicture;
              ref.read(imageFileProvider.notifier).state = file;
              Navigator.pop(context);
              Navigator.pop(context);
              //TODO: if the above doesn't work as expected
              // Navigator.popUntil(context, ModalRoute.withName('/SignUp'));
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(
              // Icons.not_interested_sharp,
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
