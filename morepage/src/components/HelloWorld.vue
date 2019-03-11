<template>
  <scroller>
    <wxc-navpage title="首页" background-color="#3683FF"  onclick="onClickTitle" title-color="#FF0000" left-item-title="搜索" left-item-color="#EA80FF" right-item-title="跳转" right-item-color="#EA80FF"></wxc-navpage>

    <image ref="logoimage" style="width: 100wx; height: 200we;" src="http://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png" @click="abc" @name="alex"></image>
    <text class="message" style="font-size: 10wx;" @click="abc" @bbb="bbb">Now, let's use Vue.js to build your Weex app.lk;lk;lk</text>
    <input ref="inputRef" v-model="inputValue"> </input>
    <div class="button" @click="toFocus"><text class="button-text">change input focus</text></div>
    <div class="button" @click="toHide"><text class="button-text">change input hide</text></div>
  </scroller>
</template>

<script>
const navigator = weex.requireModule('navigator')
export default {
  name: 'HelloWorld',
  data () {
    return {
      inputValue: ''
    }
  },
  methods: {
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
  }
}
</script>
<style scoped>
  .texmessaget {
    color: red;
    font-size: 33wx;
  }

  .button {
    margin-top: 10wx;
    height: 33wx;
    background-color: red;
    border: 1px solid yellow;
    border-radius: 16.5wx;
  }

  .button-text {
    line-height: 33wx;
    text-align: center;
  }
</style>
