export const idlFactory = ({ IDL }) => {
  const AddEventRequest = IDL.Record({
    'duration' : IDL.Opt(IDL.Nat),
    'name' : IDL.Text,
    'time' : IDL.Nat,
    'description' : IDL.Text,
    'location' : IDL.Text,
  });
  const Result_1 = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const Event = IDL.Record({
    'duration' : IDL.Opt(IDL.Nat),
    'name' : IDL.Text,
    'time' : IDL.Nat,
    'description' : IDL.Text,
    'location' : IDL.Text,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Vec(Event), 'err' : IDL.Text });
  const Method = IDL.Text;
  const HeaderField = IDL.Tuple(IDL.Text, IDL.Text);
  const Request = IDL.Record({
    'url' : IDL.Text,
    'method' : Method,
    'body' : IDL.Vec(IDL.Nat8),
    'headers' : IDL.Vec(HeaderField),
  });
  const StatusCode = IDL.Nat16;
  const Response = IDL.Record({
    'body' : IDL.Vec(IDL.Nat8),
    'headers' : IDL.Vec(HeaderField),
    'status_code' : StatusCode,
  });
  return IDL.Service({
    'addEvent' : IDL.Func([AddEventRequest], [Result_1], []),
    'getEvents' : IDL.Func([], [Result], []),
    'http_request' : IDL.Func([Request], [Response], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
