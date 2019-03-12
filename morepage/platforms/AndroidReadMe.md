# <center> 这里介绍 android 遇见的坑

## focus() and blur() 
这两个方法分别是吊起 input 等输入框的 的方法，和取消 input 等输入框收齐键盘的事件方法。
由于在 android 中收起键盘时，输入框可能还是第一响应者，所以在，使用 event 换气 输入框的键盘时候需要如下操作：

    this.$refs.input.blur()
    this.$refs.input.focus()

发现某些机型这样写也是有 bug 的，太难了！！！！
原因：不断点解 上面 代码，发现 有键盘 和 无键盘之间相互切换。目前没有发现有太大的问。
