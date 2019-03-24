<template>
  <scroller class="body">
    <div @click="toStorageAndAudio"><text>测试 storage 和 播放器调用</text></div>
    <div @click="toApi"><text>测试 api 调用</text></div>
  </scroller>
</template>

<script>
export default {
  name: 'Main',
  data () {
    return {
    }
  },
  methods: {
    toStorageAndAudio () {
      this.$router.push('/wkwebview')
    },
    toApi () {
      this.$router.push('/')
    }
  },
  created () {
  }
}
</script>
<style scoped>
.body {
}
  .button-cls {
    background-color: green;
    justify-content: center;
    height: 80wx;
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
