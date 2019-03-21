<template>
  <div class="wrapper" @viewappear="viewappear">

    <router-view/>
  </div>
</template>

<script>
import HelloWorld from '@/components/HelloWorld'
export default {
  name: 'App',
  data () {
    return {
      logo: 'https://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png'
    }
  },
  init: function () {
    console.log('initinitinitinitinitinitinitinit')
  },
  ready: function () {
    console.log('readyreadyreadyreadyreadyreadyready')
  },
  created () {
    console.log('createdcreatedcreatedcreated')
  },
  methods: {
    viewappear () {
      console.log('viewappearviewappearviewappear')
    }
  },
  components: {
    HelloWorld
  }
}
</script>

<style scoped>
  .wrapper {
  }
  .logo {
    width: 42px;
    height: 20px;
  }
  .greeting {
    text-align: center;
    margin-top: 70px;
    font-size: 50px;
    color: #41B883;
  }
  .message {
    margin: 30px;
    font-size: 32px;
    color: #727272;
  }

  .image-cls {
    height: 300wx;
    background: url('https://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png');
  }
</style>
