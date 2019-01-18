import Vue from 'vue'
/* global Vue */
import Router from 'vue-router'
import First from '@/components/First'
import HelloWorld from '@/components/HelloWorld'

Vue.use(Router)

export const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/helloworld',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/',
      name: 'First',
      component: First
    }
  ]
})
