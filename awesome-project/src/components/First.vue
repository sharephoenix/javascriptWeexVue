<template>
  <div class="rootDiv">
    <text class="contentcls"> this is first view</text>
    <fragment1 styles="{width:100%;height:33px;}"></fragment1>
    <tabbrar-controlle></tabbrar-controlle>
  </div>
</template>

<script>
import controller from './controller'
import fragment1 from './fragment1'
export default {
  name: 'tabar',
  data () {
    return {
      name: 'tabar'
    }
  },
  components: {
    'tabbrar-controlle': controller,
    'fragment1': fragment1
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
