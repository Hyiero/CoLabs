Accounts.validateLoginAttempt (attempt) ->
  if(attempt.user && attempt.user.emails && !attempt.user.emails[0].verified)
    console.log('Email is not verified, go verify it retard')
    false
  else
    true