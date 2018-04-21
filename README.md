# README

* POST /connect
curl -X POST -H 'Content-Type: application/json' -i http://localhost:3000/connect --data '{"friends": ["andy@example.com", "john@example.com", "taylor@example.com", "lisna@example.com"]}'

* POST /friends
curl -X POST -H 'Content-Type: application/json' -i http://localhost:3000/friends --data '{"email": "andy@example.com"}'

* POST /common_friends
curl -X POST -H 'Content-Type: application/json' -i http://localhost:3000/common_friends --data '{ "friends":["andy@example.com", "john@example.com"] }'

* POST /subscribe
curl -X POST -H 'Content-Type: application/json' -i http://localhost:3000/subscribe --data '{"requestor": "lisa@example.com", "target": "john@example.com"}'

* POST /block
curl -X POST -H 'Content-Type: application/json' -i http://localhost:3000/block --data '{"requestor": "lisa@example.com", "target": "john@example.com"}'

* POST /send_email
curl -X POST -H 'Content-Type: application/json' -i http://localhost:3000/send_email --data '{"sender": "john@example.com","text": "Hello World! kate@example.com"}'
