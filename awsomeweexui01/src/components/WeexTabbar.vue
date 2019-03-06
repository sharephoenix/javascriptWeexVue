<template>
  <div class="body">
    <div class="top"><text class="text">1</text></div>
    <div class="content">content</div>
     <div class="bottom"><text class="text">1</text></div>
     
  </div>
</template>

<style scoped>
.body {
  display: flex;
  flex-direction: column;
  align-items: stretch;
  justify-content: space-between;
  position: relative;
  background-color: red;
  border-color: blue;
  border-width: 2px;
}
  .panel {
    width: 600px;
    height: 250px;
    margin-left: 75px;
    margin-top: 35px;
    margin-bottom: 35px;
    flex-direction: column;
    justify-content: center;
    border-width: 2px;
    border-style: solid;
    border-color: rgb(162, 217, 192);
    background-color: rgba(162, 217, 192, 0.2);
  }
  .text {
    font-size: 100px;
    text-align: center;
    color: #41B883;
  }
 .top {
   top: 0px;
   background-color: blue;
 }
 .content {
   margin-bottom: 0px;
   margin-top: 10px;
   flex: 1;
   margin-bottom: 10px;
   background-color: aqua;
 }
 .bottom {
   background-color: yellow;
 }
</style>
