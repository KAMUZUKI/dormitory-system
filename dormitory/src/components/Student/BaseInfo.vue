<template>
    <div class="table">
        <div style="width: 100%;display:inline">
            <a-button style="float:left;margin-left: 60px;margin-top: 20px;" type="primary"
                @click="showDrawer">添加学生</a-button>
        </div>
        <a-table style="min-width:1000px" :columns="columns" :data-source="dataSource" bordered>
            <template #bodyCell="{ column, text, record }">
                <template v-if="['address', 'phone'].includes(column.dataIndex)">
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
                            <a-popconfirm title="确认删除?" ok-text="删除" cancel-text="取消" @confirm="deleteById(record.sno)">
                                <a>删除</a>
                            </a-popconfirm>
                        </span>
                    </div>
                </template>
            </template>
        </a-table>
        <a-drawer title="添加学生" :width="300" :visible="visible" :body-style="{ paddingBottom: '80px' }"
            :footer-style="{ textAlign: 'right' }" @close="onClose">
            <a-form :model="formState" name="nest-messages" 
                @finish="onFinish" 
                @onFinishFailed="onFinishFailed"
                :validate-messages="validateMessages">
                <a-form-item :name="['student', 'sname']" label="名字" :rules="[{ required: true, message: '填写学生名字' }]">
                    <a-input v-model:value="formState.student.sname" />
                </a-form-item>
                <a-form-item :name="['student', 'age']" label="年龄" :rules="[{  required: true,type: 'number', min: 10, max: 30, message: '年龄在10-30之间'}]">
                    <a-input-number v-model:value="formState.student.age" />
                </a-form-item>
                <a-form-item :name="['student', 'sex']" label="性别" :rules="[{ required: true, message: '选择性别' }]">
                    <a-radio-group v-model:value="formState.student.sex">
                      <a-radio value="1">男</a-radio>
                      <a-radio value="0">女</a-radio>
                    </a-radio-group>
                </a-form-item>
                <a-form-item :name="['student', 'academy']" label="学院名称" :rules="[{ required: true, message: '选择学院' }]">
                    <a-select showSearch v-model:value="formState.student.academy" smode="single" style="width: 100%"
                        placeholder="请选择学院" :options="academys">
                    </a-select>
                </a-form-item>
                <a-form-item :name="['student', 'classname']" label="班级名称" :rules="[{ required: true, message: '填写班级名称' }]">
                    <a-input v-model:value="formState.student.classname" />
                </a-form-item>
                <a-form-item :name="['student', 'address']" label="住宿地址" :rules="[{ required: true, message: '填写住宿地址' }]">
                    <a-input v-model:value="formState.student.address" />
                </a-form-item>
                <a-form-item :name="['student', 'phone']" label="手机号" :rules="[{ required: true, message: '填写手机号' }]">
                    <a-input v-model:value="formState.student.phone" />
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
    name: 'BaseInfo',
    setup() {
        const store = useStore();
        const academys = ref([]);
        const columns = [{
            title: '学号',
            width: 10,
            dataIndex: 'sno',
        }, {
            title: '名字',
            width: 10,
            dataIndex: 'sname',
        }, {
            title: '年龄',
            dataIndex: 'age',
            width: 10,
        }, {
            title: '性别',
            dataIndex: 'sex',
            width: 10,
        }, {
            title: '学院',
            dataIndex: 'academy',
            width: 60,
        }, {
            title: '班级',
            dataIndex: 'classname',
            width: 20,
        }, {
            title: '住址',
            dataIndex: 'address',
            width: 50,
        }, {
            title: '电话',
            dataIndex: 'phone',
            width: 30,
        }, {
            title: '操作',
            dataIndex: 'modify',
            width: 15,
        }, {
            title: '操作',
            dataIndex: 'delete',
            width: 15,
        }];

        const formState = reactive({
            student: {
                sname: '',
                age: '',
                sex: '',
                academy: '',
                classname: '',
                address: '',
                phone: '',
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

        const getAcademys = () => {
            const tmpData = ref([])
            var params = new URLSearchParams();
            params.append('op', 'getAllAcademy');
            //TODO: 从后台获取分类
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        tmpData.value = res.data.data
                        for (var i = 0; i < tmpData.value.length; i++) {
                            academys.value.push({index: i, value:tmpData.value[i].aname})
                        }
                        sessionStorage.setItem('academys', JSON.stringify(academys.value))
                    } else {
                        console.log(res.data.msg)
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
        }


        const initDataSource = () => {
            //TODO:获取数据
            var params = new URLSearchParams()
            params.append('op', 'getAllStudent')
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        listDataTmp.value = res.data.data
                        for (const [key, item] of Object.entries(listDataTmp.value)) {
                            key;
                            if (item.sex==true) {
                                item.sex = '男'
                            }else{
                                item.sex = '女'
                            }
                            dataSource.value.push(item);
                        }
                        message.success('获取学生信息成功')
                    } else {
                        message.error('获取学生信息失败')
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
        }

        const editableData = reactive({});

        const edit = key => {
            editableData[key] = cloneDeep(dataSource.value.filter(item => key === item.sno)[0]);
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

        const deleteById = sno => {
            //TODO:通过sno删除后台用户数据
            var params = new URLSearchParams();
            params.append('op', 'deleteStudentBySno');
            params.append('sno', sno);
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        dataSource.value = dataSource.value.filter(item => sno !== item.sno);
                        message.success(res.data.msg);
                    } else {
                        message.error(res.data.msg);
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
        }

        const onFinish = (values) => {
            console.log(values)
            var params = new URLSearchParams();
            params.append('op', 'addStudent');
            params.append('sname', formState.student.sname);
            params.append('age', formState.student.age)
            params.append('sex', formState.student.sex==0?false:true)
            params.append('academy', formState.student.academy)
            params.append('classname', formState.student.classname)
            params.append('address', formState.student.address)
            params.append('phone', formState.student.phone)
            axios.post(store.state.path + '/info.action', params)
                .then(res => {
                    if (res.data.code == 1) {
                        dataSource.value.push({
                            sname: formState.student.sname,
                            age: formState.student.age,
                            sex: formState.student.sex,
                            academy: formState.student.academy,
                            classname: formState.student.classname,
                            address: formState.student.address,
                            phone: formState.student.phone,
                        })
                        formState.student.sname = ''
                        formState.student.age = ''
                        formState.student.sex = ''
                        formState.student.academy = ''
                        formState.student.classname = ''
                        formState.student.address = ''
                        formState.student.phone = ''
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
            getAcademys()
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
            academys,
            edit,
            save,
            cancel,
            deleteById,
            confirm,
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
</style>