#Agora

A public community calendar aggregator which speaks JSON.

Agora aggregates others' calendars to create a single, public interface for dealing with events. We take hosted calendars in the form of ical (others soon to come) and we turn those many ical calendars into a single restful API.


##Getting started

Agora is a ruby application built with [Sinatra](http://www.sinatrarb.com/) & [Postgres](http://www.postgresql.org/)

If you need postgres set up & are on a mac, I recommend checking out [this walkthrough](http://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/). I will try to get examples for other OS up soon.

###To Start
```bash
  git clone <this repo>
  cd <the cloned repo>
  lunchy start postgres   # or however else you want to start postgres running on  your machine
  bundle install  #install ruby dependencies
```

###To Run
```bash
  shotgun  # goofy name, just starts the server
```

###To Test
```bash
  ruby tests/test.rb
```

##How is the API structured?
We have two resources in our API:
- Sources
- Events


**Sources** are where events come from. Since we aggregate everything, and no events are added by ***US***, we need to get ahold of streams of events to aggregate. A google calendar is a source. A meetup group is a source. Anything that produces a stream of events is a source.


**Events** are pretty much what they sound like. Events come from sources. You cannot create a unique event straight from Agora, events must come from sources.

---

We populate our events database by scheduling "harvest" scripts which look at our sources to see if we have any new events. New events that are found are then added to our database.

The actions you can take on Sources and Events are:

- `GET ` **sources**
  > view all current source

- `GET ` **sources/:id**
  > view a single source

- `POST` **sources**
  > add a new source

- `PUT ` **sources**
  > update a source

- `GET ` **events**
  > view all events

- `GET ` **events/:id**
  > view a single events

**note:** searching is something we are working on, soon!


##License
Agora is MIT Licensed
