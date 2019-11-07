import lax from 'lax.js'

document.addEventListener("turbolinks:load", function() {
  lax.setup()
  const updateLax = () => {
    lax.update(window.scrollY)
    window.requestAnimationFrame(updateLax)
  }
  window.requestAnimationFrame(updateLax)
})
