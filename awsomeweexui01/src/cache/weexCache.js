const storage = weex.requireModule('storage')

const WeexStore = storage

const saveData = function ({key, value}) {
  WeexStore.setItem(key, value, event => {
    console.log('cache success')
  })
}

const getData = (key, callback) => {
  WeexStore.getItem(key, event => {
    if (event.result === 'success' && event.data) {
      const result = {result: true, data: event.data}
      callback(result)
    } else {
      const result = {result: false, data: event.data}
      callback(result)
    }
  })
}
export default {saveData, getData}
