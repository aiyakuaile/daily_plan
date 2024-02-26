import 'dart:io';
import 'dart:math';

import 'package:daily_plan/generated/l10n.dart';
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

class _ThemePageState extends State<ThemePage>{

 int selectIndex = 0;

 _pickBgImage()async{
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if(result != null && mounted){
    String filePath = result.files.single.path!;
    final savePath = (await getApplicationSupportDirectory()).path;
    final pathEx = path.extension(filePath);
    final imagePathName = '$savePath/customImg.$pathEx';
    final tempFile = File(filePath);
    final file = await File(imagePathName).writeAsBytes(await tempFile.readAsBytes());
    if(mounted) context.read<ThemeProvider>().customBackgroundImagePath = file.path;
  }
 }

 @override
  void initState() {
   final imgPath = context.read<ThemeProvider>().customBackgroundImagePath;
    if(imgPath == null){
      selectIndex = 0;
    }else if(imgPath.startsWith('http')){
      selectIndex = 2;
    }else{
      selectIndex = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child:  Text(S.of(context).theme_settings,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
        ),
        Container(
          constraints: const BoxConstraints(
            minWidth: 600,
            maxWidth: 600
          ),
          child: SingleChildScrollView(
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
                      Text(S.of(context).mask_opacity,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      const SizedBox(width: 100),
                      Expanded(child: Slider(value: context.watch<ThemeProvider>().backgroundOpacity, onChanged: (value){
                        context.read<ThemeProvider>().backgroundOpacity = value;
                      },focusNode: FocusNode(canRequestFocus: false),allowedInteraction: SliderInteraction.slideOnly,))
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
                         Text(S.of(context).select_bg,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                        const Spacer(),
                        Row(children: [
                          CheckboxMenuButton(focusNode: FocusNode(canRequestFocus: false),value: selectIndex == 0, onChanged: (value){
                            setState(() {
                              selectIndex = 0;
                            });
                            context.read<ThemeProvider>().customBackgroundImagePath = null;
                          }, child: Text(S.of(context).default_bg,style: const TextStyle(color: Colors.white),),),
                          CheckboxMenuButton(focusNode: FocusNode(canRequestFocus: false),value: selectIndex == 2, onChanged: (value){
                            setState(() {
                              selectIndex = 2;
                            });
                            context.read<ThemeProvider>().customBackgroundImagePath = '';
                          }, child: Text(S.of(context).bing,style: const TextStyle(color: Colors.white),),),
                          CheckboxMenuButton(focusNode: FocusNode(canRequestFocus: false),value: selectIndex == 1, onChanged: (value){
                            setState(() {
                              selectIndex = 1;
                            });
                          }, child:  Text(S.of(context).custom_bg,style: const TextStyle(color: Colors.white),),),
                        ],),
                      ],),

                      GestureDetector(
                        onTap: selectIndex == 1?_pickBgImage:null,
                        child: AspectRatio(
                          aspectRatio: 16/9,
                          child: Consumer<ThemeProvider>(builder: (_,value,child){
                            DecorationImage? decorationImage;
                            final imgPath = value.customBackgroundImagePath;
                            if(imgPath == null){
                              decorationImage = const DecorationImage(image: AssetImage('./images/ray_hennessy.jpg'), fit: BoxFit.cover);
                            }else if(imgPath.startsWith('http')){
                              decorationImage = DecorationImage(image: NetworkImage(imgPath), fit: BoxFit.cover);
                            }else{
                              decorationImage = imgPath == '' ? null:DecorationImage(image: FileImage(File(imgPath)), fit: BoxFit.cover);
                            }
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: decorationImage
                              ),
                              child: selectIndex == 1?const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add,size: 40,color: Colors.white,),
                                  Text('选择图片',style: TextStyle(color: Colors.white),)
                                ],
                              ):null,
                            );
                          })
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
