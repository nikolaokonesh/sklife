// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
// require("channels")
window.Rails = Rails

require("trix/dist/trix.css")
require("trix")
require("@rails/actiontext")
require("stylesheets/application.scss")
require("photoswipe/src/css/main.scss")
require("photoswipe/src/css/default-skin/default-skin.scss")
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"


// const Uppy = require('@uppy/core')
// const Dashboard = require('@uppy/dashboard')
// const ActiveStorageUpload = require('@excid3/uppy-activestorage-upload')

// document.addEventListener('turbolinks:load', () => {
//   document.querySelectorAll('[data-uppy]').forEach(element => setupUppy(element))
// })

// function setupUppy(element) {
//   let trigger = element.querySelector('[data-behavior="uppy-trigger"]')
//   let form = element.closest('form')
//   let direct_upload_url = document.querySelector("meta[name='direct-upload-url']").getAttribute("content")
//   let field_name = element.dataset.uppy

//   trigger.addEventListener("click", (event) => event.preventDefault())

//   let uppy = Uppy({
//     autoProceed: true,
//     allowMultipleUploads: false,
//     logger: Uppy.debugLogger
//   })

//   uppy.use(ActiveStorageUpload, {
//     directUploadUrl: direct_upload_url
//   })

//   uppy.use(Dashboard, {
//     trigger: trigger,
//     closeAfterFinish: true,
//     locale: {
//       strings: {
//         closeModal: 'Закрыть окно',
//         // addMoreFiles: 'Add more files',
//         // importFrom: 'Import from %{name}',
//         // dashboardWindowTitle: 'Uppy Dashboard Window (Press escape to close)',
//         // dashboardTitle: 'Uppy Dashboard',
//         // copyLinkToClipboardSuccess: 'Link copied to clipboard.',
//         // copyLinkToClipboardFallback: 'Copy the URL below',
//         // copyLink: 'Copy link',
//         // fileSource: 'File source: %{name}',
//         // done: 'Выполнено',
//         // removeFile: 'Remove file',
//         // editFile: 'Edit file',
//         // editing: 'Editing %{file}',
//         // edit: 'Edit',
//         // finishEditingFile: 'Finish editing file',
//         // myDevice: 'My Device',
//         // dropPasteImport: 'Drop files here, paste, %{browse} or import from',
//         dropPaste: 'Перетащите фотографию сюда, или выберите из %{browse}',
//         browse: 'Папки',
//         // uploadComplete: 'Upload complete',
//         // resumeUpload: 'Resume upload',
//         // pauseUpload: 'Pause upload',
//         // retryUpload: 'Retry upload',
//         // xFilesSelected: {
//           // 0: '%{smart_count} file selected',
//           // 1: '%{smart_count} files selected'
//         // },
//         // uploading: 'Uploading',
//         // complete: 'Complete'
//       }
//     }
//   })

//   uppy.on('complete', (result) => {
//     // Rails.ajax
//     // or show a preview:
//     element.querySelectorAll('[data-pending-upload]').forEach(element => element.parentNode.removeChild(element))

//     result.successful.forEach(file => {
//       appendUploadedFile(element, file, field_name)
//       setPreview(element, file)
//     })

//     uppy.reset()
//   })
// }

// function appendUploadedFile(element, file, field_name) {
//   const hiddenField = document.createElement('input')

//   hiddenField.setAttribute('type', 'hidden')
//   hiddenField.setAttribute('name', field_name)
//   hiddenField.setAttribute('data-pending-upload', true)
//   hiddenField.setAttribute('value', file.response.signed_id)

//   element.appendChild(hiddenField)
// }

// function setPreview(element, file) {
//   let preview = element.querySelector('[data-behavior="uppy-preview"]')
//   if (preview) {
//     let src = (file.preview) ? file.preview : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSpj0DBTVsaja01_xWh37bcutvpd7rh7zEd528HD0d_l6A73osY"
//     preview.src = src
//   }
// }
