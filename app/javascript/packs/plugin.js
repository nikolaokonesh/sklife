import "controllers"

document.addEventListener("turbolinks:request-start", function(event) {
  var loaderpage = document.querySelector("#loaderpage")
  loaderpage.classList.remove('flash-hidden')
})
document.addEventListener("turbolinks:request-end", function(event) {
  var loaderpage = document.querySelector("#loaderpage")
  loaderpage.classList.add('flash-hidden')
})
