<template>
  <div class="body">
    <web ref="rootWeb" class="web-cls" src="http://192.168.2.95:9003/#/" @storage="storageEvent"></web>
    <div class="button-cls" @click="postMessageToWeb"><text class="text-cls"> postmessageToWebgg</text></div>
  </div>
</template>

<script>
const storage = weex.requireModule('storage')
export default {
  name: 'WKWebView',
  data () {
    return {
      msg: 'message'
    }
  },
  methods: {
    postMessageToWeb () {
      this.$refs.rootWeb.postMessage({module, event, params: {info: 'success'}})
    },
    storageEvent ({reqId, module, event, params}) {
      console.log(reqId + '++++' + module + '++++' + event + '++++' + JSON.stringify(params) + '++++')
      if (event === 'setItem') {
        for (var key in params) {
          console.log('**************')
          console.log(key, params[key])
          storage.setItem(
            key,
            params[key],
            event => {
              console.log('set success')
            })
        }

        this.$refs.rootWeb.postMessage({
          module,
          event,
          reqId,
          params: {
            info: 'success'
          }
        })
      }
      if (event === 'getItem') {
        const _event = event
        const _key = params
        const _params = {}
        storage.getItem(params, event => {
          console.log('get value:', event.data)
          _params[_key] = event.data
          const xxxx = {
            module,
            reqId,
            event: _event,
            params: _params
          }
          this.$refs.rootWeb.postMessage(xxxx)
        })
      }
    }
  }
}
</script>

<style scoped>
.body {
}

.web-cls {
  background-color: red;
  height: 800px;
}

.button-cls {
  background-color: green;
  justify-content: center;
  height: 80wx;
}

.text-cls {
  background-color: red;
  font-size: 16wx;
}
</style>
