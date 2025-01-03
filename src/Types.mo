import Result "mo:base/Result";
import EventHandler "Handlers/EventHandler";
module {

    public type MainActor = actor {
        addEvent : (AddEventRequest) -> async Result.Result<(), Text>;
        getEvents : () -> async Result.Result<[EventHandler.Event], Text>;
    };

    public type AddEventRequest = {
        name : Text;
        description : Text;
        time : Nat;
        location : Text;
        duration : ?Nat;
    };
};
