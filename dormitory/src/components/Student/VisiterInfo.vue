<template>
    <div class="table">
        <a-button style="float:left;margin-left: 20px;margin-top: 20px;" type="primary"
            @click="showDrawer">添加来访信息</a-button>
        <a-table style="min-width:1000px" :columns="columns" :data-source="dataSource" bordered>
            <template #bodyCell="{ column, text, record }">
                <template v-if="['status', 'type'].includes(column.dataIndex)">
                    <div>
                        <a-input v-if="editableData[record.sno]"
                            v-model:value="editableData[record.sno][column.dataIndex]" style="margin: -5px 0" />
                        <template v-else>
                            {{ text }}
                        </template>
                    </div>
                </template>
                <template v-else-if="column.dataIndex === 'modify'">
                    <div class="editable-row-operations">
                        <span v-if="editableData[record.sno]">
                            <a-typography-link @click="save(record)">保存</a-typography-link>
                            <a-popconfirm title="确认取消?" @confirm="cancel(record.sno)">
                                <a>取消</a>
                            </a-popconfirm>
                        </span>
                        <span v-else>
                            <a @click="edit(record.sno)">编辑</a>
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
        <a-drawer title="添加来访信息" :width="300" :visible="visible" :body-style="{ paddingBottom: '80px' }"
            :footer-style="{ textAlign: 'right' }" @close="onClose">
            <a-form :model="formState" name="nest-messages" @finish="onFinish" @onFinishFailed="onFinishFailed"
                :validate-messages="validateMessages">
                <a-form-item :name="['visiter', 'name']" label="名字" :rules="[{ required: true, message: '填写来访者名字' }]">
                    <a-input v-model:value="formState.visiter.name" />
                </a-form-item>
                <a-form-item :name="['visiter', 'phone']" label="手机号" :rules="[{ required: true, message: '手机号' }]">
                    <a-input v-model:value="formState.visiter.phone" />
                </a-form-item>
                <a-form-item :name="['visiter', 'purpose']" label="目的" :rules="[{ required: true, message: '目的' }]">
                    <a-textarea v-model:value="formState.visiter.purpose" />
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
    name: 'VisiterInfo',
    setup() {
        const store = useStore();
        const columns = [{
            title: '编号',
            width: 15,
            dataIndex: 'id',
        }, {
            title: '名字',
            width: 25,
            dataIndex: 'name',
        }, {
            title: '电话',
            dataIndex: 'phone',
            width: 30,
        }, {
            title: '目的',
            dataIndex: 'purpose',
            width: 15,
        }, {
            title: '进入时间',
            dataIndex: 'createTime',
            width: 15,
        }, {
            title: '管理员',
            dataIndex: 'managername',
            width: 15,
        }];

        const dataSource = ref([]);
        const listDataTmp = ref([]);

        const formState = reactive({
            visiter: {
                name: '',
                phone: '',
                purpose: '',
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

        const initDataSource = () => {
            //TODO:获取数据
            var params = new URLSearchParams()
            params.append('op', 'getAllVisiter')
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        listDataTmp.value = res.data.data
                        for (const [key, item] of Object.entries(listDataTmp.value)) {
                            console.log(key)
                            dataSource.value.push(item);
                        }
                        message.success('获取来访者信息成功')
                    } else {
                        message.error('获取来访者信息失败')
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
            console.log(user)
        }

        const cancel = key => {
            delete editableData[key];
        }

        const deleteById = userId => {
            console.log(userId)
        }

        const onFinish = (values) => {
            console.log(values)
            var params = new URLSearchParams();
            params.append('op', 'addVisiter');
            params.append('name', formState.visiter.name);
            params.append('phone', formState.visiter.phone)
            params.append('purpose', formState.visiter.purpose)
            params.append('managername', JSON.parse(sessionStorage.getItem("manager")).id)
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        dataSource.value.push({
                            name: formState.visiter.name,
                            phone: formState.visiter.phone,
                            purpose: formState.visiter.purpose,
                            managername: JSON.parse(sessionStorage.getItem("manager")).name,
                        })
                        formState.visiter.name = ''
                        formState.visiter.phone = ''
                        formState.visiter.purpose = ''
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