<template>
  <div class="wrapper">
    <!-- <div class="app-header">
      <image :src="logo" class="logo" />
      <text class="greeting">The environment is ready!</text>
    </div> -->
    <div class="app-content">
      <tabbrar-controlle/>
    </div>
    <!-- <custom-first></custom-first> -->
  </div>
</template>

<script>
import First from './components/First'
import controller from './components/controller'

export default {
  name: 'App',
  data () {
    return {
      logo:
        'http://imgsrc.baidu.com/imgad/pic/item/c75c10385343fbf2a657d605ba7eca8065388f98.jpg'
    }
  },
  components: {
    'custom-first': First,
    'tabbrar-controlle': controller
  }
}
</script>

<style scoped>
.wrapper {
  background-color: #222222;
  justify-content: left;
  align-items: left;
  width: 100%;
  height: 100%;
}
.app-header {
  background-color: #41b883;
}
.app-content {
  width: 100%;
  height: 100%;
  background-color: antiquewhite;
}
.logo {
  width: 424px;
  height: 200px;
}
.greeting {
  text-align: center;
  margin-top: 70px;
  font-size: 50px;
  color: #41b883;
}
.message {
  margin: 30px;
  font-size: 32px;
  color: #727272;
}
</style>
