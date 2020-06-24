 class user{
  String name;
  String email;
  String pass;
  user(this.name,this.email,this.pass);
  convertToMap(){
    Map<String ,dynamic> map={
      "name":this.name,
      "email":this.email,
      'pass':this.pass,
    };
    return map;
  }


}