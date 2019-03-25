<template>
  <div class="body">
    <div class="web-cls">
      <web ref="rootWeb" class="web-cls" src="https://sharephoenix.github.io/blog/main/#/" @storage="storageEvent" @XHBAudioPlayerModule="XHBAudioPlayerModule" @XHBNetworkModule="XHBNetworkModule"></web>
      <!-- <web ref="rootWeb" class="web-cls" src="http://192.168.0.102:9003/#/" @storage="storageEvent" @XHBAudioPlayerModule="XHBAudioPlayerModule" @XHBNetworkModule="XHBNetworkModule"></web> -->
    </div>
    <scroller class="log-cls"><text>{{log}}</text></scroller>
    <div class="button-cls" @click="postMessageToWeb">
      <text class="text-cls"> postmessageToWebgg</text>
    </div>
  </div>
</template>

<script>
const storage = weex.requireModule('storage')
const XHBAudioPlayerModule = weex.requireModule('XHBAudioPlayerModule')
const XHBNetworkModule = weex.requireModule('XHBNetworkModule')
export default {
  name: 'WKWebView',
  data () {
    return {
      msg: 'message',
      log: ''
    }
  },
  methods: {
    XHBNetworkModule ({reqId, module, event, params}) {
      this.log = JSON.stringify(params)
      const _self = this
      XHBNetworkModule.requestData(params, (callback) => {
        this.log = JSON.stringify(callback)
        _self.$refs.rootWeb.callback(Object.assign(event, {'reqId': reqId}, {body: callback}))
      })
    },
    XHBAudioPlayerModule ({reqId, module, event, params}) {
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
      if (event === 'registerStateSignal') {
        const _self = this
        XHBAudioPlayerModule.registerStateSignal((params) => {
          _self.log = JSON.stringify(params)
          // 需要调用一次，否则会有内存泄漏，iOS 目前做了容错机制
          // _self.$refs.rootWeb.callback(Object.assign(event, {'reqId': reqId}, {body: params}))
          _self.$refs.rootWeb.postMessage({module, event, params: params})
        })
      }
    },
    postMessageToWeb () {
      this.$refs.rootWeb.postMessage({module, event, params: {info: 'success'}})
    },
    storageEvent ({reqId, module, event, params}) {
      const _self = this
      if (event === 'setItem') {
        for (var key in params) {
          storage.setItem(
            key,
            params[key],
            event => {
              console.log('begin callback')
              _self.$refs.rootWeb.callback(Object.assign(event, {'reqId': reqId}))
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
            body: _params
          }
          this.log = xxxx
          _self.$refs.rootWeb.callback(Object.assign(xxxx, {'reqId': reqId}))
        })
      }
    }
  }
}
</script>

<style scoped>
.body {
  flex-direction: column;
  justify-content: flex-start;
  background-color: aquamarine;
}

.web-cls {
  flex: 1;
  background-color: red;
  /* height: 600wx; */
}

.button-cls {
  background-color: white;
  justify-content: center;
  height: 80wx;
  border-radius: 3wx;
}

.text-cls {
  color: black;
  font-size: 16wx;
  text-align: center;
}
.log-cls {
  background-color: orchid;
  height: 60wx;
}
</style>
