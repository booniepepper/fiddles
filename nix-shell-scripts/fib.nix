#!/usr/bin/env -S nix eval --offline --raw -f
with builtins; let
  n = let
    n = getEnv "n";
  in
    if n != ""
    then fromJSON n
    else trace "USAGE: n=N fib.nix" 0;
  fib = {
    n,
    acc,
    a,
    b,
  }:
    if n < 1
    then acc
    else let
      c = a + b;
    in
      fib {
        n = n - 1;
        acc = acc ++ [c];
        a = b;
        b = c;
      };
in
  toJSON (if n < 1
  then []
  else if n == 1
  then [1]
  else
    fib {
      n = n - 2;
      acc = [1 1];
      a = 1;
      b = 1;
    })
