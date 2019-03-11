<template>
  <div>
    <wxc-navpage title="首页" background-color="#3683FF"  onclick="onClickTitle" title-color="#FF0000" left-item-title="搜索" left-item-color="#EA80FF" right-item-title="跳转" right-item-color="#EA80FF"></wxc-navpage>

    <image ref="logoimage" style="width: 100wx; height: 200we;" src="http://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png" @click="abc" @name="alex"></image>
    <text class="message" style="font-size: 10wx;" @click="abc" @bbb="bbb">Now, let's use Vue.js to build your Weex app.lk;lk;lk</text>
  </div>
</template>

<script>
const navigator = weex.requireModule('navigator')
export default {
  name: 'HelloWorld',
  methods: {
    getInitialData () {},
    abc () {
      console.log('click')
    }
  },
  created () {
    navigator.setNavBarTitle('title')
  }
}
</script>
<style scoped>
  .texmessaget {
    color: red;
    font-size: 33wx;
  }
</style>
