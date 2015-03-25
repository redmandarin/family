# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".connection-type").change ->
    connection_field = $(".member-connection")
    if $(this).val() == "baby"
      alert "hello"
      connection_field.attr("id", "connection_baby_id")
      connection_field.attr("name", "connection[baby_id]")
    else
      alert "goodbay"
      connection_field.attr("id", "connection_procreator_id")
      connection_field.attr("name", "connection[procreator_id]")

$(document).ready(ready)
$(document).on('page:load', ready)