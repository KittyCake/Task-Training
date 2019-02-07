# README

## Try it on heroku
[https://task-training.herokuapp.com](https://task-training.herokuapp.com)

## Set up
To run this project, download it locally and run:
```
bundle install
rails db::migrate
rails s
```
And see the result on [http://localhost:3000](http://localhost:3000)


## Table schema
* Table 1: User
id
string name
string password


* Table 2: Task
id
string title
text content
string priority
datetime endtime
string status
text tags
bigint user_id
