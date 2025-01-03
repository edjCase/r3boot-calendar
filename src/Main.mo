import Array "mo:base/Array";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Http "Http"

actor {

  public type AddEventRequest = {
    name : Text;
    description : Text;
    time : Nat;
    location : Text;
    duration : ?Nat;
  };

  public type Event = {
    name : Text;
    description : Text;
    time : Nat;
    location : Text;
    duration : ?Nat;
  };

  public type EventStableData = {
    events : [Event];
  };

  class EventHandler(data : EventStableData) {
    var events = data.events;

    public func add(request : AddEventRequest) {
      events := Array.append(events, [request]);
    };

    public func get() : [Event] {
      events;
    };

    public func toStableData() : EventStableData {
      { events = events };
    };
  };

  stable var eventData : EventStableData = {
    events = [];
  };

  var eventHandler = EventHandler(eventData);

  public func addEvent(request : AddEventRequest) : async Result.Result<(), Text> {
    eventHandler.add(request);
    #ok();
  };

  public func getEvents() : async Result.Result<[Event], Text> {
    #ok(eventHandler.get());
  };

  public query func http_request(req : Http.Request) : async Http.Response {
    var html = "<table>";

    for (event in eventHandler.get().vals()) {
      html #= "<tr>";
      html #= "<td>" # event.name # "</td>";
      html #= "<td>" # event.description # "</td>";
      html #= "<td>" # Nat.toText(event.time) # "</td>";
      html #= "<td>" # event.location # "</td>";
      html #= "<td>" # Nat.toText(Option.get(event.duration, 0)) # "</td>";
      html #= "</tr>";
    };

    html #= "</table>";

    {
      body = Text.encodeUtf8(html);
      headers = [("Content-Type", "text/plain")];
      status_code = Http.Status.OK;
    };
  };

};
