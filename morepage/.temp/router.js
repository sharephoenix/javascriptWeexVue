import Vue from 'vue'
/* global Vue */
import Router from 'vue-router'
import Main from '@/components/Main'
import WKWebView from '@/components/wkwebview'

Vue.use(Router)
export const router = new Router({
  routes: [
    {
      path: '/',
      name: 'Main',
      component: Main,
      redirect: '/wkwebview'
    },
    {
      path: '/wkwebview',
      name: 'WKWebView',
      component: WKWebView
    }
  ]
})
