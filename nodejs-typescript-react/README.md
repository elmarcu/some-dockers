
# small project with ReactJS as frontend and Typescript as backend

backend
```
cd backend && npm install \
    && npm outdated \
    && npm update \
    && npm install --save-dev @types/express \
    && npm install --save-dev @types/cors \
    && npm install mongodb
```


frontend
```
npx create-react-app frontend --template typescript && npm install --save-dev axios
```

docker up
```
docker-composse up --build
```
