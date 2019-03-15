<template>
  <div class="body">
    <text>{{message}}</text>
  </div>
</template>

<script>
export default {
  data () {
    return {
      msg: 'message'
    }
  }
}
</script>

<style scoped>
.body {
  flex: 1;
  background-color: lightgray;
}
</style>
