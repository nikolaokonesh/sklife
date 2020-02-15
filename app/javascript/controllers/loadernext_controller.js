import { Controller } from "stimulus";

export default class extends Controller {
  next() {
    var loaderpage = document.querySelector("#loaderpage")
    loaderpage.classList.remove('flash-hidden')
  }
}
