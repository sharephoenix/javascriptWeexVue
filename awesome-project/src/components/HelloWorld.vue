<template>
  <div class="rootDiv">
    <text>Now, let's use Vue.js to build your Weex app.</text>
    <text> helloworld</text>
    <textarea placeholder="thist textarrar"></textarea>
    <button class="buttocls" v-on:click="push">push new view</button>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data () {
    return {
      name: 'this is my name!!!'
    }
  },
  methods: {
    push: function () {
      console.log('push action')
      this.$router.push('./')
      console.log(this)
    }
  },
  components: {}
}
</script>

<style scoped>
.rootDiv {
  top: 0px;
  background-color: #ff2222;
  /* width: 100%;
    height: 100%; */
}
.buttocls {
  width: 200px;
  height: 44px;
  background-color: aqua;
}
</style>
