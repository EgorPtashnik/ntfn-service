type ExecuteActionResultType {
  Success: Boolean not null;
  MessageText: String(255) not null;
  DeleteOnReturn: Boolean not null
}

type Actor {
  Id: String(20) not null;
  DisplayText: String(120) not null;
  ImageSource: String not null;
}

