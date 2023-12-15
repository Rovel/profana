import http from 'k6/http';
import { sleep } from 'k6';
import { SharedArray } from 'k6/data';

// Function to generate user credentials
function generateUsers(numUsers) {
  let users = [];
  for (let i = 0; i < numUsers; i++) {
      users.push({
          username: `user${i}`,
          password: `pass${i}`
      });
  }
  return users;
}

// Create a SharedArray of users
const credentials = new SharedArray("user_credentials", function () {
  return generateUsers(4000); // Generate 100 users, for example
});

export default function () {
  http.get(`http://${__ENV.MY_HOSTNAME}/health`);
  sleep(1);

  const url = `http://${__ENV.MY_HOSTNAME}/login`;
  
  var user = credentials[__VU % credentials.length];

  var payload = JSON.stringify({ username: user.username, password: user.password });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  http.post(url, payload, params);
}