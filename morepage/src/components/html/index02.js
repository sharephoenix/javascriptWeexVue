window.onload = function () {
//   // document.body.addEventListener('mousewheel', disableScroll)
//   // document.body.addEventListener('DOMMouseScroll', disableScroll)
//   // document.body.addEventListener('touchmove', disableScroll)
//   // var evt = document.createEvent("HTMLEvents");
//   // var customEvent = new MessageEvent('message', 'options');
// }
/**************WKWebview***************/
// alert('index.js loaded')
function diaoAndroid() {
    var result = window.android.back({title:"测试标题",content:"测试分享",url:"html://www.baidu.com"});
    document.getElementById("anniu2").innerHTML=result;
}
function diaoIos() {
  // window.webkit.alert('test iOS');
    var results2 = window.webkit.messageHandlers.message.postMessage({title:"测试标题",content:"测试分享",url:"html://www.baidu.com"});
    document.getElementById("anniu").innerHTML=result2;
}

// <script language="javascript">

//JS执行window.webkit.messageHandlers.message.postMessage(<messageBody>)
function shareClick() {
  // alert('assdfads')
    window.webkit.messageHandlers.message.postMessage({title:'测试分享的标题',content:'测试分享的内容',url:'https://github.com/maying1992'});
}

//分享回调结果显示
function shareResult(channel_id,share_channel,share_url) {
    var content = channel_id+","+share_channel+","+share_url;
    alert(content);
    document.getElementById("returnValue").value = content;
}

//JS执行window.webkit.messageHandlers.Camera.postMessage(<messageBody>)
function cameraClick() {
    window.webkit.messageHandlers.Camera.postMessage(null);
}

//调用相册回调结果显示
function cameraResult(result) {
    alert(result);
    document.getElementById("returnValue").value = result;
}
            // </script>


/**************WKWebview***************/

  // function postMessage(e) {
  // 向前段 post Message
  // window.postMessage({'message': 'messageContent'})
// }

// console.log(new MessageEvent('message'));

// window.addEventListener('MessageEvent', function (e) { 
//   alert("asdfasdf");
// }, false);

// function alertgs() {
//   alert('test');
// }

function postMessageToNative() {
  // 向前段 post Message
  window.alert("aaaaa");
  // window.postMessage({'params01': 'params011111',
  //                   'params02': 'params02222'}, 'event');
}

function MessageEvent(e, data) {
  
  postMessageToNative();
}


// function disableScroll(e) {
//   e.preventDefault()
// }

// function init () {
//   formatData()
//   var scoreChart = document.getElementById('scoreChart')
//   scoreChart.style.height = parseInt((document.body.clientWidth * 210) / 375) + 'px'

//   var option = {
//     series: [
//       {
//         type: 'pie',
//         radius: ['60%', '70%'],
//         center: ['50%', '50%'],
//         label: {
//           normal: {
//             show: false,
//             position: 'center'
//           }
//         },
//         labelLine: {
//           normal: {
//             show: false
//           }
//         },
//         data: [
//           {
//             value: 1,
//             name: 'basic',
//             itemStyle: {
//               color: {
//                 type: 'linear',
//                 x: 0,
//                 y: 0,
//                 x2: 0,
//                 y2: 1,
//                 colorStops: [{
//                   offset: 0, color: '#ffc80a' // 0% 处的颜色
//                 }, {
//                   offset: 1, color: '#ffb300' // 100% 处的颜色
//                 }],
//                 global: false // 缺省为 false
//               }
//             }
//           }
//         ]
//       }
//     ]
//   }

//   drawChart(scoreChart, option)
// }

// function drawChart (el, option) {
//   var myChart = window.echarts.init(el)
//   myChart.setOption(option)
// }

// function formatData () {
//   var q = decodeURIComponent(window.location.search).substr(1)
//   var qs = q.split('&')
//   var score = 0
//   var desc = ''

//   qs.forEach(function (q) {
//     var arr = q.split('=')
//     switch (arr[0]) {
//       case 'score':
//         score = arr[1]
//         break
//       case 'desc':
//         desc = arr[1]
//         break
//     }
//   })

//   document.getElementById('score').innerHTML = score
//   document.getElementById('desc').innerHTML = desc
// }


