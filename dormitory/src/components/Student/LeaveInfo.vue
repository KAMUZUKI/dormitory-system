<template>
    <div class="table">
        <a-button style="float:left;margin-left: 20px;margin-top: 20px;" type="primary"
            @click="showDrawer">添加离校信息</a-button>
        <a-table style="min-width:1000px" :columns="columns" :data-source="dataSource" bordered>
            <template #bodyCell="{ column, text, record }">
                <template v-if="['status', 'type'].includes(column.dataIndex)">
                    <div>
                        <a-input v-if="editableData[record.id]"
                            v-model:value="editableData[record.id][column.dataIndex]" style="margin: -5px 0" />
                        <template v-else>
                            {{ text }}
                        </template>
                    </div>
                </template>
                <template v-else-if="column.dataIndex === 'modify'">
                    <div class="editable-row-operations">
                        <span v-if="editableData[record.id]">
                            <a-typography-link @click="save(record)">保存</a-typography-link>
                            <a-popconfirm title="确认取消?" @confirm="cancel(record.id)">
                                <a>取消</a>
                            </a-popconfirm>
                        </span>
                        <span v-else>
                            <a @click="edit(record.id)">编辑</a>
                        </span>
                    </div>
                </template>
                <template v-else-if="column.dataIndex === 'delete'">
                    <div class="editable-row-operations">
                        <span>
                            <a-popconfirm title="确认删除?" ok-text="删除" cancel-text="取消" @confirm="deleteById(record.id)">
                                <a>删除</a>
                            </a-popconfirm>
                        </span>
                    </div>
                </template>
            </template>
        </a-table>
        <a-drawer title="添加离校信息" :width="300" 
            :visible="visible" 
            :body-style="{ paddingBottom: '80px' }"
            :footer-style="{ textAlign: 'right' }" @close="onClose">
            <a-form :model="formState" name="nest-messages" @finish="onFinish" @onFinishFailed="onFinishFailed"
                :validate-messages="validateMessages">
                <a-form-item :name="['leaveschool', 'sno']" label="学号" :rules="[{ required: true, message: '填写学生学号' }]">
                    <a-input v-model:value="formState.leaveschool.sno" />
                </a-form-item>
                <a-form-item :name="['leaveschool', 'purpose']" label="目的"
                    :rules="[{ required: true, message: '填写目的' }]">
                    <a-textarea v-model:value="formState.leaveschool.purpose" />
                </a-form-item>
                <a-form-item :name="['leaveschool', 'leavetime']" label="离校时间" :rules="[{ required: true, message: '选择日期' }]">
                    <a-date-picker v-model:value="formState.leaveschool.leavetime" show-time format="YYYY-MM-DD HH:mm:ss"
                        value-format="YYYY-MM-DD HH:mm:ss" />
                </a-form-item>
                <a-form-item :name="['leaveschool', 'backtime']" label="返校时间" :rules="[{ required: true, message: '选择日期' }]">
                    <a-date-picker v-model:value="formState.leaveschool.backtime" show-time format="YYYY-MM-DD HH:mm:ss"
                        value-format="YYYY-MM-DD HH:mm:ss" />
                </a-form-item>
                <a-form-item>
                    <a-button shape="round" type="primary" html-type="submit">提交</a-button>
                </a-form-item>
            </a-form>
        </a-drawer>
    </div>
</template>
<script>
import { cloneDeep } from 'lodash-es';
import { defineComponent, reactive, ref, onMounted } from 'vue';
import { message } from 'ant-design-vue';
import axios from 'axios'
import { useStore } from 'vuex';
export default defineComponent({
    name: 'LeaveInfo',
    setup() {
        const store = useStore();
        const columns = [{
            title: '编号',
            width: 15,
            dataIndex: 'id',
        }, {
            title: '学号',
            width: 25,
            dataIndex: 'sno',
        }, {
            title: '名字',
            dataIndex: 'sname',
            width: 35,
        }, {
            title: '电话',
            dataIndex: 'phone',
            width: 40,
        }, {
            title: '目的',
            dataIndex: 'purpose',
            width: 60,
        }, {
            title: '离校时间',
            dataIndex: 'leaveTime',
            width: 50,
        }, {
            title: '返校时间',
            dataIndex: 'backTime',
            width: 30,
        }, {
            title: '管理员',
            dataIndex: 'managername',
            width: 15,
        }];

        const formState = reactive({
            leaveschool: {
                sno: '',
                purpose: '',
                leavetime: '',
                backtime: '',
                managername: '',
            }
        });

        const validateMessages = {
            required: '${label} 是必要的!',
            types: {
                email: '${label} 是无效的邮箱!',
                number: '${label} 是无效的数字!',
            }
        };

        const dataSource = ref([]);
        const listDataTmp = ref([]);

        const initDataSource = () => {
            //TODO:获取数据
            var params = new URLSearchParams()
            params.append('op', 'getAllLeaveschool')
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        listDataTmp.value = res.data.data
                        for (const [key, item] of Object.entries(listDataTmp.value)) {
                            console.log(key)
                            dataSource.value.push(item);
                        }
                        message.success('获取离校信息成功')
                    } else {
                        message.error('获取离校信息失败')
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
        }

        const editableData = reactive({});

        const edit = key => {
            editableData[key] = cloneDeep(dataSource.value.filter(item => key === item.id)[0]);
        }

        const save = user => {
            // Object.assign(dataSource.value.filter(item => user.id === item.id)[0], editableData[user.id]);
            // delete editableData[user.id];
            // //TODO:通过userid修改后台用户数据
            // setTimeout(() => {
            //     var params = new URLSearchParams();
            //     params.append('op', 'alterUser');
            //     params.append('userId', user.id);
            //     params.append('status', user.status);
            //     params.append('type', user.type);
            //     axios.post(store.state.path + '/user.action', params)
            //         .then(res => {
            //             if (res.data.code == 1) {
            //                 delete editableData[user.id];
            //                 message.success('修改用户ID' + user.id + '成功');
            //             } else {
            //                 message.error('修改用户ID' + user.id + '失败');
            //             }
            //         })
            //         .catch(function (error) {
            //             console.log(error);
            //         });
            // }, 500);
            console.log(user)
        }

        const cancel = key => {
            delete editableData[key];
        }

        const deleteById = userId => {
            //TODO:通过userid删除后台用户数据
            // var params = new URLSearchParams();
            // params.append('op', 'deleteUser');
            // params.append('userId', userId);
            // axios.post(store.state.path + '/user.action', params)
            //     .then(res => {
            //         if (res.data.code == 1) {
            //             dataSource.value = dataSource.value.filter(item => userId !== item.id);
            //             message.success('删除用户ID' + userId + '成功');
            //         } else {
            //             message.error('删除用户ID' + userId + '失败');
            //         }
            //     })
            //     .catch(function (error) {
            //         console.log(error);
            //     });
            console.log(userId)
        }

        const onFinish = (values) => {
            console.log(values)
            var params = new URLSearchParams();
            params.append('op', 'addLeaveStudent');
            params.append('sno', formState.leaveschool.sno);
            params.append('purpose', formState.leaveschool.purpose)
            params.append('leaveTime', formState.leaveschool.leavetime)
            params.append('backTime', formState.leaveschool.backtime)
            params.append('managername', JSON.parse(sessionStorage.getItem("manager")).id)
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        dataSource.value.push({
                            sno: formState.leaveschool.sno,
                            purpose: formState.leaveschool.purpose,
                            leaveTime: formState.leaveschool.leavetime,
                            backTime: formState.leaveschool.backtime,
                            managername: JSON.parse(sessionStorage.getItem("manager")).name,
                        })
                        formState.leaveschool.sno = ''
                        formState.leaveschool.purpose = ''
                        formState.leaveschool.leavetime = ''
                        formState.leaveschool.backtime = ''
                        message.success(res.data.msg)
                    } else {
                        message.error(res.data.msg)
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
        };

        const onFinishFailed = errorInfo => {
            console.log('Failed:', errorInfo);
        };

        const layout = {
            labelCol: {
                span: 6,
            },
            wrapperCol: {
                span: 16,
            },
        };

        //DRAWER BEGIN
        const visible = ref(false);

        const showDrawer = () => {
            visible.value = true;
        };

        const onClose = () => {
            visible.value = false;
        };

        onMounted(() => {
            initDataSource()
        })

        return {
            dataSource,
            columns,
            editingKey: '',
            editableData,
            layout,
            visible,
            formState,
            validateMessages,
            edit,
            save,
            cancel,
            deleteById,
            onClose,
            showDrawer,
            onFinish,
            onFinishFailed,
        };
    },
});
</script>
<style scoped>
.editable-row-operations a {
    margin-right: 8px;
}

.container {
    min-width: 1000px;
}
</style>