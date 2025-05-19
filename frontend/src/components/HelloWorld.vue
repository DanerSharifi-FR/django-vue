<script setup>
import { ref, onMounted } from "vue";

const message = ref("loading...");

onMounted(async () => {
  const res = await fetch("/api/ping/");
  const data = await res.json();
  message.value = data.message;
});
</script>

<template>
  <div>
    <h1>API says: {{ message }}</h1>
  </div>
</template>
