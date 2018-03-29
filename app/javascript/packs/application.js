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
import Vuelidate from 'vuelidate';
import { required, email } from 'vuelidate/lib/validators';
import Typed from 'typed.js';

Vue.use(Vuelidate)

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('lang-navbar') !== null) {
    const dashboard = new Vue({
      el: '#lang-navbar',
      data: {
        showDropdown: false
      }
    })
  }

  if(document.getElementById('typed-element') !== null) {
    const typed = new Vue({
      el: '#typed-element',
      mounted() {
        var options = {
          strings: [
            "The easiest way to find housing in <strong>Tokyo</strong>.",
            "The easiest way to find housing in <strong>Kyoto</strong>.",
            "The easiest way to find housing in <strong>Seoul</strong>.",
            "The easiest way to find housing in <strong>Osaka</strong>.",
            "The easiest way to find housing in <strong>Busan</strong>."
          ],
          typeSpeed: 100,
          shuffle: true,
          startDelay: 100,
          backDelay: 600
        }
        new Typed('#typed-element', options)
      }
    })
  }

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
      methods: {
        validateClass: function(obj) {
          return {
            'form-control is-invalid': obj.$error,
            'form-control is-valid checkmark': (!obj.$error && obj.$dirty)
          }
        }
      }
    })
  }
})
