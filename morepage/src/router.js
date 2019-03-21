/* global Vue */
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import WKWebView from '@/components/wkwebview'

Vue.use(Router)
export const router = new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld,
      redirect: '/wkwebview'
    },
    {
      path: '/wkwebview',
      name: 'WKWebView',
      component: WKWebView
    }
  ]
})
