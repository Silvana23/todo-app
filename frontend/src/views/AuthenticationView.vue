<script setup lang="ts">
import LoginForm from '@/components/common/SignInForm.vue'
import { ref, watch } from 'vue'
import SignupForm from '@/components/common/SignUpForm.vue'
import { useAuthStore } from '@/stores/auth'
import { useRoute, useRouter } from 'vue-router'
import { useNoteStore } from '@/stores/note'
import {
  createNotification,
  EStatusNotification,
  type IStatusNotification
} from '@/lib/core/StatusNotification'
import StatusNotification from '@/components/common/StatusNotification.vue'

const router = useRouter()
const route = useRoute()
const logout = route.query.logout
const signup = route.query.signup

const authStore = useAuthStore()
const noteStore = useNoteStore()

const isSignUpMode = ref(false)
const notification = ref<IStatusNotification>()

watch(notification, () => setTimeout(() => (notification.value = undefined), 5000))

if (logout) {
  authStore.setAuthToken('')
  notification.value = createNotification(EStatusNotification.INFO, 'You are now signed out.')
}

if (authStore.isAuthenticated) {
  router.push({ path: '/' })
} else {
  noteStore.setNotes([])
  notification.value = createNotification(
    EStatusNotification.WARN,
    'Sign In or Sign Up to view that page.'
  )
}

if (signup) {
  notification.value = createNotification(EStatusNotification.INFO, 'Success! You may now sign in!')
}
</script>

<template>
  <div class="container">
    <LoginForm v-if="!isSignUpMode" v-model="isSignUpMode" />
    <SignupForm v-else v-model="isSignUpMode" />
  </div>
  <StatusNotification v-if="notification !== undefined" :model-value="notification" />
</template>

<style scoped>
.container {
  display: flex;

  align-items: center;
  justify-content: center;

  width: 100dvw;
  height: 100dvh;

  overflow: hidden;
}
</style>
