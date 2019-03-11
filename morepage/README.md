# <center>需要的技术栈</center>

## Java

## Kotlin

## Objective-C

## Swift

## JavaScript

## Css and Scss

## Vue webpack
### 如何设置，多界面

------------

# 注： 使用 各种 lint 规范代码，做到能当众写代码 而不是 面向浏览器编程

## <center> weex 一般注意事项
  1. weex 的所有布局都是 flexbox 进行布局的。
  2. weex position: flex;  会超过安全区的。一般建议使用 asbolute.
  3. weex 的 image 组件需要各平台实现缓存方法。
  4. weex 所有的 css 布局相关的参数 使用 'wx' 而不是 'px'。 例如：width: 10wx; 不要写成 10px; / font-size: 16wx;不要写成 font-size: 16px;