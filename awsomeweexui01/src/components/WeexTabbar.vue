<template>
  <wxc-tab-bar
    :tab-titles="tabTitles"
    :tab-styles="tabStyles"
    title-type="icon"
    @wxcTabBarCurrentTabSelected="wxcTabBarCurrentTabSelected"
  >
    <!-- 第一个页面内容-->
    <!-- <div class="item-container" :style="contentStyle">
        <wxc-minibar
          title="首页"
          background-color="#009ff0"
          text-color="#FFFFFF"
          right-text="更多"
          @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
          @wxcMinibarRightButtonClicked="minibarRightButtonClick"
        ></wxc-minibar> -->

        <scroller class="main-list">
      <!-- 轮播图 -->
          <kx-slider :imageList="Banners"></kx-slider>
          <customview style="width:400px;height:200px;" @customLoaded="customLoaded"></customview>
        </scroller>
    </div>

    <!-- 第二个页面内容-->
    <div class="item-container" :style="contentStyle">
      <wxc-minibar
          title="推荐"
          background-color="#ffffff"
          text-color="#000000"
          right-text="更多"
          @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
          @wxcMinibarRightButtonClicked="minibarRightButtonClick"
        ></wxc-minibar>
      <text>特别推荐</text>
    </div>

    <!-- 第三个页面内容-->
    <div class="item-container" :style="contentStyle">
      <wxc-minibar
          title="消息"
          background-color="#ffffff"
          text-color="#000000"
          right-text="更多"
          @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
          @wxcMinibarRightButtonClicked="minibarRightButtonClick"
        ></wxc-minibar>
      <text>消息中心</text>
    </div>

    <!-- 第四个页面内容-->
    <div class="item-container" :style="contentStyle">
      <wxc-minibar
          title="我的主页"
          background-color="#ffffff"
          text-color="#000000"
          right-text="更多"
          @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
          @wxcMinibarRightButtonClicked="minibarRightButtonClick"
        ></wxc-minibar>
        <text>{{title}}</text>
      <text>{{title}} ==我的</text>
    </div>
  </wxc-tab-bar>
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
    tabTitles: Config.tabTitles,
    tabStyles: Config.tabStyles,
    Banners: [
      {title: '1', src: 'http://app.kuitao8.com/images/banner/1.jpg'},
      {title: '2', src: 'http://app.kuitao8.com/images/banner/2.jpg'},
      {title: '3', src: 'http://app.kuitao8.com/images/banner/3.jpg'}],
    testimagurl: 'http://app.kuitao8.com/images/banner/3.jpg',
    title: 'title'
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
      modal.toast({ 'message': index, 'duration': 1 })
    },
    customLoaded: function (params) {
      console.log('===========' + JSON.stringify(params))
      modal.toast({'message': JSON.stringify(params), 'duration': 1})
    },
    // updateHandler : function(e){
    // //千万记得这句（先在外部声明),不能在回调中直接使用this.function(),不然不执行
    // var self = this;
    // var eventModule = require('@weex-module/event'); 

    //   eventModule.openURL('test.js',function(ret) { 
    //                     //回调执行
    //     self.loadVersionData(ret.result);
                      

    //   });
    // },
    minibarLeftButtonClick () {
      console.log('minibarLeftButtonClick')
    },
    minibarRightButtonClick () {
      const num = this.tabTitles[2].badge
      this.tabTitles[2].badge = num + 1
      // weex.requireModule("event").weexSay("hello Weex")
      // weex.requireModule("event").weexSay("hello Weex222")
      const fff = weex.requireModule('event')
      console.log(fff.params)
      weex.requireModule('event').weexSay('message_callback', (params) => {
        modal.toast({'message': params, 'duration': 1})
      })
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
</style>
