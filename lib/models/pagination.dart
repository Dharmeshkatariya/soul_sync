class Pagination {
  int page = 1;
  int perPage = 10;
  int total = 0;
  bool more = false;

  Pagination();

  Pagination.fromJson(Map<String, dynamic> json) {
    if (json['page'] is String) {
      page = int.tryParse(json['page']) ?? 1;
    } else {
      page = json['page'] ?? 1;
    }

    if (json['per_page'] is String) {
      perPage = int.tryParse(json['per_page']) ?? 10;
    } else {
      perPage = json['per_page'] ?? 10;
    }
    total = json['total'] ?? 0;
    more = json['more'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pages'] = page;
    _data['per_page'] = perPage;
    _data['total'] = total;
    _data['more'] = more;
    return _data;
  }
}
