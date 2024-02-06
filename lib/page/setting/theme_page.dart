import 'dart:io';

import 'package:daily_plan/widget/setting_item_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> with AutomaticKeepAliveClientMixin{

 int selectIndex = 0;
 File? imgFile;

 _pickBgImage()async{
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if(result != null){
    File file = File(result.files.single.path!);
    setState(() {
      imgFile = file;
    });
  }
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
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black38,
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
                        }, child: const Text('默认',style: TextStyle(color: Colors.white),),),
                        CheckboxMenuButton(value: selectIndex == 1, onChanged: (value){
                          setState(() {
                            selectIndex = 1;
                          });
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
