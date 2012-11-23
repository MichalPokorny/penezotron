Penezotron
==========

Penezotron is a simple Rails app I wrote to keep track of debts
roommates have with each other. It has a "global money pool" philosophy:
when person A owes person B $100 and person B owes person C $150, it
assumes it can track it the same as if person A owed person C $50.

It is usable only on small-scale setups, because:
* Every user can add users and transactions. Transaction authors aren't tracked.
* Everyone can add transactions in the name of any other user.
* All debt calculations are O(N). They could be O(1) with trivial caching.

I also have no reason to think that Penezotron doesn't drop user data
whenever it feels like it. You shouldn't ever use it unless you don't care.

Licence: GPL
