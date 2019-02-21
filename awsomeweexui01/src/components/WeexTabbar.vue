<template>
    <!-- 第一个页面内容-->
    <div class="item-container" :style="contentStyle" @viewappear="onViewappear">
          <div class="presentCls" v-on:click="presentAction"> {{present}} </div>
          <input type="text" class="input" value="" placeholder="输入自己想要的"  :autofocus=false @change="onchange" @input="oninput"/>
          <text> {{inputcontent}} </text>
          <div class="presentCls" v-on:click="fixtest"> <text> custompush </text></div>
          <div class="presentCls" v-on:click="pushOnePage"> {{ pushOnenPage }} </div>
          <div class="presentCls" v-on:click="popOnePage"> {{ popOnenPage }} </div>
          <div class="presentCls" v-on:click="showNewWeex"> {{ shownewweex }} </div>
          <web class="webContentCls" src="https://mp.weixin.qq.com/s/U8Ls0nCDkIlVLPgEgrHlaA"></web>
          <div class="presentCls" v-on:click="showNewWeex"> {{ shownewweex }} </div>
    </div>
</template>

<script>
import { WxcTabBar, WxcMinibar, Utils } from 'weex-ui'
import Slider from './Slider.vue'
var navigator = weex.requireModule('navigator')
// https://github.com/alibaba/weex-ui/blob/master/example/tab-bar/config.js
import Config from './config'
import AppCache from '../cache/weexCache.js'
const modal = weex.requireModule('modal')

var globalEvent = weex.requireModule('globalEvent');
globalEvent.addEventListener("geolocation", function (e) {
  modal.toast({ 'message': "get geolocation" + e, 'duration': 2 })
});

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
    popOnenPage: 'pop 一个页面',
    inputcontent: 'default',
    shownewweex: '启动 weex 小程序'
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
      navigator.push({
          url: 'http://192.168.1.117:8080/index.js',
          animated: "true"
        }, event => {
          modal.toast({ message: 'callback: ' + event })
        })
        navigator.setNavBarRightItem({titleColor: red, title: 'rightButton'})
      // this.$router.push("/helloworld")
    },
    popOnePage: function () {
      navigator.pop()
      // this.$router.push("/helloworld")
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
      weex.requireModule("event").showvc({url: 'http://192.168.1.117:8080/index.js'}, 'title')
    },
    showNewWeex (params) {
      modal.toast({'message': '我靠', 'duration': 1})
      weex.requireModule("event").showNewWeex({url: 'http://192.168.1.117:8080/index.js', title: 'title'})
    },
    onViewappear (params) {
      modal.toast({'message': '我靠 viewappear' + params, 'duration': 1})
    }
  },
  onViewappear (params) {
    modal.toast({'message': '我靠 viewappear' + params, 'duration': 1})
  }
}
</script>

<style scoped>
.item-container {
  width: 750px;
  background-color: #ff2222;
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
  .webContentCls {
    flex: 1;
    margin-top: 10px;
    width: 750px;
  }
</style>
