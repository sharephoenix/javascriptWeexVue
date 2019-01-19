/* global Vue */
import Router from 'vue-router'
import First from '@/components/First'
import HelloWorld from '@/components/HelloWorld'
import Fragment1 from '@/components/fragment1'
import Fragment2 from '@/components/fragment2'
import Fragment3 from '@/components/fragment3'
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
    },
    {
      path: '/fragment1',
      name: 'fragment1',
      component: Fragment1
    },
    {
      path: '/fragment2',
      name: 'fragment2',
      component: Fragment2
    },
    {
      path: '/fragment3',
      name: 'fragment3',
      component: Fragment3
    }
  ]
})
