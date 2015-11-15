# SYNTAX
- Use `CoLabs.methods` instead of `Meteor.methods`,
this will allow us to find all of our methods in `CoLabs.<methodName>`
- Prefer spaces over parentheses

Example expressions:
```
result = 3 + Math.pow 2, 4
```

```
myFunc = (arg1, arg2, argn...) ->
  # For longer comments, keep them on their own line
  arg1 * arg2 / ( argn[0] + argn[1] ) # don't write return
```

```
anyEmailVerified = (user) ->
  if not user? then false
  else if user.emails.any (e) -> e.verified then true
  else false
```
# METEOR SPECIFIC
- Subscribes should be done per template within the `onCreated` function
- If a `Session` variable is being set for the first time on page load,
that variable should be set as data in the router