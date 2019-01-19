<template>
  <div class="rootDiv">
    <text class="contentcls"> this is first view</text>
    <tabbrar-controlle></tabbrar-controlle>
  </div>
</template>

<script>
import controller from './controller'

export default {
  name: 'tabar',
  data () {
    return {
      name: 'tabar'
    }
  },
  components: {
    'tabbrar-controlle': controller
  }
}
</script>

<style scoped>
.rootDiv {
  background-color: blue;
  width: 100%;
  height: 100%;
}
.contentcls {
  width: 100%;
  height: 200px;
  color: #ff0000;
  background-color: aqua;
}
</style>
