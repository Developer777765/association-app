import 'dart:io';
import 'package:excel/excel.dart' as lib1;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

final excelFileNameProvider = StateProvider<String>((ref) => 'Your excel file');

class MultipleRegisteration extends ConsumerStatefulWidget {
  const MultipleRegisteration({super.key});

  @override
  ConsumerState<MultipleRegisteration> createState() {
    return MultipleRegisterationState();
  }
}

class MultipleRegisterationState extends ConsumerState<MultipleRegisteration> {
  List<List<lib1.Data?>> records = [];
  @override
  build(context) {
    String fileName = ref.watch(excelFileNameProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload profiles'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(child: Text(fileName)),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                              colors: [Color(0xFF5189B8), Color(0xFF0D256E)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: const Center(
                          child: Text(
                        'Download',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      try {
                        pickFile();
                      } catch (ex) {
                        debugPrint('something went wrong with file picker $ex');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                              colors: [Color(0xFF5189B8), Color(0xFF0D256E)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: const Center(
                          child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              records.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 100,
                            width: 80,
                            child: Card(
                              color: const Color(0xFF0D256E),
                              child: Center(
                                child: Text(
                                  '${records[index][0]!.value}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          crossAxisCount: 2,
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: Text('Upload Excel File to Preview'),
                      ),
                    ),
            ],
          ),
        ));
  }

  pickFile() async {
    List<dynamic> cellValue = [];
    // List<dynamic> records = [];
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Restrict to specific file types
      allowedExtensions: ['xls', 'xlsx'], // Allow only Excel files
      allowMultiple: false, //prevents from uploading multiple files
    );
    if (pickedFile != null) {
      Uint8List? bytes;

      if (kIsWeb) {
        // For web, use the `bytes` property directly
        bytes = pickedFile.files.single.bytes;
      } else {
        // For mobile and desktop, use the `path` to read file content
        String? path = pickedFile.files.single.path;
        if (path != null) {
          bytes = File(path).readAsBytesSync();
        }
      }
      ref.read(excelFileNameProvider.notifier).state =
      
          pickedFile.files.single.name.isNotEmpty
              ? pickedFile.files.single.name
              : 'Your excel file';
      if (bytes != null) {
        lib1.Excel excel = lib1.Excel.decodeBytes(bytes);
        for (var table in excel.tables.keys) {
          // make the first row which contains titles of each columns in the table to skip.
          for (var row in excel.tables[table]!.rows.skip(1)) {
            records.add(row);
            for (var cell in row) {
              var value = cell?.value;
              cellValue.add(value);
            }
          }
        }
        print('every record from the sheet: ${records.length}');
      } else {
        print('Failed to read file bytes');
      }
    } else {
      print('No file selected');
    }
  }
}
