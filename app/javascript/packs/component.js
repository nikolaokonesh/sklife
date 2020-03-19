require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("trix")
require("@rails/actiontext")
import "controllers"

require("unpoly/dist/unpoly")

up.compiler('.spinner', function(element) {
  function show() { element.style.display = 'block' }
  function hide() { element.style.display = 'none' }
  up.on('up:proxy:slow', show)
  up.on('up:proxy:recover', hide)
  hide()
})
