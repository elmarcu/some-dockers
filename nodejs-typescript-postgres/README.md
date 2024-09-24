# How to make simple Nodejs server using Typescript using a DB postgres

```
mkdir nodejs-typescript-postgres
cd nodejs-typescript-postgres

npm init -y
npm install typescript ts-node @types/node
npm install express
npm install @types/express --save-dev
npm install pg
npm install @types/pg --save-dev
npx tsc --init

docker-compose up --build
```