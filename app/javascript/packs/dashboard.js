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

document.addEventListener('DOMContentLoaded', () => {

  if(document.getElementById('dashboard-topbar')) {
    const dashboard = new Vue({
      el: '#dashboard-topbar',
      data: {
        showDropdown: false
      }
    })
  }

  if(document.getElementById('listing-multistep')) {
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
        var marker = new google.maps.Marker({
          map: map,
          position: binding.value
        });
      }
    })

    const progress = new Vue({
      el: '#listing-multistep',
      data: {
        activeStep: 0,
        stepList: [
          {id: 0, text: 'Basics'},
          {id: 1, text: 'Location'},
          {id: 2, text: 'Amenities'},
          {id: 3, text: 'Images'}
        ],
        byAddress: true,
        propertyType: undefined,
        name: '',
        city: '',
        state: '',
        address: '',
        lat: '',
        lng: ''
      },
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
            marker.setVisible(false)
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
                defaultMarker();
              }
            });
          }
        }
      }
    })
  }
})
