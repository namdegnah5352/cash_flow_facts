class AccountType{

  int _id = 0;
  String _iconPath = "";
  String _typeName = "";
  
  AccountType({id, iconPath, typeName}){
    _id = id;
    _iconPath = iconPath;
    _typeName = typeName;
  }
  
  int get id => _id;
  String get iconPath => _iconPath;
  String get typeName => _typeName;
  set id(int id) => _id = id;
  set iconPath(String iconPath) => _iconPath = iconPath;
  set typeName(String typeName) => _typeName = typeName;
}