# window.ListingForm =
#   els:
#     form: "#new_listing"
#     defaultLatLong: {lat: 37.5665, lng: 126.9780} # Coords for Seoul
#   init: ->
#     window.loadExternalJs("https://maps.googleapis.com/maps/api/js?key=#{gon.google_maps_api_key}", @mapsLoaded, @initMap)
#
#   mapsLoaded: ->
#     typeof google is 'object' and typeof google.maps is 'object'
#
#   initMap: ->
#     if gon.lat && gon.lng
#       locationLat = gon.lat
#       locationLng = gon.lng
#     else
#       locationLat = ListingForm.els.defaultLatLong.lat
#       locationLng = ListingForm.els.defaultLatLong.lng
#
#     locations =
#       lat: locationLat
#       lng: locationLng
#
#     map = new (google.maps.Map)(document.getElementById('location-map'),
#       zoom: 15
#       center: locations
#       scrollwheel: false
#       disableDoubleClickZoom: true
#       panControl: false
#       streetViewControl: false
#       draggable: false
#     )
#     marker = new (google.maps.Marker)(
#       position: locations
#       map: map)
#
#     ListingForm.setValueLatLngField(locations.lat, locations.lng)
#     geocoder = new google.maps.Geocoder({types: ["geocode"]})
#
#     $('#listing_address, #listing_city, #listing_state').on "change", () ->
#       ListingForm.updateLocationMap(map, marker, geocoder)
#
#   updateLocationMap: (map, marker, geocoder) ->
#     keyWork = "#{$('#listing_address').val()} #{$('#listing_city').val()} #{$('#listing_state').val()}"
#     geocoder.geocode {'address': keyWork}, (response, info) ->
#       if info == google.maps.GeocoderStatus.OK
#         marker.setVisible true
#         map.setCenter(response[0].geometry.location)
#         marker.setPosition(response[0].geometry.location)
#         ListingForm.setValueLatLngField(response[0].geometry.location.lat(), response[0].geometry.location.lng())
#       else
#         marker.setVisible false
#         ListingForm.setValueLatLngField(null, null)
#
#   setValueLatLngField: (lat, lng) ->
#     $('#listing_lat').val(lat)
#     $('#listing_lng').val(lng)
#     return
