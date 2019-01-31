/* global Vue */
import Router from 'vue-router'
// import HelloWorld from '@/components/HelloWorld'
import WeexTabbar from '@/components/WeexTabbar'
Vue.use(Router)

export const router = new Router({
  routes: [
    {
      path: '/',
      name: 'WeexTabbar',
      component: WeexTabbar
    }
  ]
})
