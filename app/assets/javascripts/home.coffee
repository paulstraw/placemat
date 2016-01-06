# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

examplesContainer = document.querySelector('.examples')

imagesLoaded examplesContainer, ->
  examplesPackery = new Packery(examplesContainer, {
    gutter: 10
  })
