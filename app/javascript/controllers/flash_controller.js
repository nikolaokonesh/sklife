import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["hidden"]

  connect() {
    setTimeout(() => this.hiddenTarget.classList.add('flash-hidden'), 5000 )
  }

}
