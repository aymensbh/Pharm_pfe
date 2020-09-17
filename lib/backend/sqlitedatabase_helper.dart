import 'package:pharm_pfe/entities/analysis.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _db;
  static init() async {
    await openDB();
  }

  static openDB() async {
    _db = await openDatabase("pahrm.db", version: 1,
        onCreate: (db, version) async {
      await db.execute('PRAGMA foreign_keys = ON');
      await db.execute(createUserQuery);
      await db.execute(createDrugsQuery);
      await db.execute(createPatientsQuery);
      await db.execute(createPochsQuery);
    });
  }

  //user database

  static Future<int> insertUser(User user) async {
    return await _db.insert("user", user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(User user) async {
    return await _db.update(
      "user",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> loginWithUsernameAndPassword(
      {String username, String password}) async {
    return await _db.query(
      "user",
      where: "user_name = ? AND user_password = ?",
      whereArgs: [username, password],
    );
  }

  static Future<List<Map<String, dynamic>>> selectSpecificUser(
      int userid) async {
    return await _db.query(
      "user",
      where: "user_id = ?",
      whereArgs: [userid],
      distinct: true,
    );
  }

  //patient

  static Future<int> insertPatient(Patient patient) async {
    return await _db.insert(
      "patient",
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updatePatient(Patient patient) async {
    return await _db.update(
      "patient",
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'patient_id = ?',
      whereArgs: [patient.id],
    );
  }

  static Future<int> deletePatient(int id) async {
    return await _db
        .delete("patient", where: "patient_id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> selectPatient(int userid) async {
    return await _db.query(
      "patient",
      where: "user_id = ?",
      whereArgs: [userid],
      distinct: true,
    );
  }

  static Future<List<Map<String, dynamic>>> selectSpecificPatient(
      int patientId) async {
    return await _db.query(
      "patient",
      where: "patient_id = ?",
      whereArgs: [patientId],
      distinct: true,
    );
  }

  //drugs

  static Future<int> insertDrug(Drug drug) async {
    return await _db.insert(
      "drug",
      drug.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateDrug(Drug drug) async {
    return await _db.update(
      "drug",
      drug.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'drug_id = ?',
      whereArgs: [drug.id],
    );
  }

  static Future<int> deleteDrug(int id) async {
    return await _db.delete("drug", where: "drug_id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> selectDrug(int userid) async {
    return await _db.query(
      "drug",
      where: "user_id = ?",
      whereArgs: [userid],
      distinct: true,
    );
  }

  static Future<List<Map<String, dynamic>>> selectSpecificDrug(
      int drugId) async {
    return await _db.query(
      "drug",
      where: "drug_id = ?",
      whereArgs: [drugId],
      distinct: true,
    );
  }

  //TODO: poche

  static Future<int> insertPoch(Analysis analysis) async {
    return await _db.insert(
      "poch",
      analysis.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updatePoch(Analysis analysis) async {
    return await _db.update(
      "poch",
      analysis.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'poch_id = ?',
      whereArgs: [analysis.id],
    );
  }

  static Future<int> deletePoch(int id) async {
    return await _db.delete("poch", where: "poch_id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> selectPoch(int userid) async {
    return await _db.query(
      "poch",
      where: "user_id = ?",
      whereArgs: [userid],
      distinct: true,
    );
  }

  static String createUserQuery = """
  CREATE TABLE IF NOT EXISTS user(
    "user_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "user_name"	TEXT UNIQUE,
    "user_password"	TEXT
    );
  """;

  static String createPatientsQuery = """
  CREATE TABLE IF NOT EXISTS patient(
    "patient_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "patient_fullname"	TEXT,
    "patient_doctor"	TEXT,
    "patient_birthdate"	TEXT,
    "patient_sc" REAL,
    "patient_address" TEXT,
    "patient_phone" TEXT,
    "user_id"	INTEGER,
    FOREIGN KEY("user_id") REFERENCES "user"("user_id") ON DELETE CASCADE
  );
  """;

  static String createDrugsQuery = """
  CREATE TABLE IF NOT EXISTS drug(
    "drug_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "drug_name"	TEXT,
    "drug_lab"	TEXT,
    "drug_cinit"	REAL,
    "drug_presentation" REAL,
    "drug_stability" REAL,
    "drug_price" REAL,
    "drug_cmax" REAL,
    "drug_cmin" REAL,
    "drug_passologie" REAL,
    "user_id"	INTEGER,
    FOREIGN KEY("user_id") REFERENCES "user"("user_id") ON DELETE CASCADE
    );
  """;

  static String createPochsQuery = """
  CREATE TABLE IF NOT EXISTS poch(
    "poch_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "poch_creationdate" TEXT,
    "poch_adminDose" REAL,
    "poch_finalVolume" REAL,
    "poch_price" REAL,
    "poch_maxintervale" REAL,
    "poch_minintervale" REAL,
    "poch_reliquat" REAL,
    "drug_id" INTEGER,
    "patient_id" INTEGER,
    "user_id" INTEGER,
    FOREIGN KEY("drug_id") REFERENCES "drug"("drug_id") ON DELETE CASCADE,
    FOREIGN KEY("user_id") REFERENCES "user"("user_id") ON DELETE CASCADE,
    FOREIGN KEY("patient_id") REFERENCES "patient"("patient_id") ON DELETE CASCADE
  );
  """;
}
