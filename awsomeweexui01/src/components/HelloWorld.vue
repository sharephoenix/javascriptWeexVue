<template>
  <div>
  <text class="presentCls">Nothings</text>
  <text class="presentCls" @click="popAction"> pop Page</text>
  </div>
</template>

<script>
const modal = weex.requireModule('modal')
export default {
  name: 'HelloWorld',
  data: () => ({
    modulename: 'modulename'
  }),
  methods: {
    popAction: function () {
      this.$router.go(-1)
      modal.toast({ 'message': '返回上一界面成功', 'duration': 1 })
    }
  },
  watch: {
    '$router' () {
      this.pop = true
      modal.toast({ 'message': 'router watch 变化了', 'duration': 1 })
    }
  }
}
</script>

<style scoped>
.presentCls {
    background-color: bisque;
    width: auto;
    height: 44px;
    margin-top: 10px;
  }
</style>
