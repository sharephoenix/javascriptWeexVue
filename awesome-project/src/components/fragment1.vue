<template>
  <div class="wrapper">
      <image src="https://alibaba.github.io/weex/img/weex_logo_blue@3x.png" class="logo"></image>
      <text class="button" @click="jump"> jump  {{counts}} {{target}}</text>
      <button v-on:click="update"> click update </button>
  </div>
</template>

<script>
var navigator = weex.requireModule('navigator')
var modal = weex.requireModule('modal')

export default {
  name: 'fragment1',
  data () {
    return {
      target: 'World',
      counts: 100000
    }
  },
  methods: {
    update: function () {
      this.target = 'Lychee'
      this.counts = navigator.counts
      modal.toast({'message': 'this is my message!!!'})
    },
    jump (event) {
      console.log('will jump')
      navigator.push({
        url: 'http://192.168.1.105:8081/fragment3',
        animated: 'true'
      }, event => {
        modal.toast({ message: 'callback: ' + event })
      })
    }
  }
}
</script>
<style>
.wrapper {
  align-items: center;
  background-color: #66ccff;
  height: 100%;
}
.button {
  font-size: 48px;
  margin-top: 8px;
  background-color: black;
  color: red;
  padding: 8px;
}
.logo {
  width: 360px;
  height: 82px;
  margin-top: 40px;
  margin-bottom: 40px;
  background-color: #66cc00;
}
</style>
