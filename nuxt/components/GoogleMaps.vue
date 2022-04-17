<template>
  <div>
        <GmapMap
        :center="myCoordinates"
        :zoom="zoom"
        style="width:100%;height:400px;"
        ref="mapRef"
        @dragend="handleDrag"
        ></GmapMap>
  </div>
</template>

<script>
    export default {
        data(){
            return{
                map: null,
                myCoordinates:{
                    lat: 47.4979,
                    lng: 19.0402      
                },
                zoom: 6
            }
        },

        created(){
             if(process.client) {
                if(localStorage.center){
                    this.myCoordinates = JSON.parse(localStorage.center);
                } else {
                        this.$getLocation({})
                    .then(coordinates=>{
                        this.zoom = 10
                        this.myCoordinates = coordinates;
                    })
                    .catch(error => console.log(error));
                }

                if(localStorage.zoom){
                    this.zoom = parseInt(localStorage.zoom);
                }
            }
        },

        mounted() {
            this.$refs.mapRef.$mapPromise.then(map => {this.map = map});
        },

        methods: {
            handleDrag(){
                const center = {
                    lat: this.map.getCenter().lat(),
                    lng: this.map.getCenter().lng()
                };
                const zoom = this.map.getZoom();

                localStorage.center = JSON.stringify(center);
                localStorage.zoom = zoom;
            }
        },

        computed: {
            mapCoordinates() {
                if(!this.map){
                    return {
                        lat: 47.4979,
                        lng: 19.0402        
                    };
                }

            return {
                lat: this.map.getCenter().lat().toFixed(4),
                lng: this.map.getCenter().lng().toFixed(4)
            }
        }
    }
}
</script>

<style>

</style>
