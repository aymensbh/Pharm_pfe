class Drug {
  int id, userid;
  String name, lab;
  num cinit, cmax, cmin, passologie, presentation, stability, price;

  Drug(
      {this.id,
      this.name,
      this.lab,
      this.cinit,
      this.presentation,
      this.stability,
      this.price,
      this.userid,
      this.cmax,
      this.cmin,
      this.passologie});
  //TODO get and set

  Drug.fromMap(Map<String, dynamic> map) {
    id = map["drug_id"];
    name = map["drug_name"];
    lab = map["drug_lab"];
    cinit = map["drug_cinit"];
    presentation = map["drug_presentation"];
    stability = map["drug_stability"];
    price = map["drug_price"];
    cmax = map["drug_cmax"];
    cmin = map["drug_cmin"];
    passologie = map["drug_passologie"];
    userid = map["user_id"];
  }

  Map<String, dynamic> toMap() {
    return {
      "drug_id": id,
      "drug_name": name,
      "drug_lab": lab,
      "drug_cinit": cinit,
      "drug_presentation": presentation,
      "drug_stability": stability,
      "drug_price": price,
      "drug_cmax": cmax,
      "drug_cmin": cmin,
      "drug_passologie": passologie,
      "user_id": userid
    };
  }
}
