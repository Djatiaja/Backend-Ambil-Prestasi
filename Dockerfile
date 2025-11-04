# Gunakan base image Node.js
FROM node:18-alpine

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Salin file package.json dan install dependency
COPY package*.json ./
RUN npm install --production --ignore-scripts

# Salin semua kode proyek (kecuali yang diabaikan oleh .dockerignore)
COPY . .
RUN npm run build

# Expose port (ganti sesuai kebutuhan)
EXPOSE 3000

# Jalankan aplikasi
CMD ["npm", "start"]
