import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["opencomment"]

  connect() {
    setTimeout(() => this.opencommentTarget.click(), 500 )
  }

}
