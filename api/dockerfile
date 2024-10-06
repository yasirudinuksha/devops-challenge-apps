
FROM node:18

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

# Set environment variables (these will be overridden by config maps)
ENV PORT=5000

EXPOSE 5000

# Run the API
CMD ["npm", "start"]
