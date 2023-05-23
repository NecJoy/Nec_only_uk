


class DocumentUploadModel{

  String? ttId;
  dynamic file;

  DocumentUploadModel({
    this.ttId,
    this.file,
  });

  factory DocumentUploadModel.fromJson(Map<String ,dynamic> json) => DocumentUploadModel(
    ttId: json["ttId"],
    file:  json["file"]
  );


  Map<String, dynamic>toJson() => {
    "ttId": ttId,
    "file" : file,
  };



}