<template>
  <div class="dropzone"></div>
</template>

<script>
  export default {
    data() {
      return {
      }
    },
    mounted: function() {
       new Dropzone(this.$el, {
         url: "https://httpbin.org/post",
         maxFiles: 15,
         acceptedFiles: 'image/*',
         addRemoveLinks: true,
         autoProcessQueue: false
       })
    }
  }
</script>
