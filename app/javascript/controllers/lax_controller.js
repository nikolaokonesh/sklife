import lax from 'lax.js'

function laxxx(){
  lax.setup() // init
  const updateLax = () => {
    Turbolinks.clearCache()
    lax.update(window.scrollY)
    window.requestAnimationFrame(updateLax)
  }
  window.requestAnimationFrame(updateLax)
}

document.addEventListener(
  'turbolinks:load',
  () => laxxx(),
  {
    once: true,
  },
);

// Called after every non-initial page load
document.addEventListener('turbolinks:render', () =>
  laxxx()
);
