# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $('#find_college').autocomplete
    source: "/search_suggestions"
    
  $('#major_search').autocomplete
    source: "/major_search_suggestions"

  $('#search').autocomplete
    source: "/search_suggestions"
