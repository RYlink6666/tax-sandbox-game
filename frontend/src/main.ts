/**
 * 税务风险沙盘游戏 - 前端主入口
 * Vue 3 + TypeScript
 * v1.0 正式版本
 */

import { createApp } from 'vue';
import { createPinia } from 'pinia';
import App from './App.vue';
import router from './router';

// 全局样式
import './style.css';

// 创建Vue应用
const app = createApp(App);

// 使用插件
app.use(createPinia());
app.use(router);

// 全局配置
const apiBase = import.meta.env.VITE_API_BASE || 'http://localhost:3001/api';
const wsBase = (import.meta.env.VITE_API_BASE || 'http://localhost:3001/api').replace('http://', 'ws://').replace('https://', 'wss://').replace('/api', '');

app.config.globalProperties.$apiUrl = apiBase;
app.config.globalProperties.$wsUrl = wsBase;
app.config.globalProperties.$apiBase = apiBase;

// 挂载应用
app.mount('#app');
