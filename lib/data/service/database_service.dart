import 'dart:io';
import 'package:necmoney/data/model/push_notification_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {

  DataBaseService._privateConstructor();

  static final DataBaseService instance = DataBaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database  ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentDirectory = await getApplicationSupportDirectory();
    String path = join(documentDirectory.path, 'fcm.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }


  Future _onCreate(Database db, int version)async{
    await db.execute("""
      CREATE TABLE unreadFCM(
        id INTEGER PRIMARY KEY,
        messageId TEXT,
        title TEXT,
        body TEXT,
        sendTime TEXT,
        imageUrl TEXT
      )"""
    );
    await db.execute("""
      CREATE TABLE readFCM(
        id INTEGER PRIMARY KEY,
        messageId TEXT,
        title TEXT,
        body TEXT,
        sendTime TEXT,
        imageUrl TEXT
      )"""
    );
  }

  Future<int> addUnReadFCM(PushNotificationModel pushNotificationModel)async{
    Database db = await instance.database;
    return await db.insert('unreadFCM', pushNotificationModel.toJson());
  }


  Future<int> addReadFCM(PushNotificationModel pushNotificationModel)async{
    Database db = await instance.database;
    return await db.insert('readFCM', pushNotificationModel.toJson());
  }


  Future<List<PushNotificationModel>> getUnReadFCM()async{
    Database db = await instance.database;
    var fcm = await db.query('unreadFCM', orderBy: "id");
    List<PushNotificationModel> _fcm = fcm.isNotEmpty ? fcm.map((fcm) => PushNotificationModel.fromJson(fcm)).toList() : [];
    return _fcm;
  }


  Future<List<PushNotificationModel>> getReadFCM()async{
    Database db = await instance.database;
    var fcm = await db.query('readFCM', orderBy: "id");
    List<PushNotificationModel> _fcm = fcm.isNotEmpty ? fcm.map((fcm) => PushNotificationModel.fromJson(fcm)).toList() : [];
    return _fcm;
  }


  Future deleteUnReadFCMbyID(int? id)async{
    Database db = await instance.database;
    return await db.delete("unreadFCM", where: 'id=?', whereArgs: [id]);
  }

  Future deleteUnreadFCM()async{
    Database db = await instance.database;
    return await db.rawDelete("Delete from unreadFCM");
  }


  Future deleteReadFCMbyID(int? id)async{
    Database db = await instance.database;
    return await db.delete("readFCM", where: 'id=?', whereArgs: [id]);
  }

  Future deleteReadFCM()async{
    Database db = await instance.database;
    return await db.rawDelete("Delete from readFCM");
  }


}