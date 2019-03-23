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

import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'
// import listingModal from '../components/listing_modal.vue'
import Vuelidate from 'vuelidate'
import { required, minLength, between } from 'vuelidate/lib/validators'
import vue2Dropzone from 'vue2-dropzone'
//import 'vue2-dropzone/dist/vue2Dropzone.css'

Vue.use(Vuelidate)
Vue.use(VueResource)

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('dashboard-topbar') !== null) {
    const dashboard = new Vue({
      el: '#dashboard-topbar',
      data: {
        showDropdown: false
      }
    })
  }

  if(document.getElementById('listing-multistep') !== null) {
    Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('input[name="authenticity_token"]').getAttribute('value');
    var listingForm = document.getElementById('listing_form');
    var listing = JSON.parse(listingForm.dataset.listing);
    var locale = document.getElementsByTagName('html')[0].getAttribute('lang');

    Vue.component('step-item', {
      props: ['step', 'active'],
      template: '<li :class="{active}">{{ step.text }}</li>'
    })

    const myForm = new Vue({
      el: '#listing-multistep',
      components: {
        vueDropzone: vue2Dropzone
      },
      data: function () {
        return {
          id: listing.id,
          locale: locale,
          slug: listing.slug,
          activeStep: 0,
          stepList: [
            {id: 0, text: 'Basics'},
            {id: 1, text: 'Location'},
            {id: 2, text: 'Amenities'},
            {id: 3, text: 'Description'}
          ],
          byAddress: true,
          propertyType: listing.property_type,
          displayMap: false,
          name: listing.name,
          bedrooms: listing.bedrooms,
          beds: listing.beds,
          bathrooms: listing.bathrooms,
          priceCents: listing.price_cents,
          priceCurrency: listing.price_currency,
          currencySymbol: '$',
          pricePerMonth: (listing.price_cents * 52.17857 / 12).toFixed(2),
          city: listing.city,
          state: listing.state,
          address: listing.address,
          lat: listing.lat,
          lng: listing.lng,
          description: listing.description,
          amenityList: {
            air_conditioning: listing.amenity_list_attributes.air_conditioning,
            intercom: listing.amenity_list_attributes.intercom,
            cable_tv: listing.amenity_list_attributes.cable_tv,
            doorman: listing.amenity_list_attributes.doorman,
            dryer: listing.amenity_list_attributes.dryer,
            elevator: listing.amenity_list_attributes.elevator,
            essentials: listing.amenity_list_attributes.essentials,
            gym: listing.amenity_list_attributes.gym,
            hair_dryer: listing.amenity_list_attributes.hair_dryer,
            hangers: listing.amenity_list_attributes.hangers,
            heating: listing.amenity_list_attributes.heating,
            hot_tub: listing.amenity_list_attributes.hot_tub,
            internet: listing.amenity_list_attributes.internet,
            iron: listing.amenity_list_attributes.iron,
            kitchen: listing.amenity_list_attributes.kitchen,
            parking: listing.amenity_list_attributes.parking,
            pool: listing.amenity_list_attributes.pool,
            refrigerator: listing.amenity_list_attributes.refrigerator,
            tv: listing.amenity_list_attributes.tv,
            washer: listing.amenity_list_attributes.washer,
          },
          dropzoneOptions: {
            url: (listing.id === null ? `/${locale}/listings` : `/${locale}/listings/${listing.slug}`),
            method: (listing.id === null ? 'post' : 'put'),
            acceptedFiles: 'image/*',
            uploadMultiple: true,
            autoProcessQueue: false, // Dropzone should wait for the user to click a button to upload
            parallelUploads: 15, // Dropzone should upload all files at once (including the form data) not all files individually
            maxFiles: 15, // this means that they shouldn't be split up in chunks
            addRemoveLinks: true,
            thumbnailWidth: 150,
            maxFilesize: 5,
            dictDefaultMessage: "<i class='fa fa-cloud-upload'></i> Drop files here to upload (max. 15 files)",
            headers: { 'X-CSRF-Token': Vue.http.headers.common['X-CSRF-Token'] }
          },
          showErrors: false,
          errorMessage: ''
        }
      },
      mounted() {
        this.adjustPriceToCurrency();
      },
      methods: {
        nonCentCurrency() {
          var nonCentCurrencies = ['usd', 'eur', 'gbp'];
          return nonCentCurrencies.includes(this.priceCurrency);
        },
        adjustPriceToCurrency() {
          if (this.nonCentCurrency()) {
            this.priceCents /= 100
            this.weeklyPriceHandler();
          }
        },
        weeklyPriceHandler() {
          this.pricePerMonth = (this.priceCents * 52.18 / 12).toFixed(1)
        },
        monthlyPriceHandler() {
          this.priceCents = (this.pricePerMonth / 52.18 * 12).toFixed(1)
        },
        switchCurrencySymbol() {
          switch(this.priceCurrency) {
            case 'eur':
              this.currencySymbol = '€';
              break;
            case 'gbp':
              this.currencySymbol = '£';
              break;
            case 'jpy':
              this.currencySymbol = '¥';
              break;
            case 'krw':
              this.currencySymbol = '₩';
              break;
            default:
              this.currencySymbol = '$';
          }
        },
        setupListingObj() {
          var amenities = {}
          Object.entries(this.amenityList).forEach(
            ([key, value]) => amenities[key] = value
          );
          // Some currencies don't use cents are their base denomination.
          // Multiply these x100
          if (this.nonCentCurrency()) { this.priceCents *= 100 }
          var listingObj = {
            id: this.id,
            name: this.name,
            bedrooms: this.bedrooms,
            beds: this.beds,
            bathrooms: this.bathrooms,
            bedrooms: this.bedrooms,
            price_cents: this.priceCents,
            price_currency: this.priceCurrency,
            property_type: this.propertyType,
            city: this.city,
            state: this.state,
            address: this.address,
            lat: this.lat,
            lng: this.lng,
            description: this.description,
            amenity_list_attributes: amenities
          }
          return listingObj
        },
        validateClass(obj) {
          return {
            'form-control is-invalid': obj.$error,
            'form-control is-valid checkmark': (!obj.$error && obj.$dirty)
          }
        },
        submitListing() {
          var numFiles = this.$refs.listingDropzone.getAcceptedFiles().length
          // If there are images to upload, use Dropzone
          // Else submit the form normally.
          if (numFiles > 0) {
            this.$refs.listingDropzone.processQueue()
          } else {
            var listingObj = this.setupListingObj()

            if(this.id === null) {
              // POST if it's a new listing
              this.$http.post(`/${this.locale}/listings`, {listing: listingObj}).then(
                response => {
                  window.location = `/${this.locale}/listings/${response.body.slug}`
              }, response => {
                // error callback
                this.showErrors = true
                this.errorMessage = this.parseErrorObj(response.body)
              })
            } else {
              // PUT if it's an existing listing
              this.$http.put(`/${this.locale}/listings/${this.slug}`, {listing: listingObj}).then(
                response => {
                  window.location = `/${this.locale}/listings/${response.body.slug}`
              }, response => {
                // error callback
                this.showErrors = true
                this.errorMessage = this.parseErrorObj(response.body)
              })
            }
          }
        },
        verror(file, msg, xhr) {
          this.showErrors = true
          this.errorMessage = this.parseErrorObj(msg)
        },
        parseErrorObj(obj) {
          var msg = '<ul>'
          Object.entries(obj).forEach(
            ([key, values]) => {
              for (var i=0, l = values.length; i < l; i++) {
                msg += `<li>${key} ${values[i]}</li>`
              }
            }
          );
          msg += '</ul>'
          return msg
        },
        sendingEvent(file, xhr, formData) {
          // This function gets called by Dropzone upon form submission.
          var listingObj = this.setupListingObj()
          formData.append('listing', JSON.stringify(listingObj))
        },
        listingRedirect(files, response) {
          window.location = `/${this.locale}/listings/${response.slug}`
        },
        updateLocation() {
          var fullAddress = '';
          if(this.city !== null && this.city.length > 1) {
            fullAddress += (fullAddress.length > 1) ? `, ${this.city}` : this.city
          }
          if(this.state !== null && this.state.length > 1) {
            fullAddress += (fullAddress.length > 1) ?  `, ${this.state}` : this.state
          }
          if(this.address !== null && this.address.length > 1) {
            fullAddress += (fullAddress.length > 1) ?  `, ${this.address}` : this.address
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
                // console.log(`Status: ${status}`)
                marker.setVisible(false);
                this.lat = null;
                this.lng = null;
                this.displayMap = false;
              }
            });
          }
        }
      },
      validations: {
        name: {
          required,
          minLength: minLength(5)
        },
        propertyType: {
          required
        },
        bedrooms: {
          required,
          between: between(0, 10)
        },
        beds: {
          required,
          between: between(0, 10)
        },
        bathrooms: {
          required,
          between: between(0, 10)
        },
        priceCents: {
          required,
          between: between(0, 100000000)
        },
        pricePerMonth: {
          required,
          between: between(0, 100000000)
        }
      }
    })
  }

})
