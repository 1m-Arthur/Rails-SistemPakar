# Rails Postgres Sistem Pakar Linebot

[Research Journal](http://eprints.ums.ac.id/51223/1/NASKAH%20PUBLIKASI_L200130131.pdf)
with some modification on database structure. for simplify :D

## What's Rails?

Rails is a web-application framework that includes everything needed to
create database-backed web applications according to the
[Model-View-Controller (MVC)](https://en.wikipedia.org/wiki/Model-view-controller)
pattern.

Understanding the MVC pattern is key to understanding Rails. MVC divides your
application into three layers: Model, View, and Controller, each with a specific responsibility.

## Getting Started

```
# modify .env file
LINE_CHANNEL_SECRET = "YOUR CHANNEL SECRET"
LINE_CHANNEL_TOKEN = "YOUR CHANNEL TOKEN"
```
```
$ bundle install #install all needed bundle
$ rake db:create #run db migrate
$ rake db:migrate #run schema migration
$ rails s #run app
```

## License

Ruby on Rails is released under the [MIT License](https://opensource.org/licenses/MIT).
