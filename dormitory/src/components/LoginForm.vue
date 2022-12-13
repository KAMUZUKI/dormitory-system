<template>
  <div class="container">
    <a-card class="box" bordered hoverable>
      <h1>学生公寓管理系统</h1>
    <a-form :model="formState" name="normal_login" class="login-form" @finish="onFinish" @finishFailed="onFinishFailed">
      <a-form-item style="margin-bottom:10px;" label="用户" name="username"
        :rules="[{ required: true, message: 'Please input your username!' }]">
        <a-input v-model:value="formState.username" style="border-radius:10px">
          <template #prefix>
            <UserOutlined class="site-form-item-icon" />
          </template>
        </a-input>
      </a-form-item>

      <a-form-item style="margin-bottom:10px;" label="密码" name="password"
        :rules="[{ required: true, message: 'Please input your password!' }]">
        <a-input-password v-model:value="formState.password" style="border-radius:10px">
          <template #prefix>
            <LockOutlined class="site-form-item-icon" />
          </template>
        </a-input-password>
      </a-form-item>

      <a-form-item style="margin-bottom:10px;">
        <a-form-item name="remember" no-style>
          <a-checkbox v-model:checked="formState.remember">记住</a-checkbox>
        </a-form-item>
        <a class="login-form-forgot" href="">忘记密码</a>
      </a-form-item>

      <a-form-item>
        <a-button :disabled="disabled" style="border-radius:10px" type="primary" html-type="submit"
          class="login-form-button" @click="login()">
          Log in
        </a-button>
        Or
        <a @click="showDrawer">register now!</a>
      </a-form-item>
    </a-form>
  </a-card>
  <svg style="position: fixed;bottom:0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="#0099ff" fill-opacity="0.64" d="M0,64L40,90.7C80,117,160,171,240,170.7C320,171,400,117,480,117.3C560,117,640,171,720,165.3C800,160,880,96,960,101.3C1040,107,1120,181,1200,176C1280,171,1360,85,1400,42.7L1440,0L1440,320L1400,320C1360,320,1280,320,1200,320C1120,320,1040,320,960,320C880,320,800,320,720,320C640,320,560,320,480,320C400,320,320,320,240,320C160,320,80,320,40,320L0,320Z"></path></svg>
  </div>
</template>

<style>
.box{
  position: absolute;
  left: 50%;
  top: 50%;
  width: 350px;
  height: 250px;
  margin-left: -175px;
  margin-top: -200px;
  border-radius: 20px;
}

.container {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    vertical-align: middle;
}
</style>

<script>
import { defineComponent, reactive, computed, ref,onMounted } from 'vue';
import { UserOutlined, LockOutlined } from '@ant-design/icons-vue';
import { useStore } from 'vuex' // 引入useStore 方法
import {message} from 'ant-design-vue'
import {useRouter} from 'vue-router'
import axios from 'axios'
export default defineComponent({
  name: 'LoginForm',
  components: {
    UserOutlined,
    LockOutlined,
  },

  setup(props) {
    const store = useStore();
    const router = useRouter()
    const manager = ref()

    const login = () => {
      var params = new URLSearchParams();
      params.append('op', 'login');
      params.append('username', formState.username);
      params.append('password', formState.password);
      //TODO: Login
      axios.post(store.state.path + '/user.action', params)
        .then(res => {
          if (res.data.code == 1) {
            props.changeLogin()
            store.state.isCertified = true
            manager.value = {
              id: res.data.data.id,
              name: res.data.data.name,
              account: res.data.data.account,
              type: res.data.data.type
            }
            store.state.user = manager.value
            sessionStorage.setItem("manager", JSON.stringify(manager.value));
            router.push('/student/BaseInfo')
            message.success('登录成功');
          } else {
            message.success('登录失败')
          }
        })
        .catch(function (error) {
          console.log(error);
        });
    }

    const formState = reactive({
      id: 1,
      username: 'zhangsan',
      password: 'a',
      remember: true,
    });

    const onFinish = values => {
      console.log('Success:', values);
    };

    const onFinishFailed = errorInfo => {
      console.log('Failed:', errorInfo);
    };

    const disabled = computed(() => {
      return !(formState.username && formState.password);
    });

    onMounted(() => {
      if (sessionStorage.getItem("manager")) {
        manager.value = JSON.parse(sessionStorage.getItem("manager"));
        store.state.user = manager.value
        store.state.isCertified = true
        props.changeLogin()
        message.success('自动登录成功');
        router.push('/student/BaseInfo')
      }
    })

    return {
      formState,
      onFinish,
      onFinishFailed,
      disabled,
      login,
    };
  },
  props: {
    changeLogin: {
      type: Function,
      default: () => {},
    },
  }
});
</script>
<style>
.box{
  justify-content: center;
 
}

#components-form-demo-normal-login .login-form {
  max-width: 300px;
}

#components-form-demo-normal-login .login-form-forgot {
  float: right;
}

#components-form-demo-normal-login .login-form-button {
  width: 100%;
}
</style>