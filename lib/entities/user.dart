class User{
  int id;
  String username,password;

  User({this.id,this.username,this.password});


  bool login(String username,String password){
    if(this.username==username && this.password==password){
      return true;
    }else{
      return false;
    }
  }

  bool signup(){
    //TODO signup
  }

}