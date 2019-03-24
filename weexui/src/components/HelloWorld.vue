<template>
<div class="body">
  <wxc-tab-bar class="tab-cls" :tab-titles="tabTitles"
               :tab-styles="tabStyles"
               title-type="icon"
               @wxcTabBarCurrentTabSelected="wxcTabBarCurrentTabSelected">
    <!-- 第一个页面内容-->
    <div class="item-container" :style="contentStyle">
      <wxc-minibar class="nav-cls" title="标题"
                   background-color="#009ff0"
                   text-color="#FFFFFF"
                   right-text="更多"
                   @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
                   @wxcMinibarRightButtonClicked="minibarRightButtonClick">

                   </wxc-minibar>
      <text>首页dd</text></div>

    <!-- 第二个页面内容-->
    <div class="item-container" :style="contentStyle"><text>特别推荐</text></div>

    <!-- 第三个页面内容-->
    <div class="item-container" :style="contentStyle"><text>消息中心</text></div>

    <!-- 第四个页面内容-->
    <div class="item-container" :style="contentStyle"><text>我的主页</text></div>
  </wxc-tab-bar>
</div>
</template>

<script>
import { WxcTabBar, WxcMinibar, Utils } from 'weex-ui'

// https://github.com/alibaba/weex-ui/blob/master/example/tab-bar/config.js
import Config from './config'

export default {
  components: { WxcTabBar, WxcMinibar },
  data: () => ({
    tabTitles: Config.tabTitles,
    tabStyles: Config.tabStyles
  }),
  created () {
    const tabPageHeight = Utils.env.getPageHeight()
    // 如果页面没有导航栏，可以用下面这个计算高度的方法
    // const tabPageHeight = env.deviceHeight / env.deviceWidth * 750;
    const { tabStyles } = this
    this.contentStyle = { height: (tabPageHeight - tabStyles.height) + 'px' }
  },
  methods: {
    wxcTabBarCurrentTabSelected (e) {
      // const index = e.page
      // console.log(index);
    }
  }
}
</script>

<style scoped>
.body {
  flex: 1;
  justify-content: flex-start;
  background-color: green;
}
  .item-container {
    width: 750px;
    background-color: #f2f3f4;
    align-items: flex-start;
    justify-content: flex-start;
  }
  .nav-cls {
    /* width: 64wx;
    height: 64wx; */
  }
  .tab-cls {
    justify-content: flex-start;
    align-items: flex-start;
  }
</style>
