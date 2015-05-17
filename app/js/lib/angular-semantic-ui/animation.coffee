'use strict'

$ = require('jquery')

module.exports = () ->
  leave: (element, doneFn) ->
    console.log 'leave'
    $(element).show()
    #$(element).transition('slide left', 300, doneFn())
    element.fadeOut(1000, doneFn)
    (cancelled) ->
      $(element).hide()
  enter: (element, doneFn) ->
    console.log 'enter'
    $(element).hide()
    $(element).transition('slide left', 300, doneFn)
    (cancelled) ->
      $(element).show()
  #move: (element, doneFn) ->
    #console.log 'move'
    ##doneFn()
    ##$(element).fadeOut(1000, doneFn)
    #(cancelled) ->
      #return
  beforeAddClass: (element, className, doneFn) ->
    console.log 'before add class'
    $(element).transition('show')
    $(element).transition('slide left', 300, doneFn)
    (cancelled) ->
      console.log 'before add class cancelled'
      #$(element).hide()
      doneFn()
  addClass: (element, className, doneFn) ->
    console.log 'add class'
    $(element).transition('hide')
    doneFn()
    (cancelled) ->
      console.log 'add class canc'
      #doneFn()
  beforeRemoveClass: (element, className, doneFn) ->
    console.log 'before rm class'
    $(element).transition('hide')
    $(element).transition('slide left', 300, doneFn)
    (cancelled) ->
      console.log 'before rm class canc'
      $(element).transition('stop')
      #doneFn()
      #$(element).hide()
  removeClass: (element, className, doneFn) ->
    console.log 'rm class'
    $(element).removeClass('transition visible')
    #doneFn()
    (cancelled) ->
      console.log 'rm class canc'
      #doneFn()

    #$(element).transition('slide left', 500, doneFn)
