import 'dart:io';


import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManager {
  static FileManager _instance;

  FileManager._internal() {
    _instance = this;
  }

  var fileText = "";
  var cipherText="";

  factory FileManager() => _instance ?? FileManager._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<bool> saveFile({plainText : String ,cipherText: String , filename : String}) async {
    fileText=plainText;
    Directory directory;
    if(Platform.isAndroid){
      if(await _requestPermisiion(Permission.storage)){
        directory = await getExternalStorageDirectory();
        print(directory.path);
        
        String newPath = ""; 
        List<String> folders = directory.path.split("/");
        for(int x =1; x<folders.length;x++){
          String folder = folders[x];
          if(folder !="Android"){
            newPath +="/"+folder;
          }
          else{
            break;
          }
        }
        newPath = newPath+"/ciperProject";
        directory = Directory(newPath);
        print(directory.path);
      }
      else{
        return false;
      }
      
    } //platform.android
    else{

    }
     
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File savedFile = File(directory.path + "/$filename");
        savedFile.writeAsString(plainText);
        return true;
      }

  return false; 
  }
    Future<bool> saveCipherFile({cipherText: String , filename : String}) async {
    this.cipherText=cipherText;
    Directory directory;
    if(Platform.isAndroid){
      if(await _requestPermisiion(Permission.storage)){
        directory = await getExternalStorageDirectory();
        print(directory.path);
        
        String newPath = ""; 
        List<String> folders = directory.path.split("/");
        for(int x =1; x<folders.length;x++){
          String folder = folders[x];
          if(folder !="Android"){
            newPath +="/"+folder;
          }
          else{
            break;
          }
        }
        newPath = newPath+"/ciperProject";
        directory = Directory(newPath);
        print(directory.path);
      }
      else{
        return false;
      }
      
    } //platform.android
    else{

    }
     
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File savedFile = File(directory.path + "/$filename");
        savedFile.writeAsString(cipherText);
        return true;
      }

  return false; 
  }

  Future<bool> _requestPermisiion(Permission permission)async{
    if(await permission.isGranted) {
      return true ;
    } else{
      var result = await permission.request();
      if(result == PermissionStatus.granted)
      return true; 
      else
      return false;
    }
  }

  Future<File> get _file async {
    final String path = await _directoryPath;
    print(path);
    return File('$path/exprement.txt');
    
  }
 
  Future<String> readTextFile() async {
    String fileContent = 'Cheetah Coding';

    File file = await _file;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }

    return fileContent;
  }

  writeTextFile({text : String}) async {
    

    File file = await _file;
    await file.writeAsString(text);
  }

}