<template>
  <transition name="listing-modal">
    <div class="listing-modal-mask">
      <div class="listing-modal-wrapper">
        <div class="listing-modal-container">

          <div class="listing-modal-close">
            <button class="close-button btn btn-secondary" @click="$emit('close')">
              <i class="fa fa-times"></i>
            </button>
          </div>

          <div class="listing-modal-header">
            <slot name="header">
              <!-- Modal -->
            </slot>
          </div>

          <div class="modal-body">
            <slot name="body">
              <!-- default body -->
            </slot>
          </div>

          <div class="modal-footer">

          </div>

        </div>
      </div>
    </div>
  </transition>
</template>

<style scoped>
.listing-modal-mask {
  display: table;
  position: fixed;
  z-index: 1000;
  top: 0;
  right: 0;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .7);
  transition: opacity .3s ease;
}

.listing-modal-wrapper {
  display: table-cell;
  vertical-align: middle;
  width: 100%;
  height: 100%;
}

.listing-modal-container {
  height: 100%;
  max-width: 100%;
  margin: auto;
  padding: 10px;
  background-color: transparent;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
}


.close-button {
  position: absolute;
  right: 0;
  top: 0;
  padding: 16px 28px 8px;
  font-size: 2em;
  width: auto;
  height: auto;
  background: transparent;
  border: 0;
  outline: none;
  color: #fff;
}
/* .modal-header h3 {
  margin-top: 0;
  color: #42b983;
} */

/* These override bootstrap */
.modal-body {
  margin: 10px 0;
}

.modal-footer {
  padding: 0.25em;
  border: 0px;
}
/* End bootstrap override */

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.listing-modal-enter {
  opacity: 0;
}

.listing-modal-leave-active {
  opacity: 0;
}

.listing-modal-enter .listing-modal-container,
.listing-modal-leave-active .listing-modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>
