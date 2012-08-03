//Sample Code: Test Log

#import('../../client/app/app.dart');
#import('../../client/view/view.dart');

class TestPopup1 extends Activity {

  void onCreate_() {
    View view = new View();
    view.classes.add("v-dialog");
    view.style.overflow = "auto";
    view.profile.text = "width: 80%; height: 80%; location: center center";

    View color = new View();
    color.style.backgroundColor = "blue";
    color.left = color.top = 100;
    color.width = 2000;
    color.height = 600;
    view.addChild(color);

    Button btn = new Button("Show Popup");
    btn.profile.anchorView = color;
    btn.profile.location = "north start";
    view.addChild(btn);

    View popup = new PopupView();
    popup.profile.anchorView = btn;
    popup.profile.location = "south start";
    popup.width = 300;
    popup.height = 200;
    popup.style.backgroundColor = "yellow";
    popup.hidden = true;
    view.addChild(popup);

    btn.on.click.add((event) {
        popup.hidden = false;
      });

    Button btn2 = new Button("Create Popup");
    btn2.profile.anchorView = btn;
    btn2.profile.location = "east start";
    btn2.on.click.add((event) {
        final pp = new PopupView();
        pp.profile.anchorView = btn2;
        pp.profile.location = "south start";
        pp.width = 200;
        pp.height = 150;
        pp.style.backgroundColor = "orange";
        pp.on.dismiss.add((e) {pp.removeFromParent();});
        view.addChild(pp, popup);
        pp.requestLayout(immediate: true);
      });
    view.addChild(btn2);

    mainView.addChild(view);
  }
}

void main() {
  new TestPopup1().run();
}
