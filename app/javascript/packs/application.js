/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// console.log('Hello World from Webpacker')

import Vue from 'vue/dist/vue.esm';
import Vuelidate from 'vuelidate'
import { required, email } from 'vuelidate/lib/validators'
Vue.use(Vuelidate)

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('contact-us') != null) {
    const contactForm = new Vue({
      el: '#contact-us',
      data() {
        return {
          name: undefined,
          email: undefined,
          body: undefined
        }
      },
      validations: {
        name: { required },
        email: { required, email },
        body: { required }
      },
      computed: {
        validateName: function() {
          return {
            'form-control is-invalid': this.$v.name.$error,
            'form-control is-valid checkmark': (!this.$v.name.$error && this.$v.name.$dirty)
          }
        },
        validateEmail: function() {
          return {
            'form-control is-invalid': this.$v.email.$error,
            'form-control is-valid checkmark': (!this.$v.email.$error && this.$v.email.$dirty)
          }
        },
        validateBody: function() {
          return {
            'form-control is-invalid': this.$v.body.$error,
            'form-control is-valid checkmark': (!this.$v.body.$error && this.$v.body.$dirty)
          }
        }
      }
    })
  }
})
