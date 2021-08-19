import 'inspiration_content.dart';

class CheckList implements InspirationContent {

  CheckList();

  @override
  factory CheckList.fromJson(Map<String, dynamic> _) {
    return CheckList();
  }

  String getTitle() => title;

  String title = '';
  List<CheckListItem> list = <CheckListItem>[];
}

class CheckListItem {
  String text = '';
  bool isChecked = false;
}