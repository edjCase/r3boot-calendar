import Array "mo:base/Array";
module {

    public type Event = {
        name : Text;
        description : Text;
        time : Nat;
        location : Text;
        duration : ?Nat;
    };

    public type StableData = {
        events : [Event];
    };
    public class EventHandler(data : StableData) {
        var events = data.events;

        public func add(request : Event) {
            events := Array.append(events, [request]);
        };

        public func get() : [Event] {
            events;
        };

        public func toStableData() : StableData {
            { events = events };
        };
    };
};
