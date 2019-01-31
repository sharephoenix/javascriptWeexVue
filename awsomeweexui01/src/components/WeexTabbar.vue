<template>
  <wxc-tab-bar
    :tab-titles="tabTitles"
    :tab-styles="tabStyles"
    title-type="icon"
    @wxcTabBarCurrentTabSelected="wxcTabBarCurrentTabSelected"
  >
    <!-- 第一个页面内容-->
    <div class="item-container" :style="contentStyle">
        <wxc-minibar
          title="首页"
          background-color="#009ff0"
          text-color="#FFFFFF"
          right-text="更多"
          @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
          @wxcMinibarRightButtonClicked="minibarRightButtonClick"
        ></wxc-minibar>

        <scroller class="main-list">
      <!-- 轮播图 -->
          <kx-slider :imageList="Banners"></kx-slider>
        </scroller>
    </div>

    <!-- 第二个页面内容-->
    <div class="item-container" :style="contentStyle">
      <wxc-minibar
          title="推荐"
          background-color="#009ff0"
          text-color="#FFFFFF"
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
          background-color="#F2F2F2"
          text-color="#FFFFFF"
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
          background-color="#009ff0"
          text-color="#FFFFFF"
          right-text="更多"
          @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
          @wxcMinibarRightButtonClicked="minibarRightButtonClick"
        ></wxc-minibar>
        <text>首页</text>
      <text>我的主页</text>
    </div>
  </wxc-tab-bar>
</template>

<script>
import { WxcTabBar, WxcMinibar, Utils } from 'weex-ui'
import Slider from './Slider.vue'
// https://github.com/alibaba/weex-ui/blob/master/example/tab-bar/config.js
import Config from './config'
const modal = weex.requireModule('modal')

export default {
  name: 'WeexTabbar',
  components: {
    WxcTabBar,
    WxcMinibar,
    'kx-slider': Slider
  },
  data: () => ({
    tabTitles: Config.tabTitles,
    tabStyles: Config.tabStyles,
    Banners: [
      {title: '1', src: 'http://app.kuitao8.com/images/banner/1.jpg'},
      {title: '2', src: 'http://app.kuitao8.com/images/banner/2.jpg'},
      {title: '3', src: 'http://app.kuitao8.com/images/banner/3.jpg'}],
    testimagurl: 'http://app.kuitao8.com/images/banner/3.jpg'
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
    minibarLeftButtonClick () {
      console.log('minibarLeftButtonClick')
    },
    minibarRightButtonClick () {
      modal.toast({ 'message': 'click rightButton!', 'duration': 1 })
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
