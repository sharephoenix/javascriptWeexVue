<template>
  <!-- <div class="wrapper" @viewappear="onViewappear"> -->
    <!-- <keep-alive> -->
      <router-view/>
    <!-- </keep-alive> -->
  <!-- </div> -->
</template>

<script>

const modal = weex.requireModule('modal')
var globalEvent = weex.requireModule('globalEvent')
globalEvent.addEventListener('geolocation', function (e) {
  modal.toast({ 'message': 'get geolocation ++++ ' + e, 'duration': 2 })
})

export default {
  name: 'App',
  data () {
    return {
      logo: 'https://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png'
    }
  },
  methods: {
    onViewappear (params) {
      modal.toast({'message': '我靠 viewappear' + params, 'duration': 1})
    }
  }
}
</script>

<style scoped>
  .wrapper {
    position: relative;
    background-color: red;
  }
</style>
