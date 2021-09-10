import './screens/home_screen_tests.dart' as home_screen;
import './screens/details_screen_tests.dart' as details_screen;
import './screens/add_edit_screen_tests.dart' as add_edit_screen;
import './widgets/birthday_card_content_tests.dart' as birthday_card_content;
import './widgets/bullet_list_card_content_tests.dart'
    as bullet_list_card_content;
import './widgets/note_card_content_tests.dart' as note_card_content;
import './widgets/recipe_card_content_tests.dart' as recipe_card_content;

void main() {
  // screens
  home_screen.main();
  details_screen.main();
  add_edit_screen.main();

  // widgets
  birthday_card_content.main();
  bullet_list_card_content.main();
  note_card_content.main();
  recipe_card_content.main();
}
