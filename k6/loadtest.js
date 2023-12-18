import http from 'k6/http';
import { sleep, check  } from 'k6';
import { SharedArray } from 'k6/data';

export let options = {
  stages: [
      { duration: '20s', target: 4000 },
      { duration: '30s', target: 4000 },
      { duration: '20s', target: 0 },
      { duration: '3s', target: 4000 },
      { duration: '3s', target: 20 },
      { duration: '3s', target: 2000 },
      { duration: '3s', target: 20 }, 
  ],
  thresholds: {
      http_req_duration: ['p(95)<600'], // 95% of requests should be below 500ms
  },
};

// Function to generate user credentials
// function generateUsers(numUsers) {
//   let users = [];
//   for (let i = 0; i < numUsers; i++) {
//       users.push({
//           username: `user${i}`,
//           password: `pass${i}`
//       });
//   }
//   return users;
// }

// Create a SharedArray of users
// const credentials = new SharedArray("user_credentials", function () {
//   return generateUsers(4000); // Generate 100 users, for example
// });

export default function () {
  
  if (__ENV.MY_HOSTNAME) {
    // http.get(`http://${__ENV.MY_HOSTNAME}`);
    // http.get(`http://${__ENV.MY_HOSTNAME}/health`);
    let res = http.get(`http://${__ENV.MY_HOSTNAME}`, { /* Your payload here */ });
    check(res, { 'ok': (r) => r.status === 200 });
  };

  
  // if (__ENV.MY_HOSTNAME2) {
  //  http.get(`http://${__ENV.MY_HOSTNAME2}`);
  // };

  sleep(1);

  // const url = `http://${__ENV.MY_HOSTNAME}/login`;
  
  // var user = credentials[__VU % credentials.length];

  // var payload = JSON.stringify({ username: user.username, password: user.password });

  // const params = {
  //   headers: {
  //     'Content-Type': 'application/json',
  //   },
  // };

  // http.post(url, payload, params);
}