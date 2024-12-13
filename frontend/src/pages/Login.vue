<template>
  <div class="login">
    <h1>Login</h1>
    <form @submit.prevent="login">
      <div>
        <label for="email">Email:</label>
        <input v-model="email" id="email" type="text" required
               @input="resetError">
      </div>
      <div>
        <label for="password">Password:</label>
        <input v-model="password" id="password" type="password" required
               @input="resetError">
      </div>
      <button type="submit">Login</button>
    </form>
    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useAuthStore } from '../store/auth'
import { useRouter } from 'vue-router'

// Reactive state
const email = ref('')
const password = ref('')
const error = ref('')

// Access auth store and router
const authStore = useAuthStore()
const router = useRouter()

// Login function
const login = async () => {
  await authStore.login(email.value, password.value, router)
  if (!authStore.isAuthenticated) {
    error.value = 'Login failed. Please check your credentials.'
  }
}

// Reset error on input
const resetError = () => {
  error.value = ''
}
</script>
