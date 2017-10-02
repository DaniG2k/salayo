<template>
  <div class="dropzone"></div>
</template>

<script>
  export default {
    props: ['csrf'],
    mounted: function() {
      new Dropzone(this.$el, {
        url: '/upload_images',
        maxFiles: 15,
        parallelUploads: 15,
        acceptedFiles: 'image/*',
        addRemoveLinks: true,
        uploadMultiple: true,
        //autoProcessQueue: false,
        headers: { 'X-CSRF-Token': this.csrf },
        init: function() {
          this.on("removedfile", function(file) {
            //console.log(`${file.name} was removed`);
            $.ajax({
              url: '/rm_image',
              type: 'POST',
              data: { 'rm_image' : file.name }
            });
          });
        }

      });
    }
  }
</script>
