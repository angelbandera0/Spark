class SizesEnums {
  Map<int, String> measures = {
    0: 'Compact',
    1: 'Midsize',
    2: 'Sedan',
    3: 'Small SUV',
    4: 'SUV',
    5: 'Small Truck',
    6: 'Full-size truck'
  };

  String getValueInMap(int key) {
    var entrieList = measures.entries.toList();
    return entrieList[key].value;
  }

  int getKeyInMap(String value) {
    int key = 0;
    var entrieList = measures.entries.toList();
    entrieList.forEach((element) {
      if (element.value.trim().contains(value.trim())) {
        key = element.key;
      }
    });
    return key;
  }
}
