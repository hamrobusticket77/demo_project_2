
// class Photo {
//   final String? id;
//   final String name;
//   final String type;
//   final String mimeType;
//   final String path;
//   Photo({
//     required this.id,
//     // this.createdAt,
//     // this.updatedAt,
//     // this.deletedAt,
//     required this.name,
//     required this.type,
//     required this.mimeType,
//     required this.path,
//   });

//   Photo copyWith({
//     String? id,
//     String? createdAt,
//     String? updatedAt,
//     String? deletedAt,
//     String? name,
//     String? type,
//     String? mimeType,
//     String? path,
//   }) {
//     return Photo(
//       id: id ?? this.id,
//       // createdAt: createdAt ?? this.createdAt,
//       // updatedAt: updatedAt ?? this.updatedAt,
//       // deletedAt: deletedAt ?? this.deletedAt,
//       name: name ?? this.name,
//       type: type ?? this.type,
//       mimeType: mimeType ?? this.mimeType,
//       path: path ?? this.path,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'id': id,
//       // 'createdAt': createdAt,
//       // 'updatedAt': updatedAt,
//       // 'deletedAt': deletedAt,
//       'name': name,
//       'type': type,
//       'mimeType': mimeType,
//       'path': path,
//     };
//   }

//   Map<String, dynamic> toJsonForUpdateBusiness() {
//     return <String, dynamic>{
//       'name': name,
//       'type': type,
//       'mimeType': mimeType,
//     };
//   }

//   factory Photo.fromJson(Map<String, dynamic> json) {
//     return Photo(
//       id: json['id'],
//       // createdAt: json['createdAt'],
//       // updatedAt: json['updatedAt'],
//       // deletedAt: json['deletedAt'],
//       name: json['name'] ?? "",
//       type: json['type'] ?? "",
//       mimeType: json['mimeType'] ?? "",
//       path: json['path']??'',
//     );
//   }

//   bool get isImage {
//     String extension = name.split(".").last;

//     if (extension == "jpg" || extension == "png" || extension == "jpeg") {
//       return true;
//     }
//     return false;
//   }

//   bool get isPdf {
//     String extension = name.split(".").last;

//     if (extension == "pdf") {
//       return true;
//     }
//     return false;
//   }

//   bool get isDoc {
//     String extension = name.split(".").last;

//     if (extension == "doc" || extension == "docx") {
//       return true;
//     }
//     return false;
//   }

// }