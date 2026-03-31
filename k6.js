import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { target: 1000, duration: '1m' },
    { target: 5000, duration: '10m'},
  ],
};

export default function () {
  const res = http.get('http://taskoverflow-391819354.us-east-1.elb.amazonaws.com');
  check(res, {
    'is status 200': (r) => r.status === 200,
  });
  sleep(1);
}