export async function fetchConfig() {
  const response = await fetch('/config/config.json');
  const config = await response.json();
  return config;
}