import { Controller } from "stimulus"

export default class extends Controller {

  onCurrentController() {
    let activeLinks = this.data.get("active-on");
    return activeLinks == Appcontroller;
  }

  connect() {
    if (this.onCurrentController()) {
      this.element.classList.add("active");
    } else {
      this.element.classList.remove("active");
    }
  }

}
