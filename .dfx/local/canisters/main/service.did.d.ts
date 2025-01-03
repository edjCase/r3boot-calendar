import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface AddEventRequest {
  'duration' : [] | [bigint],
  'name' : string,
  'time' : bigint,
  'description' : string,
  'location' : string,
}
export interface Event {
  'duration' : [] | [bigint],
  'name' : string,
  'time' : bigint,
  'description' : string,
  'location' : string,
}
export type HeaderField = [string, string];
export type Method = string;
export interface Request {
  'url' : string,
  'method' : Method,
  'body' : Uint8Array | number[],
  'headers' : Array<HeaderField>,
}
export interface Response {
  'body' : Uint8Array | number[],
  'headers' : Array<HeaderField>,
  'status_code' : StatusCode,
}
export type Result = { 'ok' : Array<Event> } |
  { 'err' : string };
export type Result_1 = { 'ok' : null } |
  { 'err' : string };
export type StatusCode = number;
export interface _SERVICE {
  'addEvent' : ActorMethod<[AddEventRequest], Result_1>,
  'getEvents' : ActorMethod<[], Result>,
  'http_request' : ActorMethod<[Request], Response>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
