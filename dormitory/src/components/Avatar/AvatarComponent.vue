<template>
    <!-- <div style="background: #ececec; padding: 0px"> -->
    <a-card size="small" style="width: 200px;" hoverable="true">
        <div style="background: #ececec;">
            <a-avatar shape="circle" :size="48" :src="userInfo.url">
                <template #icon>
                    <UserOutlined />
                </template>
            </a-avatar>
            <span>{{ userInfo.username }}</span><br/>
            <p style="margin-top:10px">{{ userInfo.Motto}}</p>
            <a-button type="primary" @click="logout()">退出</a-button><br>
        </div>
    </a-card>
    <NotificationComponent ref="openNotification"></NotificationComponent>
    <!-- </div> -->
</template>

<script>
import { defineComponent, reactive,ref } from 'vue';
import NotificationComponent from '../tools/NotificationComponent.vue';
import { useStore } from 'vuex' // 引入useStore 方法
import { useRouter } from 'vue-router'
export default defineComponent({
    name: 'AvatarComponent',
    components: {
        NotificationComponent,
    },
    setup(props) {
        const store = useStore()
        const router = useRouter()
        const openNotification = ref()

        const userInfo = reactive({
            username: store.state.user.name,
            url: 'http://q1.qlogo.cn/g?b=qq&nk=1437487442&s=100',
            Motto: '即使再小的帆也能远航',
        })

        const logout = ()=>{
            sessionStorage.removeItem('manager')
            store.state.isCertified = false
            props.changeLogin()
            openNotification.value.openNotificationWithIcon('success', '成功', '恭喜退出成功')
            router.push('/login')
        }

        return {
            userInfo,
            openNotification,
            logout,
        };
    },
    props: {
        changeLogin: {
            type: Function,
            default: ()=>{},
        },
    }
});
</script>