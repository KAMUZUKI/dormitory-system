<template>
    <LayoutFramework :changeLogin="changeLogin" v-if="isLogin"></LayoutFramework>
    <LoginForm :changeLogin="changeLogin" v-if="!isLogin"></LoginForm>
</template>

<script>
import {defineComponent,ref } from 'vue';
import LayoutFramework from '@/components/LayoutFramework.vue';
import LoginForm from '@/components/LoginForm.vue'
import { useStore } from 'vuex' // 引入useStore 方法
export default defineComponent({
    name: "MainFramework",
    setup() {
        const store = useStore();
        const isLogin = ref(false);
        const changeLogin = ()=>{
            isLogin.value = !isLogin.value
        }
        store.isCertified = true
        return {
            isLogin,
            changeLogin,
        }
    },
    components: {
        LayoutFramework,
        LoginForm
    }
})
</script>