class User{

  String id,name,job,Address,image;

  User(dynamic obj)
  {id=obj['id'];
  name=obj['name'];
  job=obj['job'];
  Address=obj['Address'];
  image=obj['image'];
  }
  User.fromMap(Map<String,dynamic> data)
  {
    id=data['id'];
    name=data['name'];
    job=data['job'];
    Address=data['Address'];
    image=data['image'];
  }
  Map<String,dynamic> toMap()=>{'id':id,'name':name,'job':job,'Address':Address,'image':image};
}