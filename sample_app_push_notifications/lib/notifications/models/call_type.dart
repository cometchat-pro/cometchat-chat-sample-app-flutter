enum CallType{
  audio("audio") , video("video"),
  none(null);

  const CallType(this.value);
  final String? value;

  @override
  String toString() => value ?? "";

  static CallType? fromValue(String? value) {
    for (final option in CallType.values) {
      if (option.value == value) {
        return option;
      }
    }
    return null;
  }
}