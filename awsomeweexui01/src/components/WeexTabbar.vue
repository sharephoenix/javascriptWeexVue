<template>
    <!-- 第一个页面内容-->
    <div class="item-container" :style="contentStyle">
          <div class="presentCls" v-on:click="presentAction"> {{present}} </div>
          <input type="text" class="input" value="" placeholder="输入自己想要的"  :autofocus=false @change="onchange" @input="oninput"/>
          <text> {{inputcontent}} </text>
          <div class="presentCls" v-on:click="pushOnePage"> {{pushOnenPage}} </div>
    </div>
</template>

<script>
import { WxcTabBar, WxcMinibar, Utils } from 'weex-ui'
import Slider from './Slider.vue'
// https://github.com/alibaba/weex-ui/blob/master/example/tab-bar/config.js
import Config from './config'
import AppCache from '../cache/weexCache.js'
const modal = weex.requireModule('modal')
export default {
  name: 'WeexTabbar',
  init: function () {
    modal.toast({ 'message': "data", 'duration': 10 })
    console.log("-------------init---------------")
  },
  components: {
    WxcTabBar,
    WxcMinibar,
    'kx-slider': Slider
  },
  mounted: function (el) {
    AppCache.saveData({key: 'title', value: 'this is my cache title bbbbb'})
    AppCache.getData('title', (event) => {
      if (event.result) {
        this.$data.title = event.data
        console.log(event)
        console.log('get success!!!!!!!!' + event.data)
      } else {
        console.log('get cache fail!!!')
      }
    })
  },
  data: () => ({
    tabStyles: Config.tabStyles,
    title: 'title',
    present: '启动下一个小程序-请点击我！！！',
    pushOnenPage: 'push 一个页面',
    inputcontent: 'default'
  }),
  computed: {
    list: function () {
      return this.Banners
    }
  },
  created () {
    const tabPageHeight = Utils.env.getPageHeight()
    // 如果页面没有导航栏，可以用下面这个计算高度的方法
    // const tabPageHeight = env.deviceHeight / env.deviceWidth * 750
    const { tabStyles } = this
    this.contentStyle = { height: tabPageHeight - tabStyles.height + 'px' }
  },
  methods: {
    wxcTabBarCurrentTabSelected (e) {
      const index = e.page
      console.log(index)
      modal.toast({ 'message': index + '妈的', 'duration': 1 })
    },
    onchange: function (input) {
      modal.toast({'message': input.value, 'duration': 1})
      this.inputcontent = input.value
    },
    oninput: function (input) {
      this.inputcontent = input.value
    },
    customLoaded: function (params) {
      // const content = weex.requireModule('event').userinfo
       modal.toast({'message': params + '我靠', 'duration': 1})
      // weex.requireModule('event').weexSay('message_callback', (params) => {
      //   modal.toast({'message': params, 'duration': 1})
      // })
    },
    presentAction: function () {
      weex.requireModule('event').weexSay('message_callback', (params) => {
        modal.toast({'message': params, 'duration': 1})
      })
    },
    pushOnePage: function () {
      this.$router.push("/helloworld")
    },
    minibarLeftButtonClick () {
      console.log('minibarLeftButtonClick')
    },
    minibarRightButtonClick () {
      const num = this.tabTitles[2].badge
      this.tabTitles[2].badge = num + 1
      // weex.requireModule("event").weexSay("hello Weex")
      // weex.requireModule("event").weexSay("hello Weex222")
      // const fff = weex.requireModule('event')
      console.log(fff.params)
      // weex.requireModule('event').weexSay('message_callback', (params) => {
      //   modal.toast({'message': params, 'duration': 1})
      // })
      const b = weex.requireModule("event").callbacktest("hello Weex")
      // this.$call("event", "weexSay", "Hello, Weex!");//event注册的关键字
      // this.compnentname.weexSay('this is callback')
      modal.toast({ 'message': 'click rightButton!lllxx' + b, 'duration': 1 })
    },
    updatedidload () {
      modal.toast({ 'message': 'updatedidloadupdatedidload', 'duration': 1 })
    },
    fixtest (params) {
      modal.toast({ 'message': params, 'duration': 1 })
      weex.requireModule("event").weexSay("fixtestfixtestfixtest")
    }
  }
}
</script>

<style scoped>
.item-container {
  width: 750px;
  background-color: #ff2222;
  align-items: flex-start;
  justify-content: flex-start;
}
.wrapper{
  }
  .iconfont {
    font-family:iconfont;
  }
  .main-list{
    position: static;
    top: 91px;
    left: 0;
    right: 0;
  }
  .textfont {
    background-color: blueviolet;
    font-size: 70px;
    color: blue;
  }
  .presentCls {
    background-color: bisque;
    width: auto;
    height: 44px;
    margin-top: 10px;
  }
  .input {
    font-size: 60px;
    height: 80px;
    width: 750px;
  }
</style>
