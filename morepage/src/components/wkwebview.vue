<template>
  <div class="body">
    <div class="web-cls">
      <web ref="rootWeb" class="web-cls" src="http://192.168.3.165:9003/#/" @storage="storageEvent" @XHBAudioPlayerModule="XHBAudioPlayerModule"></web>
    </div>
    <div class="button-cls" @click="postMessageToWeb"><text class="text-cls"> postmessageToWebgg</text></div>
  </div>
</template>

<script>
const storage = weex.requireModule('storage')
const XHBAudioPlayerModule = weex.requireModule('XHBAudioPlayerModule')
export default {
  name: 'WKWebView',
  data () {
    return {
      msg: 'message'
    }
  },
  methods: {
    XHBAudioPlayerModule ({reqId, module, event, params, callback}) {
      if (event === 'play') {
        XHBAudioPlayerModule.play(params)
        return
      }
      if (event === 'pause') {
        XHBAudioPlayerModule.pause()
      }
      if (event === 'resume') {
        XHBAudioPlayerModule.resume()
      }
      if (event === 'stop') {
        XHBAudioPlayerModule.stop()
      }
      if (event === 'next') {
        XHBAudioPlayerModule.next()
      }
      if (event === 'last') {
        XHBAudioPlayerModule.last()
      }
    },
    postMessageToWeb () {
      this.$refs.rootWeb.postMessage({module, event, params: {info: 'success'}})
    },
    storageEvent ({reqId, module, event, params, callback}) {
      const _self = this
      if (event === 'setItem') {
        for (var key in params) {
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
