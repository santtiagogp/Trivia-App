dynamic getVal(Map<String, dynamic> map, String val) {

  dynamic selectedValue;

  map.forEach((key, value){
    if(val == key) {
      selectedValue = value;
    }
  });

  return selectedValue;
}