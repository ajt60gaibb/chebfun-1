function pass = test_constructor( )

% Can we make a ballfun object:
n = 10; 
f = ballfun( ones(n,n,n) );
g = ballfunv(f,f,f);
pass(1) = 1;
end