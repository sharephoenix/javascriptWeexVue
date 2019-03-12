<template>
  <div>
    <text class="message">{{msg}}}</text>
    <div class="button" @click="getInitialData"><text>click!!!</text></div>
  </div>
</template>

<script>
// const initialparams = require
require('weex-vue-render')
export default {
  name: 'HelloWorld',
  data () {
    return {
      msg: ''
    }
  },
  methods: {
    getInitialData () {
      let urlParamObj = {}
      try {
        urlParamObj = utils.parseUrl(window.location.search.slice(1), '&', "=", {maxKeys: 0})
        console.log(urlParamObj)
      } catch (error) {
        console.log('--------------weex.js parseUrl---------------------')
        console.log(error)
        console.log('------------------------------------')
      }
      for (let key in urlParamObj) {
        window.weex.config[key] = encodeURIComponent(urlParamObj[key])
      }
    }
  }
}
</script>

<style scoped>
  .button {
    width: 200px;
    height: 200px;
    background-color: red;
  }
</style>
