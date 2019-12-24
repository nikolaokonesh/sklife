import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["postErrors"]

  onPostSuccess(event) {
    this.postErrorsTarget.innerText = "";
  }

  onPostError(event) {
    let [data, status, xhr] = event.detail;
    this.postErrorsTarget.innerHTML = xhr.response;
  }
}
