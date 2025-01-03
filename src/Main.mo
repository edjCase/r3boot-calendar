import Result "mo:base/Result";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Http "Http";
import EventHandler "Handlers/EventHandler";
import Types "Types";

actor : Types.MainActor {

  stable var eventData : EventHandler.StableData = {
    events = [];
  };

  var eventHandler = EventHandler.EventHandler(eventData);

  public func addEvent(request : Types.AddEventRequest) : async Result.Result<(), Text> {
    eventHandler.add(request);
    #ok();
  };

  public func getEvents() : async Result.Result<[EventHandler.Event], Text> {
    #ok(eventHandler.get());
  };

  public query func http_request(req : Http.Request) : async Http.Response {
    var html = "<table>";
    html #= "<tr><th>Name</th><th>Description</th><th>Time</th><th>Location</th><th>Duration</th></tr>";

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
      headers = [("Content-Type", "text/html")];
      status_code = Http.Status.OK;
    };
  };

};
