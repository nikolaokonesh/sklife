import { Controller } from "stimulus";

export default class extends Controller {
  next() {
    var loaderpage = document.querySelector("#hardloaderpage")
    loaderpage.classList.remove('flash-hidden')
  }
}
