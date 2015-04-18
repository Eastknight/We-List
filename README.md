#We-List -- A to-do List web app

*Main Features:*
--------------

- Keep things to do for you.
- Automatically delete the things you put off over one week.
- You can use this app through command line by external API.
- Click [here](http://we-list-leichen.herokuapp.com/) to see online app.

*API Version:*
--------------

1.0.0

*API:*
--------------

- Sign up user:
```
curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST http://we-list-leichen.herokuapp.com/users -d '{"user" : {"email" : "youremail", "password": "yourpassword", "name": "Eastknight"}}'
```

- Sign in user:
```
curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST http://we-list-leichen.herokuapp.com/users/sign_in -d '{"user" : {"email": "youremail", "password": "yourpassword"}}'
```
***After signing in, you'll get an authentication token. This is your private key. Use it in your request header as well as your email address, and keep it safe!***

- Create new list:
```
curl -H "Accept: application/json" -H "Content-type: application/json" -H "X-API-EMAIL: youremail" -H "X-API-TOKEN: your_authentication_token" -X POST http://we-list-leichen.herokuapp.com/api/v1/lists -d '{"list": {"title" : "New List"}}'
```

- Sign out user:
```
curl -H "Accept: application/json" -H "Content-type: application/json" -H "X-API-EMAIL: youremail" -H "X-API-TOKEN: your_authentication_token" -X DELETE http://we-list-leichen.herokuapp.com/users/sign_out
```
***After signing out, your authentication token will expire.***


*All API paths:*
------------------

| API action              | HTTP Verb | API path                                                           |
|:-----------------------:|:---------:|:------------------------------------------------------------------:|
| user sign up            | POST      | http://we-list-leichen.herokuapp.com/users                         |
| user sign in            | POST      | http://we-list-leichen.herokuapp.com/users/sign_in                 |
| user sign out           | DELETE    | http://we-list-leichen.herokuapp.com/users/sign_out                |
| show all your lists     | GET       | http://we-list-leichen.herokuapp.com/api/v1/lists                  |
| create new list         | POST      | http://we-list-leichen.herokuapp.com/api/v1/lists                  |
| show list               | GET       | http://we-list-leichen.herokuapp.com/api/v1/lists/:list_id         |
| show list preview       | GET       | http://we-list-leichen.herokuapp.com/api/v1/lists/:list_id/preview |
| change list             | PUT/PATCH | http://we-list-leichen.herokuapp.com/api/v1/lists/:list_id         |
| delete list             | DELETE    | http://we-list-leichen.herokuapp.com/api/v1/lists/:list_id         |
| show todo items of list | GET       | http://we-list-leichen.herokuapp.com/api/v1/lists/:list_id/items   |
| create new todo item    | POST      | http://we-list-leichen.herokuapp.com/api/v1/lists/:list_id/items   |
| show item               | GET       | http://we-list-leichen.herokuapp.com/api/v1/items/:item_id         |
| change item             | PUT/PATCH | http://we-list-leichen.herokuapp.com/api/v1/items/:item_id         |
| delete item             | DELETE    | http://we-list-leichen.herokuapp.com/api/v1/items/:item_id         |

