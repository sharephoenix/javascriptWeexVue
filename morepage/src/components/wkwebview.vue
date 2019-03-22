<template>
  <div class="body">
    <div class="web-cls">
      <web ref="rootWeb" class="web-cls" src="http://192.168.3.165:9003/#/" @storage="storageEvent"></web>
    </div>
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
    storageEvent ({reqId, module, event, params, callback}) {
      const _self = this
      console.log(reqId + '++++' + module + '++++' + event + '++++' + JSON.stringify(params) + '++++')
      console.log('*****' + JSON.stringify(callback))
      if (event === 'setItem') {
        for (var key in params) {
          console.log('**************')
          console.log(key, params[key])
          storage.setItem(
            key,
            params[key],
            event => {
              console.log('begin callback')
              if (callback !== undefined) {
                callback(event)
              } else {
                _self.$refs.rootWeb.callback(Object.assign(event, {'reqId': reqId}))
              }
              console.log('set success')
            })
        }
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
          if (callback !== undefined) {
            callback(xxxx)
          } else {
            console.log('begin callback')
            _self.$refs.rootWeb.callback(Object.assign(xxxx, {'reqId': reqId}))
          }
        })
      }
    }
  }
}
</script>

<style scoped>
.body {
  flex-direction: center;
  justify-content: space-between;
}

.web-cls {
  /* flex: 1; */
  background-color: red;
  height: 500wx;
}

.button-cls {
  position: absolute;
  bottom: 0wx;
  left: 0wx;
  right: 0wx;
  background-color: green;
  justify-content: center;
  height: 80wx;
}

.text-cls {
  background-color: red;
  font-size: 16wx;
}
</style>
