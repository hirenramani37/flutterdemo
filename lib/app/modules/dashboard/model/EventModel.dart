class TitleEvent {
  String title;

  TitleEvent(this.title);
}


class FetchSubmitEvent {
  FetchSubmitEvent();
}

class PageChangeEvent {
  int page;
  PageChangeEvent(this.page);
}

class KycPageChangeEvent {
  int page;
  KycPageChangeEvent(this.page);
}

class EmiValueChanges {
  double loanAmount;
  int tenureAmount;
  bool isPrivacy;
  EmiValueChanges(this.loanAmount,this.tenureAmount,this.isPrivacy);
}

class RetryEvent {
  RetryEvent();
}

class AddMoreSecurity {
  AddMoreSecurity();
}