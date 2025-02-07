enum CallAction{
  initiated("initiated") , cancelled("cancelled") ,unanswered("unanswered") ,
  ongoing("ongoing") , rejected("rejected") , ended("ended") , busy("busy"),
  none(null);

  const CallAction(this.value);
  final String? value;

  @override
  String toString() => value ?? "";

  static CallAction? fromValue(String? value) {
    for (final option in CallAction.values) {
      if (option.value == value) {
        return option;
      }
    }
    return null;
  }
}