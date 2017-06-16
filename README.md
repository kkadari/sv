# tvh-api-checking

Contains API checks for all endpoints in Jive to assess whether extensions to Jive have been unintentionally changed. To run the API checks it requires CSRF to be turned off by calling ```jive.rest.internal.csrf.token.enabled = false```

To run the framework run the following:

```
export base_url=http://dev15:8080 (or whichever url you require)
rake integration
```
