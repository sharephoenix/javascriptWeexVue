<template>
  <div class="wrapper">
      <image src="https://alibaba.github.io/weex/img/weex_logo_blue@3x.png" class="logo"></image>
      <text class="button" @click="update">navigator: {{ counts }} Hello {{target}}</text>
      <button v-on:click="popnavator"> pop controller</button>
      <button v-on:click="update">click me update navigator count</button>
  </div>
</template>

<script>
// var globalEvent=weex.requireModule('globalEvent');
// globalEvent.addEventListener("fragment", function (result) {
//         console.log("get fragment");
//   });
var navigator = weex.requireModule('navigator')
var modal = weex.requireModule('modal')
export default {
  name: 'fragment1',
  data () {
    return {
      target: 'World',
      counts: 0
    }
  },
  methods: {
    update: function () {
      this.target = 'Lychee'
      this.counts = navigator.counts
    },
    popnavator: function () {
      modal.toast({'message': 'pop controller!!!'})
      navigator.pop()
    }
  }
}
</script>
<style>
.wrapper {
  align-items: center;
  background-color: #66ccff;
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
