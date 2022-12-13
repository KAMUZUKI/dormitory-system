<template>
    <div class="table">
        <a-table style="min-width:1000px" :columns="columns" :data-source="dataSource" bordered>
            <template #bodyCell="{ column, record }">
                <template v-if="column.dataIndex === 'status'">
                    <a-switch @click="showConfirm" v-model:checked="record.status" checked-children="开"
                        un-checked-children="关" />
                </template>
            </template>
        </a-table>
    </div>
</template>
<script>
import { cloneDeep } from 'lodash-es';
import { ExclamationCircleOutlined } from '@ant-design/icons-vue';
import { Modal } from 'ant-design-vue';
import { defineComponent, reactive, ref, onMounted,createVNode } from 'vue';
import { message } from 'ant-design-vue';
import axios from 'axios'
import { useStore } from 'vuex';
export default defineComponent({
    name: 'AdminInfo',
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
            title: '账号',
            dataIndex: 'account',
            width: 15,
        }, {
            title: '角色',
            dataIndex: 'type',
            width: 15,
        }, {
            title: '状态',
            dataIndex: 'status',
            key: 'status',
            width: 15,
        }];

        const dataSource = ref([]);
        const listDataTmp = ref([]);

        const initDataSource = () => {
            //TODO:获取数据
            var params = new URLSearchParams()
            params.append('op', 'getAllManager')
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        listDataTmp.value = res.data.data
                        for (const [key, item] of Object.entries(listDataTmp.value)) {
                            console.log(key)
                            // if (item.status == 1) {
                            //     item.status = "开启"
                            // } else {
                            //     item.status = "禁用"
                            // }
                            dataSource.value.push(item);
                        }
                        message.success('获取管理员信息成功')
                    } else {
                        message.error('获取管理员信息失败')
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

        const cancel = key => {
            delete editableData[key];
        }

        const showConfirm = () => {
            Modal.confirm({
                title: 'Do you want to delete these items?',
                icon: createVNode(ExclamationCircleOutlined),
                content: 'When clicked the OK button, this dialog will be closed after 1 second',
                async onOk() {
                    try {
                    return new Promise((resolve, reject) => {
                      setTimeout(Math.random()>0.5? resolve:reject, 1000);
                    });
                  } catch(e) {
                    return console.log('Oops errors!');
                  }
                },
                onCancel() { },
            });
        };

        onMounted(() => {
            initDataSource()
        })

        return {
            dataSource,
            columns,
            editingKey: '',
            editableData,
            edit,
            cancel,
            showConfirm,
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