//Sample Code: Layout Demostration

import 'package:rikulo/view.dart';

void main() {
  final mainView = new View()
    ..addToDocument()
    ..style.backgroundColor = "#cca";

  View view = new View();
  view.style.backgroundColor = "#ddb";
  view.profile.anchor = "parent";
  view.profile.location = "center center";
  view.profile.width = "70%";
  view.profile.height = "80%";
  mainView.addChild(view);

  //1. first level dependence
  for (final String loc in [
  "north start", "north center", "north end",
  "south start", "south center", "south end",
  "west start", "west center", "west end",
  "east start", "east center", "east end",
  "top left", "top center", "top right",
  "center left", "center center", "center right",
  "bottom left", "bottom center", "bottom right"]) {
    TextView txt = new TextView(loc);
    txt.style.border = "1px solid #555";
    txt.profile.anchorView = view;
    txt.profile.location = loc;
    mainView.addChild(txt);
  }

  //2. second level dependence
  TextView txt = new TextView("north start");
  txt.style.border = "1px solid red";
  txt.profile.anchorView = mainView.lastChild;
  txt.profile.location = "north start";
  txt.profile.width = "flex";
  mainView.addChild(txt);
}
