import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/entities/patient.dart';

class Analysis {
  int id;
  String creationDate;
  Patient patient;
  Drug drug;
  num adminDose, finalVolume, reliquat;

  Analysis(int id, String creationDate, Patient patient, Drug drug) {
    this.id = id;
    this.creationDate = creationDate;
    this.patient = patient;
    this.drug = drug;

    calculateAdminDose();
    calculateFinalVolume();
    claculateReliquat();
    calculateMaxIntervale(250.0);
    calculateMinIntervale(250.0);
    calculatePrice();
  }

  num calculateAdminDose() {
    adminDose = patient.sc * drug.passologie;
    return adminDose;
  }

  num calculateFinalVolume() {
    finalVolume = adminDose / drug.cinit;
    return finalVolume;
  }

  num claculateReliquat() {
    reliquat = ((finalVolume / 26.3).floor() + 1) * 26.3 - finalVolume;
    return reliquat;
  }

  num calculateMaxIntervale(num volum) {
    return drug.cmin * volum;
  }

  num calculateMinIntervale(num volum) {
    return drug.cmin * volum;
  }

  num calculatePrice() {
    return 0.0;
  }
}
