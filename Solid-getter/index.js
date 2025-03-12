import { onSession } from 'solid-auth-fetcher'

onSession((session) => {
  if (session.loggedIn) {
    console.log(user.webId)
    session.fetch('https://example.com/resource')
  }
})
