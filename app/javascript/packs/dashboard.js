/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you set extractStyles to true
// in config/webpack/loaders/vue.js) to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

// import Vue from 'vue'
// import App from './app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   document.body.appendChild(document.createElement('hello'))
//   const app = new Vue(App).$mount('hello')
//
//   console.log(app)
// })


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>

import Vue from 'vue/dist/vue.esm';
import VueResource from 'vue-resource';

Vue.use(VueResource);

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('dashboard-topbar') != null) {
    const dashboard = new Vue({
      el: '#dashboard-topbar',
      data: {
        showDropdown: false
      }
    })
  }

  if(document.getElementById('listing-multistep') != null) {
    Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('input[name="authenticity_token"]').getAttribute('value');
    var listingForm = document.getElementsByClassName('listing_form')[0];
    var id = listingForm.dataset.id;

    Vue.component('step-item', {
      props: ['step', 'active'],
      template: '<li :class="{active}">{{ step.text }}</li>'
    })

    const listingForm = new Vue({
      el: '#listing-multistep',
      data: {
        id: id,
        activeStep: 0,
        stepList: [
          {id: 0, text: 'Basics'},
          {id: 1, text: 'Location'},
          {id: 2, text: 'Amenities'},
          {id: 3, text: 'Images'}
        ],
        amenities: [
          {id: 0, text: "Air conditioning"},
          {id: 1, text: "Buzzer/wireless intercom"},
          {id: 2, text: "Cable TV"},
          {id: 3, text: "Doorman"},
          {id: 4, text: "Dryer"},
          {id: 5, text: "Elevator"},
          {id: 6, text: "Essentials"},
          {id: 7, text: "Gym"},
          {id: 8, text: "Hair dryer"},
          {id: 9, text: "Hangers"},
          {id: 10, text: "Heating"},
          {id: 11, text: "Hot tub"},
          {id: 12, text: "Internet"},
          {id: 13, text: "Iron"},
          {id: 14, text: "Kitchen"},
          {id: 15, text: "Parking"},
          {id: 16, text: "Pool"},
          {id: 17, text: "TV"},
          {id: 18, text: "Washer"}
        ],
        checkedAmenities: [],
        byAddress: true,
        propertyType: undefined,
        displayMap: false,
        name: '',
        city: '',
        state: '',
        address: '',
        lat: '',
        lng: ''
      },
      methods: {
        submitListing: function() {
          var amenityNames = []
          var checkedIndices = []

          this.checkedAmenities.forEach((elt, idx) => {
            if(elt === true){ checkedIndices.push(idx) }
          });

          this.amenities.map((amenity) => {
            if(checkedIndices.includes(amenity.id)){
              amenityNames.push(amenity.text);
            }
          });

          var listingObj = {
            id: this.id,
            name: this.name,
            property_type: this.propertyType,
            city: this.city,
            state: this.state,
            address: this.address,
            lat: this.lat,
            lng: this.lng,
            amenities: amenityNames
          }

          if(this.id == null) {
            console.log(listingObj)
            // POST if it's a new listing
            this.$http.post('/listings', {listing: listingObj}).then(
              response => {
                window.location = `/listings/${response.body.id}`
            }, response => {
              console.log(response)
            })
          } else {
            // PUT if it's an existing listing
            this.$http.put(`/listings/${this.id}`, {listing: listingObj}).then(
              response => {
                window.location = `/listings/${response.body.id}`
            }, response => {
              console.log(response)
            })
          }
        },
        updateLocation: function() {
          var fullAddress = this.address;
          if(this.city.length > 1) {
            fullAddress += (fullAddress.length > 1) ? `, ${this.city}` : this.city
          }
          if(this.state.length > 1) {
            fullAddress += (fullAddress.length > 1) ?  `, ${this.state}` : this.state
          }

          if (fullAddress == '') {
            this.lat = null;
            this.lng = null;
            this.displayMap = false
          } else {
            var geocoder = new google.maps.Geocoder({types: ["geocode"]});
            geocoder.geocode({'address': fullAddress }, (response, status) => {
              if (status == 'OK'){
                this.lat = parseFloat(response[0].geometry.location.lat());
                this.lng = parseFloat(response[0].geometry.location.lng());
                this.displayMap = true;
                var mapDiv = document.getElementById('location-map');

                var map = new google.maps.Map(mapDiv, {
                  zoom: 15,
                  draggable: false,
                  panControl: false,
                  scrollwheel: false,
                  streetViewControl: false,
                  fullscreenControl: false,
                  center: {lat: this.lat, lng: this.lng},
                  disableDoubleClickZoom: true
                });

                var marker = new google.maps.Marker({
                  map: map,
                  position: {lat: this.lat, lng: this.lng}
                });

                var newLatLng = new google.maps.LatLng(this.lat, this.lng);

                map.setCenter(newLatLng);
                marker.setVisible(true);
                marker.setPosition(newLatLng);
              } else {
                console.log(`Status: ${status}`)
                marker.setVisible(false);
                this.lat = null;
                this.lng = null;
                this.displayMap = false;
              }
            });
          }
        }
      }
    })
  }
})
