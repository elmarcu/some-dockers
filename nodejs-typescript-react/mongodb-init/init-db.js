// init-db.js: MongoDB initialization script

db = db.getSiblingDB('usersdb');  // Create or select the 'usersdb' database

// Insert sample users
db.users.insertMany([
  { name: 'John Doe', email: 'john@example.com' },
  { name: 'Jane Doe', email: 'jane@example.com' },
  { name: 'Alice Smith', email: 'alice@example.com' },
  { name: 'Bob Johnson', email: 'bob@example.com' }
]);

print('Sample users added to the database!');
