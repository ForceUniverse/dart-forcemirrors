part of dart_force_mirrors_lib;

class MetaDataValue<T> {
  
  Symbol memberName;
  InstanceMirror instanceMirror;
  DeclarationMirror _dclMirror;
  T object;
  
  MetaDataValue(this.object, this._dclMirror, this.memberName, this.instanceMirror);
  
  InstanceMirror invoke(List positionalArguments) {
     return instanceMirror.invoke(memberName, positionalArguments);
  }
  
  String get name => MirrorSystem.getName(memberName);
  
  List<ParameterMirror> get parameters { 
    if (this._dclMirror is MethodMirror) {
      MethodMirror mm = this._dclMirror;
      return mm.parameters;
    }
    return new List<ParameterMirror>();
  }

  List<Object> getOtherMetadata(Type type) {
    List<Object> objects = new List<Object>();
    for (InstanceMirror im in _dclMirror.metadata) {
      if (!(im.type is T) && im.hasReflectee) {
        objects.add(im.reflectee);
      }
    }
    return objects;
  }
  
  String toString() => "$object - $memberName";
  
}