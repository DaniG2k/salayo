# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  animating = undefined
  $('.next').click ->
    if animating
      return false
    animating = true
    current_fs = $(this).parent()
    next_fs = $(this).parent().next()
    #activate next step on progressbar using the index of next_fs
    $('#listing-progressbar li').eq($('fieldset').index(next_fs)).addClass('active')
    #show the next fieldset
    next_fs.show()
    current_fs.hide()
    animating = false
    return

  $('.previous').click ->
    if animating
      return false
    animating = true
    current_fs = $(this).parent()
    previous_fs = $(this).parent().prev()
    #de-activate current step on progressbar
    $('#listing-progressbar li').eq($('fieldset').index(current_fs)).removeClass('active')
    #show the previous fieldset
    previous_fs.show()
    current_fs.hide()
    animating = false
    return

  $('input[name="map_search"]').change ->
    if $(this).val() is 'address'
      $('#listing_city').prop('readonly', false)
      $('#listing_state').prop('readonly', false)
      $('#listing_address').prop('readonly', false)
      $('#listing_lat').prop('readonly', true)
      $('#listing_lng').prop('readonly', true)
      $('fieldset[name="address"]').slideDown()
      $('fieldset[name="coords"]').slideUp()
    else if $(this).val() is 'coords'
      $('#listing_city').prop('readonly', true)
      $('#listing_state').prop('readonly', true)
      $('#listing_address').prop('readonly', true)
      $('#listing_lat').prop('readonly', false)
      $('#listing_lng').prop('readonly', false)
      $('fieldset[name="address"]').slideUp()
      $('fieldset[name="coords"]').slideDown()


window.ListingForm =
  els:
    form: "#new_listing"
    defaultLatLong: {lat: 37.5665, lng: 126.9780} # Coords for Seoul
  init: ->
    window.loadExternalJs("https://maps.googleapis.com/maps/api/js?key=#{gon.google_maps_api_key}", @mapsLoaded, @initMap)

  mapsLoaded: ->
    typeof google is 'object' and typeof google.maps is 'object'

  initMap: ->
    if gon.lat && gon.lng
      locationLat = gon.lat
      locationLng = gon.lng
    else
      locationLat = ListingForm.els.defaultLatLong.lat
      locationLng = ListingForm.els.defaultLatLong.lng

    locations =
      lat: locationLat
      lng: locationLng

    map = new (google.maps.Map)(document.getElementById('location-map'),
      zoom: 15
      center: locations
      scrollwheel: false
      disableDoubleClickZoom: true
      panControl: false
      streetViewControl: false
      draggable: false
    )
    marker = new (google.maps.Marker)(
      position: locations
      map: map)

    ListingForm.setValueLatLngField(locations.lat, locations.lng)
    geocoder = new google.maps.Geocoder({types: ["geocode"]})

    $('#listing_address, #listing_city, #listing_state').on "change", () ->
      ListingForm.updateLocationMap(map, marker, geocoder)

  updateLocationMap: (map, marker, geocoder) ->
    keyWork = "#{$('#listing_address').val()} #{$('#listing_city').val()} #{$('#listing_state').val()}"
    geocoder.geocode {'address': keyWork}, (response, info) ->
      if info == google.maps.GeocoderStatus.OK
        marker.setVisible true
        map.setCenter(response[0].geometry.location)
        marker.setPosition(response[0].geometry.location)
        ListingForm.setValueLatLngField(response[0].geometry.location.lat(), response[0].geometry.location.lng())
      else
        marker.setVisible false
        ListingForm.setValueLatLngField(null, null)

  setValueLatLngField: (lat, lng) ->
    $('#listing_lat').val(lat)
    $('#listing_lng').val(lng)
    return
