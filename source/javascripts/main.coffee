# Code is crap
# TODO: Refactor

$ ->
  window.notify = (text) ->
    noty({
      theme: 'relax'
      closeWith: ['button']
      # closeWith: ['click'], // ['click', 'button', 'hover', 'backdrop'] // backdrop click will close all notifications
      text: text      
    })
