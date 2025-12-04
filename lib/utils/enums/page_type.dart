enum PageType {
  edit,
  create;

  bool get isEdit => this == edit;
  bool get isCreate => this == create;
}
