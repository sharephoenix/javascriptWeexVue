import Vue from 'vue'
/* global Vue */
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import First from '@/components/First'
import Fragment1 from '@/components/fragment1'
import Fragment2 from '@/components/fragment2'
import Fragment3 from '@/components/fragment3'
Vue.use(Router)

export const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'First',
      component: First
    },
    {
      path: '/helloworld',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/fragment1',
      name: 'Fragment1',
      component: Fragment1
    },
    {
      path: '/fragment2',
      name: 'Fragment2',
      component: Fragment2
    },
    {
      path: '/fragment3',
      name: 'Fragment3',
      component: Fragment3
    }
  ]
})
