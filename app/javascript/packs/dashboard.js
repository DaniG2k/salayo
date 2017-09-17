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
    Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    var listingForm = document.getElementsByClassName('listing_form')[0];
    var id = listingForm.dataset.id;
    var listing = JSON.parse(listingForm.dataset.listing);

    Vue.component('step-item', {
      props: ['step', 'active'],
      template: '<li :class="{active}">{{ step.text }}</li>'
    })

    Vue.directive('map', {
      // When the bound element is inserted into the DOM:
      inserted: function (el, binding) {
        var map = new google.maps.Map(document.getElementById('location-map'), {
          zoom: 15,
          draggable: false,
          panControl: false,
          scrollwheel: false,
          streetViewControl: false,
          fullscreenControl: false,
          center: binding.value,
          disableDoubleClickZoom: true
        });
      }
    })

    const progress = new Vue({
      el: '#listing-multistep',
      data: {
        id: id,
        listing: listing,
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
        name: '',
        city: '',
        state: '',
        address: '',
        lat: '',
        lng: ''
      },
      // saveListing: function() {
      //   this.$http.post('/listings', listing: {this.listing}).then( response => {
      //
      //   })
      // },
      methods: {
        getCoords: function() {
          if(this.lat === '' && this.lng === '') {
            this.lat = 37.5665
            this.lng = 126.9780
          }
          return {lat: this.lat, lng: this.lng}
        },
        updateLocation: function() {
          var map = new google.maps.Map(document.getElementById('location-map'), {
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

          var fullAddress = this.address
          if(this.city.length > 1) {
            if(fullAddress.length > 1) {
              fullAddress += ', ' + this.city
            } else {
              fullAddress += this.city
            }
          }
          if(this.state.length > 1) {
            if(fullAddress.length > 1) {
              fullAddress += ', ' + this.state
            } else {
              fullAddress += this.state
            }
          }
          function defaultMarker() {
            marker.setVisible(false);
            this.lat = 37.5665;
            this.lng = 126.9780;
          }

          var geocoder = new google.maps.Geocoder({types: ["geocode"]});
          if (this.address == '' && this.city == '' && this.state == '') {
            defaultMarker();
          } else {
            geocoder.geocode({'address': this.address + ', ' + this.city + ', ' + this.state }, function(response, status) {
              if (status == 'OK'){
                marker.setVisible(true);
                this.lat = parseFloat(response[0].geometry.location.lat());
                this.lng = parseFloat(response[0].geometry.location.lng());
                var newLatLng = new google.maps.LatLng(this.lat, this.lng);
                map.setCenter(newLatLng);
                marker.setPosition(newLatLng);
              } else {
                marker.setVisible(false);
                this.lat = null;
                this.lng = null;
              }
            });
          }
        }
      }
    })
  }
})
