<template>
  <scroller>
    <wxc-navpage title="首页" background-color="#3683FF"  onclick="onClickTitle" title-color="#FF0000" left-item-title="搜索" left-item-color="#EA80FF" right-item-title="跳转" right-item-color="#EA80FF"></wxc-navpage>

    <image ref="logoimage" style="width: 100wx; height: 200we;" src="http://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png" @click="abc" @name="alex"></image>
    <text class="message" style="font-size: 10wx;" @click="abc" @bbb="bbb">Now, let's use Vue.js to build your Weex app.lk;lk;lk</text>
    <input ref="inputRef" class="input" v-model="inputValue"> </input>
    <div class="button" @click="toFocus"><text class="button-text">change input focus</text></div>
    <div class="button" @click="toHide"><text class="button-text">change input hide</text></div>
    <web class="web-cls" :src="srcs"></web>
  </scroller>
</template>

<script>
const navigator = weex.requireModule('navigator')
var localWeb = weex.requireModule('localWeb')
export default {
  name: 'HelloWorld',
  data () {
    return {
      inputValue: '',
      source: '',
      srcs: ''
    }
  },
  methods: {
    reloadWeb () {
      this.srcs = localWeb.getLocalUrl({score: '1001',desc: '小王GGb'})
      // '?q=score%3d0%26desc%3d阿嫂'
      console.log('url::::' + this.srcs)
    },
    getInitialData () {},
    toFocus () {
      // 下面一行是为了兼容 Android
      this.$refs.inputRef.blur()
      this.$refs.inputRef.focus()
    },
    toHide () {
      this.$refs.inputRef.blur()
    },
    abc () {
      console.log('click')
    }
  },
  created () {
    navigator.setNavBarTitle({title: 'title'})
    this.reloadWeb()
  }
}
</script>
<style scoped>
  .web-cls {
    height: 400wx;
    background-color: red;
  }
  .texmessaget {
    color: red;
    font-size: 33wx;
  }

  .input {
    height: 33wx;
    background-color: lightgray;
    margin-left: 15wx;
    margin-right: 15wx;
  }

  .button {
    margin-top: 10wx;
    height: 33wx;
    background-color: red;
    border: 1px solid yellow;
    border-radius: 16.5wx;
    margin-left: 15wx;
    margin-right: 15wx;
  }

  .button-text {
    line-height: 33wx;
    text-align: center;
  }
</style>
