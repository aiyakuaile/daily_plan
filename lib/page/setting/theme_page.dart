import 'dart:io';
import 'dart:math';

import 'package:daily_plan/provider/theme_provider.dart';
import 'package:daily_plan/widget/setting_item_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> with AutomaticKeepAliveClientMixin{

 late int selectIndex = context.read<ThemeProvider>().customBackgroundImagePath.startsWith('http')?0:1;
 File? imgFile;
 String filePath = '';


 _pickBgImage()async{
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if(result != null && mounted){
    filePath = result.files.single.path!;
    final savePath = (await getApplicationSupportDirectory()).path;
    final pathEx = path.extension(filePath);
    final imagePathName = '$savePath/customImg.$pathEx';
    final tempFile = File(filePath);
    final file = await File(imagePathName).writeAsBytes(await tempFile.readAsBytes());
    filePath = file.path;
    if(mounted) context.read<ThemeProvider>().customBackgroundImagePath = file.path;
    setState(() {
      imgFile = file;
    });
  }
 }

 @override
  void initState() {
    if(selectIndex == 1){
      filePath = context.read<ThemeProvider>().customBackgroundImagePath;
      imgFile = File(filePath);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: const Text('主题设置',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(horizontal:16,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(min(0.2+context.watch<ThemeProvider>().backgroundOpacity, 1.0)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    const Text('遮罩透明度',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                    const SizedBox(width: 100),
                    Expanded(child: Slider(value: context.watch<ThemeProvider>().backgroundOpacity, onChanged: (value){
                      context.read<ThemeProvider>().backgroundOpacity = value;
                    },focusNode: FocusNode(),))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal:16,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(min(0.2+context.watch<ThemeProvider>().backgroundOpacity, 1.0)),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(children: [
                      const Text('选择背景',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      const Spacer(),
                      Row(children: [
                        CheckboxMenuButton(value: selectIndex == 0, onChanged: (value){
                          setState(() {
                            selectIndex = 0;
                          });
                          context.read<ThemeProvider>().customBackgroundImagePath = null;
                        }, child: const Text('默认',style: TextStyle(color: Colors.white),),),
                        CheckboxMenuButton(value: selectIndex == 1, onChanged: (value){
                          setState(() {
                            selectIndex = 1;
                          });
                          if(imgFile != null){
                            context.read<ThemeProvider>().customBackgroundImagePath = filePath;
                          }
                        }, child: const Text('自定义图片',style: TextStyle(color: Colors.white),),),
                      ],),
                    ],),

                    if(selectIndex == 1) GestureDetector(
                      onTap: _pickBgImage,
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: Container(
                          width: double.infinity,
                          // height: 150,
                          margin: const EdgeInsets.only(top: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            // color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),
                            image: imgFile != null ? DecorationImage(image: FileImage(imgFile!),fit: BoxFit.cover):null
                          ),
                          child: imgFile == null?const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add,size: 40,color: Colors.white,),
                              Text('选择图片',style: TextStyle(color: Colors.white),)
                            ],
                          ):null,
                        ),
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
