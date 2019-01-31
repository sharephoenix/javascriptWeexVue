<template>
  <slider class="slider" auto-play="true" interval="5000" @change="onchange">
    <div class="frame" v-for="(img) in imageList" :key="img.title">
      <image class="image" resize="cover" :src="img.src"></image>
    <div><textarea placeholder="aaaaaaaa"/></div>
    </div>
    <indicator class="indicator"></indicator>
  </slider>
</template>

<script>
export default {
  props: ['imageList'],
  data () {
    return {
      testimagurl: 'http://app.kuitao8.com/images/banner/3.jpg'
    }
  },
  methods: {
    onchange (event) {
      console.log('event on change')
    }
  },
  computed: {
    mageBanners: function () {
      return this.props['imageList']
    }
  }
}
</script>

<style scoped>
.iconfont {
    font-family:iconfont;
  }
  .image {
    width: 750px;
    height: 430px;
    background-color: aqua;
  }
  .slider {
    width: 750px;
    height: 430px;
  }
  .frame {
    width: 750px;
    height: 430px;
    position: relative;
    background: #b4282d;
  }
  .indicator {
    width: 750px;
    height: 40px;
    item-color: white;
    item-selected-color: #b4282d;
    item-size: 12px;
    position: absolute;
    bottom: 10px;
    right: 0px;
  }
</style>
