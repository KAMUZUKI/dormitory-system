import { createStore } from 'vuex'

const store = createStore({
  state () {
    return {
      msg:'Hello Vuex',
      isLogin: false,
      isCertified:false,
      // path:'http://localhost:8080/Dormitory',     
      path:'http://kamuzuki.top:8080/dormitory-system',
      // path:'http://localhost:8081/demo',
      keywords:[],
    }
  },
  mutations: {
    increment (state) {
      state.count++
    }
  }
})

export default store