# <center> 这里介绍 Android 和 iOS 可能遇见的共同坑

## 界面中的安全区问题
  所有的 temple 的第一个组件最好使用 scroller 标签，这样可以避免安全区问题，如下：

    <template>
      <scroller>
        .....
      </scroller> 
    </template>
  
  错误示范，如下：(注：这样，布局超出，可能将无法显示)

      <template>
        <div>
          .....
        </div> 
      </template>


## v-if
  1. 在使用这个方法控制界面的隐藏和显示的时候，在 temple 中是完全没有问题的。
  2. 在 temple 中 某个 div 使用这个方法的时候，可能只是看不见这个界面，但事实，div 还存在于当前界面。
  3. 需要用 class 去控制 div 的显示和隐藏，并且 设置 visible 为响应的值。注意：visble 设置以后，不对自动取消，所以代码应该如下：

         <div calss="['to-visible', toShow ? 'to-visible' : 'to-hide']">
         .to-visible {
           .....
           viiblse: true;
         }
         .to-hide {
           .....
           visible: false;
         }

