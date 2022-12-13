import { createRouter, createWebHistory } from 'vue-router'
import { message } from 'ant-design-vue';
// 1. 定义路由组件.
// 也可以从其他文件导入

// 2. 定义一些路由
// 每个路由都需要映射到一个组件。
// 我们后面再讨论嵌套路由。
const routes = [
    {
        path: '/login',
        name: 'login',
        component: () => import('@/components/LoginForm.vue'),
        meta: {
            title: '登录页面',
            // requireAuth: true,
            transition_enter: 'animate__fadeInRight',
            transition_leave: 'animate__fadeOutLeft',
        },
    },
    {
        path: '/student/VisiterInfo',
        name: 'VisiterInfo',
        component: () => import('@/components/Student/VisiterInfo.vue'),
        meta: {
            title: '来访信息',
            requireAuth: true,
            transition_enter: 'animate__fadeInRight',
            transition_leave: 'animate__fadeOutLeft',
        },
    },
    {
        path: '/student/BaseInfo',
        name: 'BaseInfo',
        component: () => import('@/components/Student/BaseInfo.vue'),
        meta: {
            title: '学生基本信息',
            requireAuth: true,
            transition_enter: 'animate__fadeInRight',
            transition_leave: 'animate__fadeOutLeft',
        },
    },
    {
        path: '/student/LeaveInfo',
        name: 'LeaveInfo',
        component: () => import('@/components/Student/LeaveInfo.vue'),
        meta: {
            title: '出入基本信息',
            requireAuth: true,
            transition_enter: 'animate__fadeInRight',
            transition_leave: 'animate__fadeOutLeft',
        },
    },
    {
        path: '/admin',
        name: 'AdminManager',
        component: () => import('@/components/AdminManager.vue'),
        meta: {
            title: '管理员管理',
            requireAuth: true,
            transition_enter: 'animate__fadeInRight',
            transition_leave: 'animate__fadeOutLeft',
        },
    },
    {
        path: '/status/404',
        name: 'status404',
        component: () => import('@/components/status/404Component.vue'),
        meta: {
            title: '404',
            transition_enter: 'animate__fadeInRight',
            transition_leave: 'animate__fadeOutLeft',
        },
    },
    {
        path: '/status/403',
        name: 'status403',
        component: () => import('@/components/status/403Component.vue'),
        meta: {
            title: '403',
            transition_enter: 'animate__fadeInRight',
            transition_leave: 'animate__fadeOutLeft',
        },
    }
]

// 3. 创建路由实例并传递 `routes` 配置
// 你可以在这里输入更多的配置，但我们在这里a
// 暂时保持简单

const router = createRouter({
    // 4. 内部提供了 history 模式的实现。为了简单起见，我们在这里使用 hash 模式。
    history: createWebHistory(),
    base: '/Dormitory/',
    routes // `routes: routes` 的缩写
})

const list = ['admin']
router.beforeEach((to, from, next) => {
    //to 目标路由
    //from 来源
    //next 放行

    //如果需要验证，首页守卫
    if (to.meta.requireAuth) {
        //vuex仓库中的信息是否存在
        if (sessionStorage.getItem('manager')) {
            //   setting/article
            if (list.includes(to.path.split('/')[1])) {
                if (JSON.parse(sessionStorage.getItem('manager')).type == 0) {
                    next()
                } else {
                    message.warning('您没有权限，请向管理员申请');
                }
            } else {
                next()
            }
        } else {
            //拦截路由
            message.warning('您没有权限，请先登录');
            next('/')
        }
    } else {//不需要验证，直接放行
        next()
    }
})

export default router