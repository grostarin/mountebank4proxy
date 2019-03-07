# Mountebank4proxy

This project is an utility to easily obtain mockup data to build custom mockups server.

Mockup server have to be construct using [mountebank4mockup](http://gitlab.oney.fr/PRD_LGCL/test-management/mountebank4mockup).

It is based on [Mountebank](http://www.mbtest.org/), a restful application : Mountebank's ressources are legion of "imposters"; Each "imposter" aims at simulate or record webservice request/response.

## Note on config/imposters.json

This setting are set by default for proxy behavior :

- "addWaitBehavior": "true" add waited time for each request / response. Usefull to simulate ws performance.
- "Accept-Encoding": "identity" force data recorded clearly (not compressed).

## Build

Docker build don't need any specific arguments

```bash
docker build --rm -t mountebank4proxy:latest <THIS_PROJECT_DIR>
```

## Run

``` bash
docker run --name mountebank4proxy --restart always -d \
-p 2525:2525 \
-p 8080:8080 \
-e http_proxy=*** \
-e https_proxy=*** \
-e no_proxy=*** \
-e MOUNTEBANK_PROXY_TO=<URL_OF_WEBSERVICE_PROXIED> \
<IMAGE_NAME>:<IMAGE_TAG>
```

NB :

- <URL_OF_WEBSERVICE_PROXIED> is the URL of proxied Web Service.
- 2525 is the port when mountebank ui (use to retrieve requests / responses).
- 8080 is when imposter records webservice request and response.

## Credits

[Mountebank project](https://github.com/bbyars/mountebank)

[Mountebank docker project](https://github.com/andyrbell/mountebank)